import 'package:ThumbSir/pages/manager/qlist/group_list_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_list_member_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamListDetailWidget extends StatefulWidget {
  @override
  _TeamListDetailWidgetState createState() => _TeamListDetailWidgetState();
}

class _TeamListDetailWidgetState extends State<TeamListDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      margin: EdgeInsets.only(left: 8,right: 8),
      child: Column(
        children: <Widget>[
          // 组名
          Container(
            margin: EdgeInsets.only(bottom: 40,top: 5),
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
                          '1',
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
                              '长河湾北门店',
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
          // 负责人
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage()));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
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
                                border: Border.all(color: Color(0xFFFF9600),width: 1), // 商圈经理橘色
//                                border: Border.all(color: Color(0xFF9149EC),width: 1), // 总监浅紫色
//                                border: Border.all(color: Color(0xFF7412F2),width: 1), // 副总经理深紫色
//                                border: Border.all(color: Color(0xFF003273),width: 1), // 总经理深蓝色
                              ),
                              child:Image(
                                image: AssetImage('images/my_big.png'),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 10,
                              child: Container(
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFFF9600),width: 1), // 商圈经理橘色
//                                border: Border.all(color: Color(0xFF9149EC),width: 1), // 总监浅紫色
//                                border: Border.all(color: Color(0xFF7412F2),width: 1), // 副总经理深紫色
//                                border: Border.all(color: Color(0xFF003273),width: 1), // 总经理深蓝色
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top:2,left:5,right: 5),
                                  child: Text(
                                    '商圈经理',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFFF9600), // 商圈经理橘色
//                                  color: Color(0xFF9149EC), // 总监浅紫色
//                                  color: Color(0xFF7412F2), // 副总经理深紫色
//                                  color: Color(0xFF003273), // 总经理深蓝色
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
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
          // 列表
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 335,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
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
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color(0xFF93C0FB),
                              border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '1',
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
                            width: 200,
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
                            )

                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image(image: AssetImage('images/next.png'),),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 335,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
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
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color(0xFF93C0FB),
                              border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '1',
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
                              width: 200,
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
                              )

                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image(image: AssetImage('images/next.png'),),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 335,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
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
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color(0xFF93C0FB),
                              border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '1',
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
                              width: 200,
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
                              )

                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image(image: AssetImage('images/next.png'),),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 335,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
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
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color(0xFF93C0FB),
                              border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '1',
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
                              width: 200,
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
                              )

                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image(image: AssetImage('images/next.png'),),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 335,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
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
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color(0xFF93C0FB),
                              border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '1',
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
                              width: 200,
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
                              )

                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image(image: AssetImage('images/next.png'),),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 335,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
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
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color(0xFF93C0FB),
                              border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                            ),
                            child:Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '1',
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
                              width: 200,
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
                              )

                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Image(image: AssetImage('images/next.png'),),
                      )
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


