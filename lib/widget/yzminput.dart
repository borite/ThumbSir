import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:ThumbSir/dao/sendverifycode_dao.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/common/reg.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  fontSize: 14.0,
  color: const Color(0xFF5580EB),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  fontSize: 14.0,
  color: const Color(0xFF999999),
);

class YZMInput extends StatefulWidget {
  final String hintText;
  final String tipText;
  final String rightText;
  final String errorTipText;
  final TextEditingController controller;
  final TextEditingController yzmcontroller;
  final ValueChanged<String> onChanged;
  final inputType;
  final RegExp reg;
  const YZMInput({Key key,this.controller,this.yzmcontroller,this.onChanged,this.hintText="",this.tipText="",this.rightText="格式正确",this.errorTipText,this.inputType,this.reg});
  @override
  _YZMInputState createState() => _YZMInputState();
}

class _YZMInputState extends State<YZMInput> {
  /// 倒计时的秒数，默认60秒。
  int countdown = 60;
  /// 用户点击时的回调函数。
  Function onTapCallback;
  /// 是否可以获取验证码。
  bool available = false;

  FocusNode _focusNode = FocusNode();
  bool textBool = true;// 输入的内容是否合法
  RegExp phoneReg;
  bool phoneBool = false;
  Color tipColor = Color(0xFF2692FD);
  int tip = 0;
  String WebAPICookie;

  // 倒计时的计时器。
  Timer _timer;
  /// 当前倒计时的秒数。
  int _seconds;
  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;
  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    phoneReg = telPhoneReg;
    _seconds = countdown;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField失去焦点
        setState(() {
          textBool = this.widget.reg.hasMatch(this.widget.yzmcontroller.text);
        });
        if(textBool == true){
          setState(() {
            tipColor = Color(0xFF2692FD);
          });
        }else if(textBool == false ){
          setState(() {
            tipColor = Color(0xFFF24848);
          });
        }
      }
    });
    super.initState();
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (timer) {
          if (_seconds == 0) {
            _cancelTimer();
            _seconds = countdown;
            inkWellStyle = _availableStyle;
            setState(() {});
            return;
          }
          _seconds--;
          _verifyStr = '已发送$_seconds'+'s';
          setState(() {});
          if (_seconds == 0) {
            _verifyStr = '重新发送';
          }
        });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 335,
                height: 40,
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: widget.yzmcontroller,
                  autofocus: false,
                  keyboardType: this.widget.inputType,
                  onChanged: _onChanged,
                  focusNode: _focusNode,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                    border: OutlineInputBorder(
                      /*边角*/
                      borderRadius: BorderRadius.all(Radius.circular(8),),
                      borderSide: BorderSide(color: tipColor, width: 1,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      /*边角*/
                      borderRadius: BorderRadius.all(Radius.circular(8),),
                      borderSide: BorderSide(color: tipColor, width: 1,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8),),
                      borderSide: BorderSide(color: tipColor, width: 1,),
                    ),
                    hintStyle: TextStyle(fontSize: 14),
                    hintText: widget.hintText,
                  ),
                ),
              ),
              Container(
                  width: 335,
                  margin: EdgeInsets.only(top: 5,left: 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        tip == 0 ? this.widget.tipText : tip == 2 ? this.widget.errorTipText:this.widget.rightText,
                        style: TextStyle(
                          fontSize: 12,
                          color: tip == 0 ? Color(0xFF999999):tipColor,
                        ),textAlign: TextAlign.left,),
                    ],
                  )
              )
            ],
          ),
          //验证码发送按钮
          Positioned(
            left: 230,
            child: GestureDetector(
              onTap: () async {
                final String phoneNum=this.widget.controller.text;
                phoneBool = phoneReg.hasMatch(phoneNum);
                if(phoneBool == true){
                  setState(() {
                    available = true;
                  });
                }else{
                  setState(() {
                    available = false;
                  });
                }
                if(available == true){
                  print(available);
                  final SendVerifyCode result=await SendVerifyCodeDao.sendSms(phoneNum);
                  if(result != null){
                    if(result.code==200) {
                      WebAPICookie = result.cookie.split(';')[0];
                      print(WebAPICookie);
                    }
                  } else if(available == false){}else{_on400AlertPressed(context);}
                }
              },
              child: Container(
                width: 110,
                height: 30,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border(left: BorderSide(width: 1,color: Color(0xFF5580EB)))
                ),
                child: available ? InkWell(
                  child: Text(
                    '$_verifyStr',
                    style: inkWellStyle,
                    textAlign: TextAlign.center,
                  ),
                  onTap: (_seconds == countdown) ? () {
                    _startTimer();
                    inkWellStyle = _unavailableStyle;
                    _verifyStr = '已发送$_seconds'+'s';
                    setState(() {});
                    onTapCallback();
                  } : null,
                ): InkWell(
                  child: Text(
                    '获取验证码',
                    style: _unavailableStyle,
                    textAlign: TextAlign.center,),
                    ),
                )
              ),
            ),
          ]);
  }

  _onChanged(String text){
    if(widget.onChanged != null){
      widget.onChanged(text);
      setState(() {
        textBool = this.widget.reg.hasMatch(this.widget.yzmcontroller.text);
      });
      if(textBool == true){
        setState(() {
          tipColor = Color(0xFF2692FD);
          tip = 1;
        });
      }else if (textBool == false){
        setState(() {
          tip = 2;
        });
      }
    }
  }
  _on400AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "该手机号已经被注册",
      buttons: [
        DialogButton(
          child: Text(
            "去登录",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "知道了",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
            setState(() {
              available = false;
            });
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
}


