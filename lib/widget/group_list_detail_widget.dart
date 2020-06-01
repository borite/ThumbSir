import 'package:ThumbSir/pages/broker/qlist/analyze_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_list_member_page.dart';
import 'package:ThumbSir/pages/mycenter/delete_member_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';

class GroupListDetailWidget extends StatefulWidget {
  @override
  _GroupListDetailWidgetState createState() => _GroupListDetailWidgetState();
}

class _GroupListDetailWidgetState extends State<GroupListDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      margin: EdgeInsets.only(left: 8,right: 8),
      child: Column(
        children: <Widget>[
          // 组名
          Container(
            margin: EdgeInsets.only(bottom: 25,top: 5),
            width: 335,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color:Color(0xFF93C0FB),width: 2),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Color(0xFF93C0FB),
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          '2',
                          style:TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 200,
                            padding: EdgeInsets.only(top: 8,bottom: 5),
                            child: Text(
                              '买卖A组',
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              '今日计划：120，已完成：100',
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
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
          // 店长
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(45)),
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFF24CC8E),width: 1)
                              ),
                              child:Image(
                                image: AssetImage('images/my_big.png'),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 25,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF24CC8E),width: 1),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top:2,left:5,right: 5),
                                  child: Text(
                                    '店长',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF24CC8E),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 150,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '马思维',
                                  style:TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 150,
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                '今日计划：12，已完成：10',
                                style:TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF999999),
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
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Image(image: AssetImage('images/next.png'),),
                  ),
                ],
              ),
            ),
          ),
          // 成员列表
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF93C0FB),width: 1)
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '马思维',
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    '今日计划：12，已完成：10',
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
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
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage('images/next.png'),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


