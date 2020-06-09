import 'package:ThumbSir/pages/broker/tips/qlist_tips_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_analyze_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_analyze_member_detail_page.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TeamAnalyzePage extends StatefulWidget {
  @override
  _TeamAnalyzePageState createState() => _TeamAnalyzePageState();
}

class _TeamAnalyzePageState extends State<TeamAnalyzePage> {
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
                      padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // 首页和标题
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/home.png'),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('团队分析',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                          // 消息提醒和个人中心按钮
                          Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                  },
                                  color: Colors.transparent,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightColor: Colors.transparent,
                                  highlightElevation: 0,
                                  splashColor: Colors.transparent,
                                  disabledColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          border:Border.all(color: Color(0xFF0E7AE6),width: 1),
                                          borderRadius: BorderRadius.circular(13),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          child:Image(
                                            width: 26,
                                            height:26,
                                            image: AssetImage('images/bell.png'),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 60,
                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                                  },
                                  color: Colors.transparent,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightColor: Colors.transparent,
                                  highlightElevation: 0,
                                  splashColor: Colors.transparent,
                                  disabledColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          border:Border.all(color: Color(0xFF0E7AE6),width: 1),
                                          borderRadius: BorderRadius.circular(13),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          child:Image(
                                            width: 26,
                                            height:26,
                                            image: AssetImage('images/my.png'),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                  // 头像
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                                startAngle: 280,
                                angleRange: 360,
                                customWidths: CustomSliderWidths(progressBarWidth: 10),
                                customColors: CustomSliderColors(
                                  progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                                  trackColor: Color(0x20CCCCCC),
                                  dotColor: Colors.transparent,
                                ),
                                infoProperties: InfoProperties(
                                    mainLabelStyle: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF2692FD),
                                    )
                                )
                            ),
                            min: 0,
                            max: 100,
                            initialValue: 80,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 25,right: 15,top: 5),
                                  child: Text('白石桥大区',style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 12,left: 25),
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFFF9600),width: 1), // 商圈经理橘色
//                                      border: Border.all(color: Color(0xFF9149EC),width: 1), // 总监紫色
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top:2,left:5,right: 5),
                                  child: Text(
                                    '今日总任务量：1000 , 未完成：200',
//                                      '总监',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFFF9600),  // 商圈经理橘色
//                                        color: Color(0xFF9149EC), // 总监紫色
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
                    ),
                  ),
                  // 成员列表
                  Padding(
                    padding: EdgeInsets.only(top: 40,bottom: 40),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.only(right: 15),
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
                                      padding: EdgeInsets.only(top:16),
                                      child: Text(
                                        '70%',
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
//                                      '买卖B组', // 商圈显示
                                        '长河湾北门店',  // 总监显示门店
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage()));
                                },
                                child: Image(image: AssetImage('images/next.png'),),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.only(right: 15),
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
                                      padding: EdgeInsets.only(top:16),
                                      child: Text(
                                        '70%',
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
//                                      '买卖B组', // 商圈显示
                                        '长河湾北门店',  // 总监显示门店
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage()));
                                },
                                child: Image(image: AssetImage('images/next.png'),),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.only(right: 15),
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
                                      padding: EdgeInsets.only(top:16),
                                      child: Text(
                                        '70%',
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
//                                      '买卖B组', // 商圈显示
                                        '长河湾北门店',  // 总监显示门店
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage()));
                                },
                                child: Image(image: AssetImage('images/next.png'),),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.only(right: 15),
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
                                      padding: EdgeInsets.only(top:16),
                                      child: Text(
                                        '70%',
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
//                                      '买卖B组', // 商圈显示
                                        '长河湾北门店',  // 总监显示门店
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage()));
                                },
                                child: Image(image: AssetImage('images/next.png'),),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.only(right: 15),
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
                                      padding: EdgeInsets.only(top:16),
                                      child: Text(
                                        '70%',
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
//                                      '买卖B组', // 商圈显示
                                        '长河湾北门店',  // 总监显示门店
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage()));
                                },
                                child: Image(image: AssetImage('images/next.png'),),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.only(right: 15),
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
                                      padding: EdgeInsets.only(top:16),
                                      child: Text(
                                        '70%',
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
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 200,
                                      child: Text(
//                                      '买卖B组', // 商圈显示
                                        '长河湾北门店',  // 总监显示门店
                                        style:TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage()));
                                },
                                child: Image(image: AssetImage('images/next.png'),),
                              )
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
