import 'package:ThumbSir/widget/team_day_pie_analyze.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TeamAnalyzePiePage extends StatefulWidget {
  @override
  _TeamAnalyzePiePageState createState() => _TeamAnalyzePiePageState();
}

class _TeamAnalyzePiePageState extends State<TeamAnalyzePiePage> with SingleTickerProviderStateMixin{
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
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            // 内容列表
            TabBarView(
              controller: _controller,
              children: <Widget>[
                TeamDayPieAnalyze(),
                TeamDayPieAnalyze(),
                TeamDayPieAnalyze(),
                TeamDayPieAnalyze(),
                TeamDayPieAnalyze(),
              ],
            ),
            // 导航栏
            Padding(
                padding: EdgeInsets.fromLTRB(15, 46, 15, 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image(image: AssetImage('images/back_white.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('长河湾北门店时间分布',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                        )
                      ],
                    ),
                  ],
                )
            ),
            // 顶部导航栏
            Positioned(
                top:70,
                child: Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: TabBar(
                    tabs: tabs,
                    controller: _controller,
                    isScrollable: true, // 可以左右滑动
                    labelColor: Colors.white,
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
                )
            ),
          ],
        ),
      ),
    );
  }
}
