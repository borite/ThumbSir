import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/widget/group_member_list.dart';
import 'package:ThumbSir/widget/teams_member_list.dart';
import 'package:flutter/material.dart';

class ZCenterGroupDetailPage extends StatefulWidget {
  @override
  _ZCenterGroupDetailPageState createState() => _ZCenterGroupDetailPageState();
}

class _ZCenterGroupDetailPageState extends State<ZCenterGroupDetailPage> {
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
                  // 列表
                  TeamsMemberList()
                ])
          ])
    );
  }
}
