import 'dart:convert';
import 'package:ThumbSir/dao/check_verify_code_dao.dart';
import 'package:ThumbSir/dao/modify_phone_step1_dao.dart';
import 'package:ThumbSir/dao/modify_phone_step2_dao.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:ThumbSir/pages/mycenter/change_phone_finish_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/pyzminput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:ThumbSir/dao/send_verify_code_dao.dart';
import 'package:ThumbSir/dao/signin_dao.dart';
import 'package:ThumbSir/model/userreg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneNewPage extends StatefulWidget {
  final passWord;
  final userID;
  ChangePhoneNewPage({this.passWord,this.userID});
  @override
  _ChangePhoneNewPageState createState() => _ChangePhoneNewPageState();
}

class _ChangePhoneNewPageState extends State<ChangePhoneNewPage> {
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;
  final TextEditingController verifyCodeController=TextEditingController();
  String verifyCode;
  RegExp yzmReg;
  bool verifyCodeBool;
  String userId;
  String WebAPICookie;

  @override
  void initState() {
    phoneReg = telPhoneReg;
    yzmReg = verifyCodeReg;
    super.initState();
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
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
                      // 标题
                      Column(
                        children: <Widget>[
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            child: Text(
                              '修改手机号码',
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(bottom: 30),
                            child: Text(
                              '2.绑定新的手机号码',
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 电话
                      Column(
                        children: <Widget>[
                          //手机号码
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
                            editParentText: (editText,userID) => _editParentText(editText,userID),
                          ),
                        ],
                      ),
                      // 完成
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 100),
                          decoration: phoneBool == true && verifyCodeBool == true?
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
                            child: GestureDetector(
                              onTap: () async {
                                final CommonResult coderesult=await CheckVerifyCodeDao.checkCode(verifyCode,WebAPICookie);
                                if(coderesult != null){
                                  if(coderesult.code == 200 ){
                                    var result = await ModifyPhoneStepTwoDao.modifyPhone2(widget.passWord, phoneNum, widget.userID);
                                    if(result.code==200) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePhoneFinishPage()));
                                    }else if (result.code == 410){
                                      _on410AlertPressed(context);
                                    }
                                  }else{_onCodeAlertPressed(context);}
                                }else{_onCodeAlertPressed(context);}
                              },
                              child: Text('下一步',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            )
                          )
                      ),
                    ]
                )
              ],
            )
        ),
      );
  }
  _editParentText(editText,userID) {
    setState(() {
      WebAPICookie = editText;
      userId = widget.userID;
    });
  }
  _onCodeAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "验证码不正确",
      desc: "请重试",
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
  _on410AlertPressed(context) {
    Alert(
      context: context,
      title: "手机号码已注册",
      desc: "请使用未注册的手机号码",
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
