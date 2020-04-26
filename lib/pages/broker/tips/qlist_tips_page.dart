import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';

class QListTipsPage extends StatefulWidget {
  @override
  _QListTipsPageState createState() => _QListTipsPageState();
}

class _QListTipsPageState extends State<QListTipsPage> {
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
                          Text(
                            '编辑',
                            style:TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          )
                        ],
                      )

                  ),

                  // 消息提醒
                  Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: <Widget>[
                        // 每一条提醒
                        _item('images/cake.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!'),
                        _item('images/morning.png','2020年3月24日','今天是徐姐的生日','记得送祝福!'),
                        _item('images/cake.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!'),
                      ],
                    ),
                  )
                ]
            )
          ],
        )

    );
  }

  _item(var image,String date,String content,String tip){
    return Stack(
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
          left: 12,
          child: Image(
              image:AssetImage(image)
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
    );
  }
}
