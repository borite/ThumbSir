import 'dart:math';

import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:ThumbSir/pages/mycenter/aboutus_page.dart';
import 'package:ThumbSir/pages/mycenter/introduce_version_page.dart';
import 'package:ThumbSir/pages/mycenter/set_mymsg_page.dart';
import 'package:ThumbSir/pages/mycenter/set_safe_page.dart';
import 'package:ThumbSir/pages/mycenter/update_version_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';


class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  final TextEditingController textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            // 内容
            Container(
              color: Color(0xFFF2F2F2),
              child: ListView(
                children: <Widget>[
                  // 个人信息
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SetMyMsgPage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 65),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // 头像
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      padding: EdgeInsets.only(top: 8,bottom: 5),
                                      child: Text(
                                        '个人信息',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '头像、姓名、公司、区域',
                                        style:TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 账号与安全
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SetSafePage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // 头像
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 300,
                                      padding: EdgeInsets.only(top: 8,bottom: 5),
                                      child: Text(
                                        '账号与安全',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      child: Text(
                                        '修改手机号码、修改密码、找回密码',
                                        style:TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 新版本介绍
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroduceVersionPage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      padding: EdgeInsets.only(top: 8,bottom: 5),
                                      child: Text(
                                        '新版本介绍',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '量化系统',
                                        style:TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 检查与更新
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateVersionPage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      padding: EdgeInsets.only(top: 8,bottom: 5),
                                      child: Text(
                                        '检查与更新',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        'MXZS3435.01',
                                        style:TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 关于拇指先生
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                    },
                    child:Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 15),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      padding: EdgeInsets.only(top: 8,bottom: 5),
                                      child: Text(
                                        '关于拇指先生',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '拇指先生介绍、服务协议、隐私协议等',
                                        style:TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 退出登录
                  GestureDetector(
                    onTap: () => _onLogoutAlertPressed(context),
                    child: Container(
                      height:40,
                      padding: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(left: 30,right: 30,top: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:Color(0xFF5580EB),
                      ),
                      child: Text('退出登录',style:TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
            ),
            // 顶部导航区域
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF5580EB),
                image: DecorationImage(
                  image:AssetImage('images/circle.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child:Container(
                height: 80,
                padding: EdgeInsets.only(top: 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Image(image: AssetImage('images/back_w_arrow.png'),),
                      ),
                    ),
                    Text(
                      '设置',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Container(
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _onLogoutAlertPressed(context) {
    Alert(
      context: context,
      title: "是否退出登录？",
      desc: "退出登录后不会删除任何历史数据，下次登录依然可以使用本账号。",
      buttons: [
        DialogButton(
          child: Text(
            "退出登录",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("userInfo");
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home()
                ), (route) => route == null);
          },
          color: Color(0xFF5580EB),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF999999),
          width: 120,
        )
      ],
    ).show();
  }
}
