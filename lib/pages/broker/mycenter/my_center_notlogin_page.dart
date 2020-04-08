import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCenterNotLoginPage extends StatefulWidget {
  @override
  _MyCenterNotLoginPageState createState() => _MyCenterNotLoginPageState();
}

class _MyCenterNotLoginPageState extends State<MyCenterNotLoginPage> {
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
                      padding: EdgeInsets.only(top: 10),
                      child:Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Image(image: AssetImage('images/set.png')),
                        ],
                      )
                  ),
                  // 头像按钮
                  Container(
                    width: 90, 
                    height: 90,
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFcccccc),width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      color: Colors.white
                    ),
                    child:Image(
                      image: AssetImage('images/my_big.png'),
                    ),
                  ),
                  Text(
                    '未登录',
                    style:TextStyle(
                      fontSize: 20,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    '请点击头像登录',
                    style:TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(image: AssetImage('images/company.png')),
                      Text(
                        '所属公司',
                        style:TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image(image: AssetImage('images/site.png')),
                      Text(
                        '所在地区',
                        style:TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image(image: AssetImage('images/group.png')),
                      Text(
                        '所在门店小组',
                        style:TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image(image: AssetImage('images/phone.png')),
                      Text(
                        '联系电话',
                        style:TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      )
                    ],
                  ),
                ]
            )
          ],
        )

    );
  }
}
