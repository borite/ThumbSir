import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/widget/group_member_list.dart';
import 'package:ThumbSir/widget/team_list_detail_widget.dart';
import 'package:ThumbSir/widget/teams_member_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class TeamListDetailPage extends StatefulWidget {
  @override
  _TeamListDetailPageState createState() => _TeamListDetailPageState();
}

class _TeamListDetailPageState extends State<TeamListDetailPage> {
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
                                child: Text('团队量化',style: TextStyle(
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
                  // 列表
                  TeamListDetailWidget()
                ])
          ])
    );
  }
}
