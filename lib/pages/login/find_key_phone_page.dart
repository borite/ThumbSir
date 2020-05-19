import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/find_key_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';

class FindKeyPhonePage extends StatefulWidget {
  @override
  _FindKeyPhonePageState createState() => _FindKeyPhonePageState();
}

class _FindKeyPhonePageState extends State<FindKeyPhonePage> {
  final TextEditingController _controller = TextEditingController();
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          // 背景
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image:AssetImage('images/circle.png'),
                fit: BoxFit.fitHeight,
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
                      // 姓名、电话、密码、忘记密码
                      Column(
                        children: <Widget>[
                          Input(
                            defaultText: '电话号码',
                          ),
                          Input(
                            defaultText: '验证码',
                          ),
                          Container(
                            width: 335,
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FindKeyPhonePage()));
                              },
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
                      // 登录
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FindKeyPage()));
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
      );
  }
}