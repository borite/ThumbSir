import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/pages/mycenter/add_task_page.dart';
import 'package:ThumbSir/pages/mycenter/choose_mini_task_page.dart';
import 'package:flutter/material.dart';

class MCenterGroupPage extends StatefulWidget {
  @override
  _MCenterGroupPageState createState() => _MCenterGroupPageState();
}

class _MCenterGroupPageState extends State<MCenterGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle.png'),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('小组成员',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMemberPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF93C0FB),width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('添加成员',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          )

                        ],
                      )
                  ),
                  // 头像
                  Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment(-1,-1),
                            margin: EdgeInsets.only(top: 8,left: 35),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 25,right: 15,top: 5),
                                    child: Text('哲里木',style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 20,
                                      color: Color(0xFF333333),
                                      fontWeight: FontWeight.normal,
                                    ),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Image(image: AssetImage('images/vip_yellow.png'),),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 12,left: 25),
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
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  // 制定任务
                  Container(
                    width: 335,
                    height: 83,
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(bottom:BorderSide(color: Color(0xFF5580EB),width: 1)),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskPage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('为下级设置任务名称',style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child:GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseMiniTaskPage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('为下级设置最低任务量',style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),

                        )
                      ],
                    ),
                  ),
                  // 成员列表
                  Padding(
                    padding: EdgeInsets.only(top: 50,bottom: 40),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                        border: Border.all(color: Color(0xFFCCCCCC),width: 1)
                                    ),
                                    child:Image(
                                      image: AssetImage('images/my_big.png'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 200,
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
                                            Padding(
                                              padding: EdgeInsets.only(left: 10),
                                              child: Image(image: AssetImage('images/vip_yellow.png'),),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 200,
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '18612345678',
                                            style:TextStyle(
                                              fontSize: 10,
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
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                        border: Border.all(color: Color(0xFFCCCCCC),width: 1)
                                    ),
                                    child:Image(
                                      image: AssetImage('images/my_big.png'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 200,
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
                                            Padding(
                                              padding: EdgeInsets.only(left: 10),
                                              child: Image(image: AssetImage('images/vip_yellow.png'),),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 200,
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '18612345678',
                                            style:TextStyle(
                                              fontSize: 10,
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
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                        border: Border.all(color: Color(0xFFCCCCCC),width: 1)
                                    ),
                                    child:Image(
                                      image: AssetImage('images/my_big.png'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 200,
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
                                          width: 200,
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '18612345678',
                                            style:TextStyle(
                                              fontSize: 10,
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
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                        border: Border.all(color: Color(0xFFCCCCCC),width: 1)
                                    ),
                                    child:Image(
                                      image: AssetImage('images/my_big.png'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 200,
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
                                          width: 200,
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '18612345678',
                                            style:TextStyle(
                                              fontSize: 10,
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
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                        border: Border.all(color: Color(0xFFCCCCCC),width: 1)
                                    ),
                                    child:Image(
                                      image: AssetImage('images/my_big.png'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    width: 200,
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
                                            Padding(
                                              padding: EdgeInsets.only(left: 10),
                                              child: Image(image: AssetImage('images/vip_yellow.png'),),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: 200,
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '18612345678',
                                            style:TextStyle(
                                              fontSize: 10,
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
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            )
          ],
        )
    );
  }
}
