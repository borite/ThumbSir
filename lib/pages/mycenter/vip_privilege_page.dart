import 'package:flutter/material.dart';

class VipPrivilegePage extends StatefulWidget {
  @override
  _VipPrivilegePageState createState() => _VipPrivilegePageState();
}

class _VipPrivilegePageState extends State<VipPrivilegePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle_middle.png'),
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
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('会员特权',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                  ),
                  // 标题
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('会员特权',style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 内容
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Text('您目前使用的是拇指先生上线后的第一版，感谢您的支持！',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text('推广期免费开放拇指先生的量化工具和即将上线的客户维护系统的所有功能。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text('如果您在使用过程中有任何的意见或者建议，请在个人中心的客服中心进行留言，拇指先生客服会尽快与您联系，感谢您对拇指先生的支持，祝您使用愉快！',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                ]
            )
          ],
        )
    );
  }
}
