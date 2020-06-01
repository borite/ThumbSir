import 'package:ThumbSir/dao/login_dao.dart';
import 'package:ThumbSir/model/login_result_model.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
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
                          Container(
                            width: 335,
                            height: 40,
                            margin: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF2692FD)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: phoneNumController,
                              autofocus: false,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14),
                                  hintText: "手机号码"
                              ),
                            ),
                          ),
                          //密码输入框
                          Container(
                            width: 335,
                            height: 40,
                            margin: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF2692FD)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: passwordController,
                              autofocus: false,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14),
                                  hintText: "密码"
                              ),
                            ),
                          ),
                          Container(
                            width: 335,
                            padding: EdgeInsets.only(top: 20),
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
                        ],
                      ),
                      // 登录
                      GestureDetector(
                        onTap:() async{
                          final String phoneNum=phoneNumController.text;
                          final String password=passwordController.text;
                          print(phoneNum);
                          print(password);
                          //final LoginModel result=await LoginDao.doUserLogin(password, phoneNum,);
                          final LoginResult result=await LoginResultDao.doUserLogin(password, phoneNum);
                          print(result);
                          if(result.code==200){
                              //String dataStr=loginResultDataToJson(result.data);
                            String dataStr=json.encode(result.data);
                            print(dataStr);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("userInfo", dataStr);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                          }
                        },
                        child: Container(
                            width: 335,
                            height: 40,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(bottom: 50,top: 100),
                            decoration: BoxDecoration(
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
      );
  }
}
