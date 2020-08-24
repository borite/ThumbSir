import 'dart:convert';

import 'package:ThumbSir/dao/get_mission_a_dao.dart';
import 'package:ThumbSir/dao/get_mission_s_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMyMiniTasksPage extends StatefulWidget {
  @override
  _ViewMyMiniTasksPageState createState() => _ViewMyMiniTasksPageState();
}

class _ViewMyMiniTasksPageState extends State<ViewMyMiniTasksPage> {
  var getMissionAResult;
  bool hasMission = false;
  var missionsResult;
  List<Widget> missions = [];
  bool _loading = false;

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
    getMissionAResult = await GetMissionADao.getMissionA(userData.userPid, userData.userPid, (int.parse(userData.userLevel.substring(0,1))+1).toString(), userData.companyId);
    if(getMissionAResult != null){
      if(getMissionAResult.code == 200){
        setState(() {
          _loading =false;
          missionsResult = getMissionAResult.data;
        });
        if( getMissionAResult.data.list.length != 0){
          hasMission = true;
        }
      }else{
        setState(() {
          hasMission = false;
          _loading = false;
        });
      }
    }else{
      setState(() {
        hasMission = false;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _onRefresh();
  }

  // 任务列表
  Widget missionsItem(){
    Widget content;
    if(missionsResult != null){
      for(var item in missionsResult.list) {
        missions.add(
          Container(
            width: 335,
            height: 50,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
            ),
            child: Row(
              children: <Widget>[
                Image(image: AssetImage('images/task.png'),),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 30),
                  child: Text(
                    item.taskTitle,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  item.taskCount.toString(),
                  style: TextStyle(
                    color: Color(0xFF0E7AE6),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10,top: 5),
                  child: Text(
                    item.taskUnit,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      };
    }
    content =Column(
      children: missions,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressDialog(
        loading: _loading,
        msg:"加载中...",
        child:Container(
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
                              padding: EdgeInsets.only(left: 20),
                              child: Text('为下级设置的最低任务量',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          // 查看最低任务
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    missionsResult != null ?
                                    '下级应每天完成以下任务中的任选 '+missionsResult.minCount.toString()+' 项'
                                    :'完成以下任务中的任选 1 项',
                                    style: TextStyle(
                                      color: Color(0xFF0E7AE6),
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          // 休息
                          Container(
                            width: 335,
                            height: 50,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                            ),
                            child: Row(
                              children: <Widget>[
                                Image(image: AssetImage('images/task.png'),),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 30),
                                  child: Text(
                                    '休息',
                                    style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    '全天',
                                    style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5,left: 15),
                                  child: Text(
                                    '若选择全天休息，当日任务不统计',
                                    style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 任务
                          userData != null && hasMission == true ?
                          missionsItem()
                              :
                          Container(
                              margin: EdgeInsets.only(top: 50),
                              width: 335,
                              height: 84,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [BoxShadow(
                                      color: Color(0xFFcccccc),
                                      offset: Offset(0.0, 3.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0
                                  )
                                  ],
                                  color: Colors.white
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 25,bottom: 8),
                                    child: Text(
                                      '您还没有为下级设置最低任务量',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 20,
                                        color: Color(0xFFCCCCCC),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                    ]
                )
              ],
            )
        )
        )
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}

Widget hourMinute(){
  return TimePickerSpinner(
    normalTextStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFF666666),
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
    ),
    highlightedTextStyle: TextStyle(
      fontSize: 20,
      color: Color(0xFF0E7AE6),
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFF0E7AE6),
      decorationStyle: TextDecorationStyle.solid,
      fontWeight: FontWeight.normal,
    ),
    itemWidth: 40,
    spacing: 50,
    itemHeight: 40,
    isForce2Digits: true,
    onTimeChange: (time) {
//      setState(() {
//        _dateTime = time;
//      });
    },
  );
}