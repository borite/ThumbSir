import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_user_select_mission_dao.dart';
import 'package:ThumbSir/model/get_user_select_mission_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayQList extends StatefulWidget {
  TodayQList({Key key,this.pageIndex,this.tabIndex,this.callBack }):super(key:key);
  int pageIndex;
  int tabIndex;
  final callBack;
  @override
  _TodayQListState createState()=> _TodayQListState();
}

class _TodayQListState extends State<TodayQList> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState(){
    _getUserInfo();
    controller = AnimationController(vsync:this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 500,end:25).animate(
        CurvedAnimation(parent: controller,curve: Curves.easeInOut)
          ..addListener(() {
            setState(() {
              animationValue = animation.value;
            });
          })
          ..addStatusListener((AnimationStatus state) {
            setState(() {
              animationStatus = state;
            });
          })
    );

    controller.forward();
    super.initState();
  }
  DateTime dateTime = DateTime.now();

  var missionList;

  List<Datum> missions = [];
  List<Widget> missionsMorningShowList = [];
  List<Widget> missionsNoonShowList = [];
  List<Widget> missionsEveningShowList = [];

  List<Widget> morningMsgs=[];
  List<Widget> noonMsgs=[];
  List<Widget> eveningMsgs=[];

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
    if(userData != null ){
      missionList = await GetUserSelectMissionDao.getMissions(
          userData.userPid,
          userData.userLevel.substring(0,1),
          dateTime.toIso8601String().substring(0,10),
      );
      if (missionList.code == 200) {
        missions = missionList.data;
        if (missions.length>0) {
          for (var item in missions) {
            if(int.parse(item.planningEndTime.toIso8601String().substring(11,13)) <= 12){
              missionsMorningShowList.add(
                QListItem(
                  name: item.taskName,
                  number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
                  time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
                  star: item.stars,
                  percent: item.finishRate,
                  remark: item.remark == null ? '暂无描述':item.remark,
                  address: item.address == null ? '暂未标注地点':item.address,
                  currentAddress: '北京市海淀区',
                  taskId:item.id.toString(),
                  defaultId: item.defaultTaskId.toString(),
                  planCount:item.planningCount,
                  unit:item.taskUnit,
                  date: 1,
                  startTime: item.planningStartTime,
                  endTime: item.planningEndTime,
                  pageIndex: this.widget.pageIndex,
                  tabIndex: this.widget.tabIndex,
                  callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                ),
              );
            }
            if( int.parse(item.planningEndTime.toIso8601String().substring(11,13))>12 && int.parse(item.planningEndTime.toIso8601String().substring(11,13))<=18){
              missionsNoonShowList.add(
                QListItem(
                  name: item.taskName,
                  number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
                  time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
                  star: item.stars,
                  percent: item.finishRate,
                  remark: item.remark == null ? '暂无描述':item.remark,
                  unit:item.taskUnit,
                  pageIndex: this.widget.pageIndex,
                  tabIndex: this.widget.tabIndex,
                  taskId:item.id.toString(),
                  defaultId: item.defaultTaskId.toString(),
                  planCount:item.planningCount,
                  startTime: item.planningStartTime,
                  endTime: item.planningEndTime,
                  date: 1,
                  address: item.address == null ? '暂未标注地点':item.address,
                  callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                ),
              );
            }
            if(int.parse(item.planningEndTime.toIso8601String().substring(11,13)) > 18){
              missionsEveningShowList.add(
                QListItem(
                  name: item.taskName,
                  number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
                  time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
                  star: item.stars,
                  percent: item.finishRate,
                  remark: item.remark == null ? '暂无描述':item.remark,
                  taskId:item.id.toString(),
                  unit:item.taskUnit,
                  defaultId: item.defaultTaskId.toString(),
                  planCount:item.planningCount,
                  date: 1,
                  startTime: item.planningStartTime,
                  endTime: item.planningEndTime,
                  pageIndex: this.widget.pageIndex,
                  tabIndex: this.widget.tabIndex,
                  address: item.address == null ? '暂未标注地点':item.address,
                  callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                ),
              );
            }
          }
        }
        setState(() {
          morningMsgs=missionsMorningShowList;
          noonMsgs=missionsNoonShowList;
          eveningMsgs = missionsEveningShowList;
        });
      } else {
        _onLoadAlert(context);
      }
    }
  }

  int p;
  int t;
  void onChange(pIndex,tIndex){
    setState(() {
      p = pIndex;
      t = tIndex;
    });
  }
  @override
  Widget build(BuildContext context) {

    p = widget.pageIndex;
    t = widget.tabIndex;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              constraints: BoxConstraints(
                  minHeight: 800
              ),
              decoration: BoxDecoration(color: Colors.white),
              child:Container(
                  width: 335,
                  padding: EdgeInsets.only(top:240,bottom:50),
                  child: missions.length !=0 && morningMsgs != [] && widget.pageIndex == 0?
                  Column(
                    children: morningMsgs,
                  )
                      :missions.length !=0 && noonMsgs != [] && widget.pageIndex == 1?
                  Column(
                    children: noonMsgs,
                  )
                      :missions.length !=0 && eveningMsgs != [] && widget.pageIndex == 2?
                  Column(
                    children: eveningMsgs,
                  )
                      :
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: animation.value),
                      width: 335,
                      height: 104,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 25,bottom: 8),
                            child: Text(
                              '还没有任务计划',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Color(0xFFCCCCCC),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            '点击下方"新增任务"按钮去添加任务吧~',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              color: Color(0xFFCCCCCC),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  )
              )

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
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
