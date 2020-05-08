import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Text('注册',style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0E7AE6),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
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
                              margin: EdgeInsets.only(top: 10,bottom: 10),
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
                  // 姓名、电话、密码、忘记密码
                  Column(
                    children: <Widget>[
                      Container(
                        width: 335,
                        height: 40,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(bottom: 25,top: 30),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF2692FD)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4,left: 5),
                          child: Text('姓名',style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),textAlign: TextAlign.left,),
                        )
                      ),
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF2692FD)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4,left: 5),
                            child: Text('电话',style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.left,),
                          )
                      ),
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF2692FD)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4,left: 5),
                            child: Text('密码',style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.left,),
                          )
                      ),
                      Container(
                          width: 335,
                          padding: EdgeInsets.only(top: 20),
                          child: Text('忘记密码？',style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5580EB),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.right,),
                      ),
                    ],
                  ),
                  // 登录
                  Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 30,top: 100),
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
                ]
            )
          ],
        )
    );
  }
}
