import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/widget/group_member_list.dart';
import 'package:ThumbSir/widget/team_analyze_group_detail_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class TeamAnalyzeGroupDetailPage extends StatefulWidget {
  @override
  _TeamAnalyzeGroupDetailPageState createState() => _TeamAnalyzeGroupDetailPageState();
}

class _TeamAnalyzeGroupDetailPageState extends State<TeamAnalyzeGroupDetailPage> {
  final _pageIndicatiorController = PageController(viewportFraction: 0.8);
  @override
  void dispose(){
    _pageIndicatiorController.dispose();
    super.dispose();
  }
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
                                child: Text('团队分析',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                  // 分页
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Stack(
                      children: <Widget>[
                        // 内容
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 300,
                            maxHeight: 1100,
                          ),
                          child: PageView(
                            controller: _pageIndicatiorController,
                            children: List.generate(3, (_) => TeamAnalyzeGroupDetailWidget())
                          )
                        ),
                        // 分页器
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 100),
                            child: SmoothPageIndicator(
                              controller: _pageIndicatiorController,
                              count: 3,
                              effect: WormEffect(
                                activeDotColor: Color(0xFF93C0FB), // 高亮颜色
                                dotColor: Color(0xFFCCCCCC),
                                spacing: 10, // 间距
                                dotWidth: 5,
                                dotHeight: 5,
                              ),
                            ),
                          ),
                        ),
                      ]
                    )
                  )
                ])
          ])
    );
  }
}
