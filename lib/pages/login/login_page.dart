import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/login_dao.dart';
import 'package:ThumbSir/model/login_result_model.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode = FocusNode();
  final TextEditingController phoneNumController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  String phoneNum;
  String password;
  RegExp phoneReg;
  RegExp psdReg;
  bool phoneBool;
  bool psdBool;

  @override
  void initState() {
    phoneReg = telPhoneReg;
    psdReg = passwordReg;
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
          child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Image(image: AssetImage('images/back.png'),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninNameAndPhonePage()));
                                  },
                                  child: Text('注册',style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0E7AE6),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
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
                                        image: AssetImage('images/my_big.png'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10,bottom: 30),
                                    child: Text(
                                      '登录',
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
                            //密码输入框
                            Input(
                              hintText: "密码",
                              errorTipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                              tipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                              rightText: "密码格式正确",
                              controller: passwordController,
                              inputType: TextInputType.text,
                              reg: psdReg,
                              onChanged: (text){
                                setState(() {
                                  password = text;
                                  psdBool = psdReg.hasMatch(password);
                                });
                              },
                            ),
                            // 忘记密码
                            Container(
                              width: 335,
                              padding: EdgeInsets.only(top: 20),
                                child: Container(
                                  width: 60,
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FindKeyPhonePage()));
                                    },
                                    child: Text('忘记密码？',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5580EB),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.right,),
                                  ),
                                ),
                            ),
                          ],
                        ),
                        // 登录
                        GestureDetector(
                          onTap:() async{
                            if(phoneBool == true && psdBool == true){
                              final LoginResult result=await LoginResultDao.doUserLogin(password, phoneNum);
                              if(result.code==200){
                                String dataStr=json.encode(result.data);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("userInfo", dataStr);
                                Navigator.of(context).pushAndRemoveUntil(
                                    new MaterialPageRoute(builder: (context) => new Home()
                                    ), (route) => route == null);
                              } else if(result.code == 401){
                                _on401AlertPressed(context);
                              }
                              else if(result.code == 412){_on412AlertPressed(context);}
                              else{_on404AlertPressed(context);}
                            }else{}
                          },
                          child: Container(
                              width: 335,
                              height: 40,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(bottom: 50,top: 100),
                              decoration: phoneBool == true && psdBool == true ?
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
                                child: Text('登录',style: TextStyle(
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
        ),
      );
  }
  _on404AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "登录失败",
      desc: "该用户不存在，去注册",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninNameAndPhonePage())),
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
  _on401AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "登录失败",
      desc: "密码错误，请重试",
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
  _on412AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "登录失败",
      desc: "用户被锁定，请联系客服400-666-8888",
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
