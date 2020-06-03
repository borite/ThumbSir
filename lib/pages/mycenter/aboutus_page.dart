import 'package:ThumbSir/dao/login_dao.dart';
import 'package:ThumbSir/model/login_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:ThumbSir/pages/mycenter/legal_notice_page.dart';
import 'package:ThumbSir/pages/mycenter/privacy_statement_page.dart';
import 'package:ThumbSir/pages/mycenter/service_agreement_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
                image:AssetImage('images/blue_circle.png'),
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
                                child: Image(image: AssetImage('images/back_w_arrow.png'),),
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
                                      image: AssetImage('images/tie.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '拇指先生',
                                    style:TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
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
                      // 内容
                      Container(
                        width: 335,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(
                            color: Color(0xFFcccccc),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0
                          )],
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                '关于拇指先生',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
                              ),
                              child: Text(
                                '拇指先生是一个致力于为房地产运营团队提供管理的APP。拇指先生是一个致力于为房地产运营团队提供管理的APP。拇指先生是一个致力于为房地产运营团队提供管理的APP。拇指先生是一个致力于为房地产运营团队提供管理的APP。拇指先生是一个致力于为房地产运营团队提供管理的APP。拇指先生是一个致力于为房地产运营团队提供管理的APP。',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // 服务协议
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ServiceAgreementPage()));
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('服务协议',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                    Image(image: AssetImage('images/next.png'),)
                                  ],
                                ),
                              ),
                            ),
                            // 隐私协议
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => PrivacyStatementPage()));
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('隐私协议',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                    Image(image: AssetImage('images/next.png'),)
                                  ],
                                ),
                              ),
                            ),
                            // 法律声明
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => LegalNoticePage()));
                              },
                              child: Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('法律声明',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                    Image(image: AssetImage('images/next.png'),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              child: Text('拇指先生 版权所有',style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),)
                            ),
                            Container(
                              child: Text('京ICP证060716号 | 京ICP备12345677号-1',style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),)
                            )
                          ]
                        )
                      )
                    ],
                )
              ]),
        ));
  }
}
