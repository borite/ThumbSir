// 用于团队量化分析的详情页

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TeamAnalyzeItemDetailPage extends StatefulWidget {
  @override
  _TeamAnalyzeItemDetailPageState createState() => _TeamAnalyzeItemDetailPageState();
}

class _TeamAnalyzeItemDetailPageState extends State<TeamAnalyzeItemDetailPage> with SingleTickerProviderStateMixin{

  TabController _controller;
  var tabs = [];

  @override
  void initState() {
    _controller = TabController(length: 5,vsync: this);
    tabs = <Tab>[
      Tab(text: '日汇总',),
      Tab(text: '周汇总',),
      Tab(text: '月汇总',),
      Tab(text: '季度汇总',),
      Tab(text: '年度汇总',),
    ];
    super.initState();
  }

  // 防止页面销毁时内存泄漏造成性能问题
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
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
                                child: Text(
                                  '长河湾北门店-带看分析',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      // 日历导航栏
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: TabBar(
                          tabs: tabs,
                          controller: _controller,
                          isScrollable: true, // 可以左右滑动
                          labelColor: Color(0xFF5580EB),
                          labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Color(0xFF0E7AE6),
                              width: 3,
                            ),
                            insets: EdgeInsets.only(bottom: 10),
                          ),
                          labelStyle: TextStyle(fontSize: 20),
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                        ),
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
                          height: 160,
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
                                margin: EdgeInsets.only(left: 20),
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      startAngle: 280,
                                      angleRange: 360,
                                      customWidths: CustomSliderWidths(progressBarWidth: 5),
                                      customColors: CustomSliderColors(
                                        progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                                        trackColor: Color(0x20CCCCCC),
                                        dotColor: Colors.transparent,
                                      ),
                                      infoProperties: InfoProperties(
                                          mainLabelStyle: TextStyle(
                                            fontSize: 16,
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
                                children: <Widget>[
                                  Container(
                                    width: 250,
                                    padding:EdgeInsets.fromLTRB(20, 15, 5, 10),
                                    child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('带看',style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),),
                                        ],
                                    )
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('已完成：1000组',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('未完成：1000组',style: TextStyle(color: Color(0xFFF24848),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('时间：2020-5-20 14:00-15:00',style: TextStyle(color: Color(0xFF93C0FB),fontSize: 14),),
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
                          height: 160,
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
                                margin: EdgeInsets.only(left: 20),
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      startAngle: 280,
                                      angleRange: 360,
                                      customWidths: CustomSliderWidths(progressBarWidth: 5),
                                      customColors: CustomSliderColors(
                                        progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                                        trackColor: Color(0x20CCCCCC),
                                        dotColor: Colors.transparent,
                                      ),
                                      infoProperties: InfoProperties(
                                          mainLabelStyle: TextStyle(
                                            fontSize: 16,
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
                                children: <Widget>[
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 15, 5, 10),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('带看',style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),),
                                        ],
                                      )
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('已完成：1000组',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('未完成：1000组',style: TextStyle(color: Color(0xFFF24848),fontSize: 14),),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 250,
                                      padding:EdgeInsets.fromLTRB(20, 0, 5, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('时间：2020-5-20 14:00-15:00',style: TextStyle(color: Color(0xFF93C0FB),fontSize: 14),),
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
