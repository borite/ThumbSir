import 'dart:convert';
import 'package:ThumbSir/dao/get_mission_s_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChooseMiniTaskNumberPage extends StatefulWidget {
  @override
  _ChooseMiniTaskNumberPageState createState() => _ChooseMiniTaskNumberPageState();
}

class _ChooseMiniTaskNumberPageState extends State<ChooseMiniTaskNumberPage> {
  int itemCount = 1;
  bool _loading = false;
  var taskListResult;
  List<Widget> taskList = [];

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
      _load();
    }
  }
  _load() async {
    if(userData != null){
      taskListResult = await GetMissionSDao.getMissionS(userData.userPid, userData.userLevel.substring(0,1), userData.companyId);
      if (taskListResult.code == 200) {
        setState(() {
          _loading = false;
        });
      } else {
        _onLoadAlert(context);
      }
    }
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  // 下级成员列表
  Widget taskListItem(){
    Widget content;
    if( taskListResult.data != null){
      for(var item in taskListResult.data) {
        taskList.add(
          Container(
            width: 335,
            height: 60,
            margin: EdgeInsets.only(top: 20),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20,right: 15),
                        child: Image(image: AssetImage('images/task.png'),),
                      ),
                      Text(
                        item.taskTitle != null ? item.taskTitle: '无',
                        style: TextStyle(
                        color: Color(0xFF5580EB),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFF5580EB),width: 1),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            if(itemCount >= 2){
                              setState(() {
                                itemCount = itemCount - 1;
                              });
                            }else{}
                          },
                          child: Text('-',style: TextStyle(
                            color: Color(0xFF5580EB),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),textAlign: TextAlign.center,),
                        ),
                      ),
                      Text(
                        item.taskCount,
                        style: TextStyle(
                          color: Color(0xFF5580EB),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),),
                      Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(left: 15,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFF5580EB),width: 1),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              itemCount = itemCount + 1;
                              item.taskCount = itemCount.toString();
                            });
                          },
                          child: Text('+',style: TextStyle(
                            color: Color(0xFF5580EB),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),textAlign: TextAlign.center,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          item.taskUnit != null ? item.taskUnit+'/人/天' :'无/人/天',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                        ),),
                      ),
                    ],
                  )
                ]),
          ),
        );
      };
    }

    content =Column(
      children: taskList,
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
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('为下级设置最低任务量',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        ],
                      ),
                  ),
                  // 编辑任务数量
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              '编辑任务数量',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      )
                  ),
                  // 说明
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '设置每一项任务的每天最低完成数量：',
                            style: TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  // 每一项
                  taskList == [] ?
                  taskListItem()
                  :
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      '没有数据',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFCCCCCC),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // 完成
                  Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 50,top: 100),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF5580EB)
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: GestureDetector(
                            onTap: (){
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
                            },
                            child: Text('完成',style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.center,),
                          )
                      )
                  ),
                ]
            )
          ],
        )
    );
  }
  _onLoadAlert(context) {
    Alert(
      context: context,
      title: "加载任务失败",
      desc: "请检查网络连接情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _loading = false;
            });
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
