import 'package:ThumbSir/widget/month_analyze.dart';
import 'package:ThumbSir/widget/quarter_analyze.dart';
import 'package:ThumbSir/widget/week_analyze.dart';
import 'package:ThumbSir/widget/year_analyze.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/day_analyze.dart';

class QListAnalyzePage extends StatefulWidget {
  @override
  _QListAnalyzePageState createState() => _QListAnalyzePageState();
}

class _QListAnalyzePageState extends State<QListAnalyzePage> with SingleTickerProviderStateMixin{
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
                DayAnalyze(),
                WeekAnalyze(),
                MonthAnalyze(),
                QuarterAnalyze(),
                YearAnalyze(),
              ],
            ),
            // 顶部导航栏
            Positioned(
                top:20,
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