import 'package:ThumbSir/dao/get_message_dao.dart';
import 'package:ThumbSir/pages/broker/tips/agree_invitation_page.dart';
import 'package:ThumbSir/pages/broker/tips/connect_invitation_page.dart';
import 'package:ThumbSir/pages/broker/tips/finish_invitation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QListTipsPage extends StatefulWidget {
  @override
  _QListTipsPageState createState() => _QListTipsPageState();
}

class _QListTipsPageState extends State<QListTipsPage> with SingleTickerProviderStateMixin{
  var msgList;
  List<Widget> msgShowList = [];

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId= prefs.getString("userID");
    if(userId != null){
      var msgResult = await GetMessageDao.getMessage(userId,'2');
      if (msgResult.code == 200) {
        setState(() {
          msgList = msgResult.data;
        });
//        msgList = msgResult.data;
      }
    }
  }

  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  bool check = false; // 复选框是否被选中
  int checkBoxState = 0;  // 复选框是否出现，0为未出现，1为出现

  @override
  void initState() {
    _load();
    super.initState();
    controller = AnimationController(vsync:this,duration: Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0,end:30).animate(
        CurvedAnimation(parent: controller,curve: Curves.easeInOut)
          ..addListener(() {
            setState(() {
              animationValue = animation.value;
            });
          })
          ..addStatusListener((AnimationStatus state) {
            setState(() {
              animationStatus = state;
            });
          })
    );
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Widget msgItem() {
    Widget content;
    if (msgList != null) {
      for (var item in msgList) {
        msgShowList.add(
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AgreeInvitationPage()));
            },
            child: _item('images/tie_big.png',item.sendTime.toIso8601String().substring(0,10),item.msgTitle,item.msgContent),
          ),
        );
      }
    }
    content = Column(
      children: msgShowList,
    );

    return content;
  }

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Image(image: AssetImage('images/back.png'),),
                            ),
                            Row(
                              children: <Widget>[
                                Image(image: AssetImage('images/bell.png')),
                                Text(
                                  '新消息5条',
                                  style:TextStyle(
                                    color: Color(0xFF0E7AE6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                )
                              ],
                            ),
                            check == true && checkBoxState == 1?
                            GestureDetector(
                              onTap: (){
                                controller.reverse();
                                checkBoxState = 0;
                              },
                              child: Text(
                                '删除',
                                style:TextStyle(
                                  color: Color(0xFFF24848),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                            :
                            check == false && checkBoxState == 1?
                            GestureDetector(
                              onTap: (){
                                controller.reverse();
                                checkBoxState = 0;
                              },
                              child: Text(
                                '取消',
                                style:TextStyle(
                                  color: Color(0xFF0E7AE6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                            :
                            GestureDetector(
                              onTap: (){
                                controller.forward();
                                checkBoxState = 1;
                              },
                              child: Text(
                                '编辑',
                                style:TextStyle(
                                  color: Color(0xFF0E7AE6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                            ,
                          ],
                        )

                    ),

                    // 消息提醒
                    Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: msgItem()
//                          _item('images/morning_tip.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!'),
//                          _item('images/noon_tip.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!'),
//                          _item('images/evening_tip.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!'),
                    )
                  ]
              )
            ],
          )
      ),
    );
  }

  _item(var image,String date,String content,String tip){
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 2,top: 25),
            child: Checkbox(
              value: check,
              activeColor: Color(0xFF0E7AE6),
              onChanged: (bool val) {
                // val 是布尔值
                check = !check;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: animation.value),
            child: Stack(
              children: <Widget>[
                Container(
                    height: 102,
                    padding: EdgeInsets.only(bottom: 15,left: 15,right: 15),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Container(
                      height: 80,
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
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
                      child:Container(
                          padding: EdgeInsets.only(left: 100),
                          child:Column(
                            children: <Widget>[
                              Container(
                                width: 220,
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  date,
                                  style:TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    height: 2,
                                  ),
                                ),
                              ),
                              Container(
                                width: 220,
                                child: Text(
                                  content,
                                  style:TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFF67419),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5
                                  ),
                                ),
                              ),
                              Container(
                                width: 220,
                                child: Text(
                                  tip,
                                  style:TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF67419),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    )
                ),
                Positioned(
                  left: 5,
                  child: Container(
                    width: 90,
                    height: 90,
                    child: Image(
                      image:AssetImage(image),fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: 320,
                  child: Text(
                    '.',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.red,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
