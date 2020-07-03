import 'package:ThumbSir/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectInvitationPage extends StatefulWidget {
  @override
  _ConnectInvitationPageState createState() => _ConnectInvitationPageState();
}

class _ConnectInvitationPageState extends State<ConnectInvitationPage> {
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
                                child: Image(image: AssetImage('images/back_white.png'),),
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
                                    '职位邀请成功',
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
                  Container(
                    width: 335,
                    height: 290,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
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
                        Text(
                          '恭喜您加入北京链家房地产经纪有限公司——北京市——京中大部——白石桥大区——长河湾北门店——买卖A组，职位为经纪人。',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          '您可以前往个人中心，在小组成员中查看其他成员信息。',
                          style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // 分享
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(
                              new MaterialPageRoute(builder: (context) => new Home( )
                              ), (route) => route == null);
                        },
                        child: Container(
                          width: 295,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF5580EB)),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF5580EB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text('前往查看',style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.center,),
                          )
                        ),
                      )
                  ]
                  )
                )],
              )
        ]),
      ));
  }
}
