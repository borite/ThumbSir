import 'package:ThumbSir/dao/login_dao.dart';
import 'package:ThumbSir/model/login_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/signin_page.dart';
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
//                              padding: EdgeInsets.only(bottom: 20),
                              margin: EdgeInsets.only(bottom: 10),
//                              decoration: BoxDecoration(
//                                border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
//                              ),
                              child: Text(
                                '拇指先生APP是一款为房地产经纪从业人员量身定做的工具类APP，目前开放了量化工具功能，后续会陆续上线客户维护功能、积分系统等功能。',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Container(
//                              padding: EdgeInsets.only(bottom: 20),
                              margin: EdgeInsets.only(bottom: 10),
//                              decoration: BoxDecoration(
//                                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
//                              ),
                              child: Text(
                                '量化工具主要帮助经纪人、店长、商圈经理等职位的从业人员清晰规划一天的行程，其上级可以通过拇指先生实时追踪下级的量化进展，从结果考核转变为过程监控，从而提高管理效率。',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Container(
//                              padding: EdgeInsets.only(bottom: 20),
                              margin: EdgeInsets.only(bottom: 10),
//                              decoration: BoxDecoration(
//                                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
//                              ),
                              child: Text(
                                '即将上线的客户维护系统致力于帮助从业人员深挖客户和业主的需求，并随时进行记录，提高客户维护效率；此外还有节日和生日提醒功能，帮助从业人员增加客户粘性，增加回头客。',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
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
                                '如果您在使用过程中有任何的意见或者建议，请在个人中心的客服中心进行留言，如有必要，拇指先生客服会尽快与您联系，感谢您对拇指先生的支持，祝您使用愉快！',
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
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(context, MaterialPageRoute(
//                                    builder: (context) => PrivacyStatementPage()));
//                              },
//                              child: Container(
//                                height: 40,
//                                decoration: BoxDecoration(
//                                    border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB),width: 1))
//                                ),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text('隐私协议',style: TextStyle(
//                                      fontSize: 14,
//                                      color: Color(0xFF333333),
//                                      fontWeight: FontWeight.normal,
//                                      decoration: TextDecoration.none,
//                                    ),),
//                                    Image(image: AssetImage('images/next.png'),)
//                                  ],
//                                ),
//                              ),
//                            ),
//                            // 法律声明
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(context, MaterialPageRoute(
//                                    builder: (context) => LegalNoticePage()));
//                              },
//                              child: Container(
//                                height: 40,
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text('法律声明',style: TextStyle(
//                                      fontSize: 14,
//                                      color: Color(0xFF333333),
//                                      fontWeight: FontWeight.normal,
//                                      decoration: TextDecoration.none,
//                                    ),),
//                                    Image(image: AssetImage('images/next.png'),)
//                                  ],
//                                ),
//                              ),
//                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              child: Text('拇指先生 版权所有',style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),)
                            ),
                          ]
                        )
                      )
                    ],
                )
              ]),
        ));
  }
}
