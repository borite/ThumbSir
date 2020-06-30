import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AnalyzeDetailPage extends StatefulWidget {
  @override
  _AnalyzeDetailPageState createState() => _AnalyzeDetailPageState();
}

class _AnalyzeDetailPageState extends State<AnalyzeDetailPage> with SingleTickerProviderStateMixin{

  TabController _controller;
  var tabs = [];

  @override
  void initState() {
    super.initState();
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
                                padding: EdgeInsets.only(left: 10),
                                child: Text('长河湾北门店 2020-04-05至2020-05-05',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          )
                      ),
                      // 圆形进度条
                      Container(
                        width: 130,
                        height: 130,
                        padding: EdgeInsets.only(top:20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(65),
                        ),
                        child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                              startAngle: 280,
                              angleRange: 360,
                              customWidths: CustomSliderWidths(progressBarWidth: 12),
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
                          initialValue: 70,
                        ),
                      ),
                      // 完成度
                      Container(
                        padding: EdgeInsets.only(top:20,bottom: 40),
                        width: 335,
                        child: Text(
                          '完成度',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // 每一项
                      Container(
                          width: 335,
                          height: 110,
                          margin: EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(
                                  color: Color(0xFFcccccc),
                                  offset: Offset(0.0, 3.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0
                              )],
                              color: Colors.white
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.only(left: 15),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(image: AssetImage('images/my_big.png'),)
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 250,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            padding:EdgeInsets.fromLTRB(20, 15, 5, 10),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('带看',style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),),
                                              ],
                                            )
                                        ),
                                        Container(
                                            padding:EdgeInsets.fromLTRB(20, 15, 5, 5),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('经纪人-王菲菲',style: TextStyle(color: Color(0xFF93C0FB),fontSize: 14),),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('计划：共2000组',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text('已完成：1000组',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                                          ),
                                          Text('未完成：1000组',style: TextStyle(color: Color(0xFFF24848),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                      Container(
                          width: 335,
                          height: 110,
                          margin: EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(
                                  color: Color(0xFFcccccc),
                                  offset: Offset(0.0, 3.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0
                              )],
                              color: Colors.white
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.only(left: 15),
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
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image(image: AssetImage('images/my_big.png'),)
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 250,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            padding:EdgeInsets.fromLTRB(20, 15, 5, 10),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('带看',style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),),
                                              ],
                                            )
                                        ),
                                        Container(
                                            padding:EdgeInsets.fromLTRB(20, 15, 5, 5),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('经纪人-王菲菲',style: TextStyle(color: Color(0xFF93C0FB),fontSize: 14),),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('计划：共2000组',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text('已完成：1000组',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                                          ),
                                          Text('未完成：1000组',style: TextStyle(color: Color(0xFFF24848),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ]
                )
              ],
            )
        ),
      );
  }
}
