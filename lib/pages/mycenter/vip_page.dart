import 'package:ThumbSir/dao/login_dao.dart';
import 'package:ThumbSir/model/login_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';

class VipPage extends StatefulWidget {
  @override
  _VipPageState createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
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
                            child:Row(
                              children: <Widget>[
                                Image(image: AssetImage('images/back_w_arrow.png'),),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('会员中心',style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                )
                              ],
                            ),

                          ),
                        ],
                      )
                    ),
                    // 头像
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
                                  margin: EdgeInsets.only(top: 20,bottom: 10),
                                  child: Text(
                                    '马思唯',
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
                    // 到期时间
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 335,
                      child: Text(
                        '会员到期时间2020年9月1日',
                        style:TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // 付费板
                    Container(
                      width: 335,
                      height: 230,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage('images/vipbg.png'),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Image(image: AssetImage('images/vip_yellow.png'),),
                              ),
                              Text(
                                '续费会员',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFF9600),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 95,
                                height: 100,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
//                                    border: Border.all(color: Color(0xFFFF9600),width: 1),
                                    border: Border(right:BorderSide(color: Color(0xFFCCCCCC),width: 1)),
//                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 12,bottom: 5),
                                      child: Text('3个月',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFFF9600),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),),
                                    ),
                                    Text('￥299',style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFFF9600),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ],
                                ),
                              ),
                              Container(
                                width: 95,
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                                decoration: BoxDecoration(
//                                    border: Border.all(color: Color(0xFFFF9600),width: 1),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 12,bottom: 5),
                                      child: Text('6个月',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFFF9600),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),),
                                    ),
                                    Text('￥549',style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFFF9600),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text('￥599',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 95,
                                height: 100,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFFF9600),width: 1),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 12,bottom: 5),
                                      child: Text('1年',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFFF9600),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),),
                                    ),
                                    Text('￥999',style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFFF9600),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text('￥1199',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 148,
                                margin: EdgeInsets.only(top: 32),
                                decoration: BoxDecoration(
                                  border: Border(right:BorderSide(color: Color(0xFFCCCCCC),width: 1)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 25,right: 10),
                                      child: Image(image: AssetImage('images/wx.png'),),
                                    ),
                                    Text(
                                      '微信支付',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 140,
                                margin: EdgeInsets.only(top: 32),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 30,right: 10),
                                      child: Image(image: AssetImage('images/zfb.png'),),
                                    ),
                                    Text(
                                      '支付宝支付',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]
                    )
                  ),
                    // 协议
                    Container(
                      width: 335,
                      height:60,
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 1))
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 167.4,
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: Color(0xFFCCCCCC),width: 1))
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 25,right: 10),
                                  child: Text('会员服务协议',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666)
                                  ),),
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),
                          Container(
                            width: 167.4,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 35,right: 10),
                                  child: Text('会员隐私协议',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666)
                                  ),),
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 会员特权
                    Container(
                      width: 335,
                      height:40,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 1))
                      ),
                      child: Row(
                        children: <Widget>[
                          Image(image: AssetImage('images/vip_blue.png'),),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('会员特权',style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666)
                            ),),
                          ),
                        ],
                      ),
                    ),
                    // 我的邀请
                    Container(
                      width: 335,
                      height:40,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 1))
                      ),
                      child: Row(
                        children: <Widget>[
                          Image(image: AssetImage('images/invitation.png'),),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('我的邀请',style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666)
                            ),),
                          ),
                        ],
                      ),
                    )
                  ],
              )
        ]),
      ));

  }
}
