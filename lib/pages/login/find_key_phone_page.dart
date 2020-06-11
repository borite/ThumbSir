import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/checkverifycode_dao.dart';
import 'package:ThumbSir/dao/getuser_byphone_dao.dart';
import 'package:ThumbSir/dao/phoneverifycode_dao.dart';
import 'package:ThumbSir/model/checkverifycode_model.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/model/find_user_result.dart';
import 'package:ThumbSir/model/getuser_byphone_model.dart';
import 'package:ThumbSir/model/phoneverifycode_model.dart';
import 'package:ThumbSir/pages/login/find_key_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:ThumbSir/widget/pyzminput.dart';
import 'package:ThumbSir/widget/yzminput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class FindKeyPhonePage extends StatefulWidget {
  @override
  _FindKeyPhonePageState createState() => _FindKeyPhonePageState();
}

class _FindKeyPhonePageState extends State<FindKeyPhonePage> {
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;
  final TextEditingController verifyCodeController=TextEditingController();
  String verifyCode;
  RegExp yzmReg;
  bool verifyCodeBool;

  String WebAPICookie;

  String username;
  String userId;

  @override
  void initState() {
    phoneReg = telPhoneReg;
    yzmReg = verifyCodeReg;
    super.initState();
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child:Container(
            // 背景
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image:AssetImage('images/circle.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: ListView(
              children: <Widget>[
                Column(
                    children: <Widget>[
                      // 导航栏
                      Padding(
                          padding: EdgeInsets.all(15),
                          child:Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                            ],
                          )
                      ),
                      // 头像按钮
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment(-1,-1),
                            margin: EdgeInsets.only(top: 8,left: 37),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(45)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Color(0xFFcccccc),
                                          offset: Offset(0.0, 3.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0
                                      )],
                                    ),
                                    child:Image(
                                      image: AssetImage('images/key.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '找回密码',
                                    style:TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // 电话、密码、忘记密码
                      Column(
                        children: <Widget>[
                          //手机号码输入框
                          Input(
                            hintText: "手机号码",
                            tipText: "请输入手机号码",
                            errorTipText: "请输入格式正确的手机号码",
                            rightText: "手机号码格式正确",
                            controller: phoneNumController,
                            inputType: TextInputType.phone,
                            reg: phoneReg,
                            onChanged: (text){
                              setState(() {
                                phoneNum = text;
                                phoneBool = phoneReg.hasMatch(phoneNum);
                              });
                            },
                          ),
                          // 验证码
                          PYZMInput(
                            hintText: "验证码",
                            tipText: "请输入验证码",
                            errorTipText: "请输入格式正确的验证码",
                            rightText: "验证码格式正确",
                            yzmcontroller: verifyCodeController,
                            controller: phoneNumController,
                            inputType: TextInputType.number,
                            reg: yzmReg,
                            onChanged: (text){
                              setState(() {
                                verifyCode = text;
                                verifyCodeBool = yzmReg.hasMatch(verifyCode);
                              });
                            },
                            editParentText: (editText,userName,userID) => _editParentText(editText,userName,userID),
                          ),
                          Container(
                            width: 335,
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () => _onAppealAlertPressed(context),
                              child: Text('无法收到验证码？发起账号申诉！',style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.right,),
                            ),
                          ),
                        ],
                      ),
                      // 下一步
                      GestureDetector(
                        onTap: () async {
                          if(phoneBool == true && verifyCodeBool == true){
                            final CommonResult coderesult=await CheckVerifyCodeDao.checkCode(verifyCode,WebAPICookie);
                            if(coderesult != null){
                              if(coderesult.code == 200 ){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FindKeyPage(
                                  userName : username,
                                  userID :userId
                                )));
                              }else{_onCodeAlertPressed(context);}
                            }else{_onCodeAlertPressed(context);}
                          }else{}
                        },
                        child: Container(
                            width: 335,
                            height: 40,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(bottom: 50,top: 100),
                            decoration: phoneBool == true && verifyCodeBool == true ?
                            BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF5580EB)
                            )
                                :
                            BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF93C0FB)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text('下一步',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            )
                        ),
                      ),
                    ]
                )
              ],
            )
          ),
        )
      );
  }
  // 修改contentText参数

  _editParentText(editText,userName,userID) {
    setState(() {
      WebAPICookie = editText;
      username = userName;
      userId = userID;
    });
  }
  _onAppealAlertPressed(context) {
    Alert(
      context: context,
      title: "是否发起账号申诉？",
      desc: "如果您的手机号码无法收到验证码，可进行账号申诉，点击确定后会给拇指先生后台发送信息，3个工作日内会有拇指先生客服联系您。",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Home( )
            ), (route) => route == null
          ),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onCodeAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "验证码不正确",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
}
