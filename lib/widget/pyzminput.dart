import 'package:flutter/material.dart';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_user_by_phone_dao.dart';
import 'package:ThumbSir/dao/signin_phone_verify_code_dao.dart';
import 'package:ThumbSir/model/get_user_by_phone_model.dart';
import 'package:ThumbSir/model/phone_verify_code_model.dart';
import 'package:ThumbSir/pages/login/signin_page.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';

// 可用时使用的字体样式。
const TextStyle _availableStyle = TextStyle(
  fontSize: 14.0,
  color: Color(0xFF6E85D3),
);

class PYZMInput extends StatefulWidget {
  final String hintText;
  final String tipText;
  final String rightText;
  final String errorTipText;
  final TextEditingController controller;
  final TextEditingController yzmcontroller;
  final ValueChanged<String> onChanged;
  final inputType;
  final RegExp reg;
  final editParentText;
  const PYZMInput({
    Key? key,
    required this.controller,
    required this.yzmcontroller,
    required this.onChanged,
    this.hintText="",
    this.tipText="",
    this.rightText="格式正确",
    required this.errorTipText,
    this.inputType,
    required this.reg,
    this.editParentText,
  });
  @override
  _PYZMInputState createState() => _PYZMInputState();
}

class _PYZMInputState extends State<PYZMInput> {

  /// 倒计时的秒数，默认60秒。
  int countdown = 0;
  /// 用户点击时的回调函数。
  // Function onTapCallback;
  /// 是否可以获取验证码。
  bool available = false;

  final FocusNode _focusNode = FocusNode();
  bool textBool = true;// 输入的内容是否合法
  late RegExp phoneReg;
  bool phoneBool = false;
  Color tipColor = const Color(0xFF6E85D3);
  int tip = 0;
  late String webAPICookie;

  late String userID;


  // 倒计时的计时器。
  Timer? _timer;
  /// 当前倒计时的秒数。
  late int seconds;
  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  @override
  void initState() {
    phoneReg = telPhoneReg;
    seconds = countdown;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField失去焦点
        setState(() {
          textBool = widget.reg.hasMatch(widget.yzmcontroller.text);
        });
        if(textBool == true){
          setState(() {
            tipColor = const Color(0xFF6E85D3);
          });
        }else if(textBool == false ){
          setState(() {
            tipColor = const Color(0xFFF24848);
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    super.dispose();
    _timer?.cancel();
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
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: widget.yzmcontroller,
                  autofocus: false,
                  keyboardType: widget.inputType,
                  onChanged: _onChanged,
                  focusNode: _focusNode,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
                    border: OutlineInputBorder(
                      /*边角*/
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                      borderSide: BorderSide(color: tipColor, width: 1,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      /*边角*/
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                      borderSide: BorderSide(color: tipColor, width: 1,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                      borderSide: BorderSide(color: tipColor, width: 1,),
                    ),
                    hintStyle: const TextStyle(fontSize: 14),
                    hintText: widget.hintText,
                  ),
                ),
              ),
              Container(
                  width: 335,
                  margin: const EdgeInsets.only(top: 5,left: 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        tip == 0 ? widget.tipText : tip == 2 ? widget.errorTipText:widget.rightText,
                        style: TextStyle(
                          fontSize: 12,
                          color: tip == 0 ? const Color(0xFF999999):tipColor,
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
              child: Container(
                width: 110,
                height: 30,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                    border: Border(left: BorderSide(width: 1,color: Color(0xFF6E85D3)))
                ),
                child: Text(
                  countdown > 0?'$countdown后重新获取':'获取验证码',
                  style: _availableStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () async {
                final String phoneNum=widget.controller.text;
                phoneBool = phoneReg.hasMatch(phoneNum);

                if(countdown>0){
                  return;
                }
                //当电话号码合法时
                if(phoneBool){
                  final GetUserByPhone phoneResult=await GetUserByPhoneDao.getUserByPhone(phoneNum);
                  //找到用户，返回成功
                  if(phoneResult.code==200){
                    setState(() {
                      countdown=60;
                    });
                    startCountDownTimer();
                    userID=phoneResult.data!.userPid;

                    //发送验证码，注意cookie
                    PhoneVerifyCode? codeResult=await PhoneVerifyCodeDao.sendSms(phoneNum);
                    //验证码发送成功
                    if(codeResult.code==200){
                      webAPICookie = codeResult.cookie.split(';')[0];
                      widget.editParentText(webAPICookie,userID);
                    }
                  }else{   //用户没有找到，会返回404
                    _on400AlertPressed(context);
                  }
                }else{  //电话号码不合法时
                  _onPhoneAlertPressed(context);
                }
              }
            ),
          ),
          ]);
  }

  //倒计时计时器方法
  void startCountDownTimer(){
    const oneSecond=Duration(seconds: 1);
    Null Function(dynamic timer) callBack;
    callBack=(timer){
      setState(() {
        if(countdown < 1){
          _timer?.cancel();
        }else{
          countdown=countdown-1;
        }
      });
    };
    _timer=Timer.periodic(oneSecond, callBack );
  }

  _onChanged(String text){
    widget.onChanged(text);
    setState(() {
      textBool = widget.reg.hasMatch(widget.yzmcontroller.text);
    });
    if(textBool == true){
      setState(() {
        tipColor = const Color(0xFF6E85D3);
        tip = 1;
      });
    }else if (textBool == false){
      setState(() {
        tip = 2;
      });
    }
  }
  _on400AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "该手机号未注册",
      buttons: [
        DialogButton(
          child: const Text(
            "去注册",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const SigninNameAndPhonePage())),
          color: const Color(0xFF6E85D3),
        ),
        DialogButton(
          child: const Text(
            "知道了",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
            setState(() {
              available = false;
            });
          },
          color: const Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onPhoneAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "手机号码格式不正确",
      buttons: [
        DialogButton(
          child: const Text(
            "再试试",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: const Color(0xFF6E85D3),
        ),
      ],
    ).show();
  }
}


