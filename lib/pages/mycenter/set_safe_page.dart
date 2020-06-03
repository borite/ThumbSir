import 'package:ThumbSir/pages/login/find_key_page.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:ThumbSir/pages/mycenter/change_code_page.dart';
import 'package:ThumbSir/pages/mycenter/change_phone_old_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SetSafePage extends StatefulWidget {
  @override
  _SetSafePageState createState() => _SetSafePageState();
}

class _SetSafePageState extends State<SetSafePage> {
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
                  // 手机号码
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePhoneOldPage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 65),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Text(
                                '手机号码',
                                style:TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin:EdgeInsets.only(right: 15),
                                  child: Text(
                                    '150****5678',
                                    style:TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            )
                          ],
                        )

                    ),
                  ),
                  // 修改密码
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeCodePage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Text(
                                '登录密码',
                                style:TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 找回密码
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FindKeyPhonePage()));
                    },
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Text(
                                '找回密码',
                                style:TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 注销账户
                  GestureDetector(
                    onTap: () => _onDeleteAlertPressed(context),
                    child: Container(
                        color:Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 15),
                        padding:EdgeInsets.only(left: 25,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Text(
                                '注销账号',
                                style:TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin:EdgeInsets.only(right: 15),
                                  child: Text(
                                    '彻底删除所有数据',
                                    style:TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            )
                          ],
                        )
                    ),
                  ),
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
                      '账号与安全',
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
  _onDeleteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否注销账号？",
      desc: "注销账号后将删除关于您的所有数据，请慎重选择！",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
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
}
