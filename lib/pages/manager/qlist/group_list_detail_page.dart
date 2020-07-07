import 'dart:convert';

import 'package:ThumbSir/dao/get_last_level_members_dao.dart';
import 'package:ThumbSir/dao/get_leader_data_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/qlist/team_list_member_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupListDetailPage extends StatefulWidget {
  final leaderArea;
  final leaderName;
  final leaderID;
  final leaderAreaRate;
  GroupListDetailPage({this.leaderArea,this.leaderName,this.leaderID,this.leaderAreaRate});
  @override
  _GroupListDetailPageState createState() => _GroupListDetailPageState();
}

class _GroupListDetailPageState extends State<GroupListDetailPage> {
  bool _loading = false;
  var leaderResult;
  var listResult;
  var leaderInfo;
  var leaderCount;
  var currentLevelResult;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];

  LoginResultData userData;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uinfo));
      });
    }
    if(userData != null){
      _load();
    }else{
      setState(() {
        _loading =false;
      });
    }
  }

  _load()async{
    var getLeaderResult = await GetLeaderDataDao.httpGetLeaderData(
        widget.leaderID,
        userData.companyId,
        dateTime
    );
    var getMemberListResult = await GetLastLevelMembersDao.httpGetLastLevelMembers(
        widget.leaderID,
        userData.companyId,
        dateTime
    );
    if(getMemberListResult != null && getLeaderResult != null ){
      if(getMemberListResult.code == 200 && getLeaderResult.code == 200){
        setState(() {
          _loading =false;
          listResult = getMemberListResult.data.list;
          leaderInfo = getLeaderResult.data.leaderInfo;
          leaderCount = getLeaderResult.data.leaderCount;
        });
        if(listResult != []){
          setState(() {
            hasMember = true;
          });
        }
      }else{
        setState(() {
          hasMember = false;
        });
      }
    }else{
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _getUserInfo();
    _onRefresh();
    super.initState();
  }

  // 下级成员列表
  Widget memberItem(){
    Widget content;
    if(listResult != null){
      for(var item in listResult) {
        showList.add(
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage(
                userId: item.userPid,
                userLevel: item.userLevel,
                userName: item.userName,
              )));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
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
                            border: Border.all(color: Color(0xFF93C0FB),width: 1)
                        ),
                        child:ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child:Image(
                              image: item.headImg != null ?
                              NetworkImage(item.headImg)
                                  :
                              AssetImage('images/my_big.png'),
                            )
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
                                  item.userName,
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
                                item.missionData != null ?
                                '今日计划：'+item.missionData.planningCount.toString()+'，已完成：'+item.missionData.finishCount.toString()
                                    :'今日无计划',
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
        );
      };
    }
    content =Column(
      children:showList,
    );
    return content;
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
                  // 分页
                  Container(
                    width: 335,
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child: Column(
                      children: <Widget>[
                        // 组名
                        Container(
                            margin: EdgeInsets.only(bottom: 25,top: 5),
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
                                          '区域',
                                          style:TextStyle(
                                            fontSize: 16,
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
                                              widget.leaderArea,
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
                                              leaderResult!=null ?
                                              '今日计划：'+leaderResult.planCount.toString()+'，已完成：'+leaderResult.finishCount.toString()
                                                  :'今日无计划',
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
                        // 店长
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListMemberPage(
                              userId: leaderInfo.userPid,
                              userLevel: leaderInfo.userLevel,
                              userName: leaderInfo.userName,
                            )));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
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
                                                border: Border.all(color: Color(0xFF24CC8E),width: 1)
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
                                                  border: Border.all(color: Color(0xFF24CC8E),width: 1),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(top:2,left:5,right: 5),
                                                child: Text(
                                                  leaderInfo!=null?leaderInfo.userLevel.substring(2,):"",
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
                                                leaderInfo != null?leaderInfo.userName:'',
                                                style:TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF333333),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 150,
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              leaderCount!=null?
                                              '今日计划：'+leaderCount.planningCount.toString()+'，已完成：'+leaderCount.finishCount.toString()
                                              :'今日无计划',
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
                        // 成员列表
                        hasMember == true ?
                        memberItem()
                            :
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                '还没有下级成员哦~',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Text(
                              '提醒该成员添加下级成员吧！',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ])
          ])
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}
