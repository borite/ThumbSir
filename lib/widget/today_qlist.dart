import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_user_select_mission_dao.dart';
import 'package:ThumbSir/model/get_user_select_mission_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ThumbSir/model/mission_record_model.dart';
import 'package:ThumbSir/dao/get_user_mission_records_dao.dart';


class TodayQList extends StatefulWidget {
  TodayQList({Key key,this.tabIndex,this.callBack }):super(key:key);
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
    animation = Tween<double>(begin: 700,end:25).animate(
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
  List<Widget> missionsShowList = [];

  List<Widget> Msgs=[];

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
            GetMissionRecord m_record= await UserSelectMissionDao.missionRecord(userData.userPid,item.id.toString(),userData.userLevel.substring(0,1));

            missionsShowList.add(
              QListItem(
                name: item.taskName,
                number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
                time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
                star: item.stars,
                percent: item.finishRate,
                remark: item.remark == null ? '暂无描述':item.remark,
                address: item.address == null ? '暂未标注地点':item.address,
                currentAddress: m_record.data==null?"还未上传":m_record.data.address,
                taskId:item.id.toString(),
                defaultId: item.defaultTaskId.toString(),
                planCount:item.planningCount,
                unit:item.taskUnit,
                date: 1,
                userID:userData.userPid,
                userLevel:userData.userLevel,
                imgs:m_record.data==null?"":m_record.data.missionImgs,
                startTime: item.planningStartTime,
                endTime: item.planningEndTime,
                tabIndex: this.widget.tabIndex,
                callBack: ()=>onChange(this.widget.tabIndex),
              ),
            );

          }
        }
        setState(() {
          Msgs=missionsShowList;
        });
      } else {
        _onLoadAlert(context);
      }
    }
  }

  int t;
  void onChange(tIndex){
    setState(() {
      t = tIndex;
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(top:140,bottom:50),
                  child: missions.length !=0 && Msgs != []?
                  Column(
                    children: Msgs,
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
      title: "加载失败",
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
