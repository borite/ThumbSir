import 'dart:convert';
import 'package:new_lianghua_app/dao/get_user_mission_records_dao.dart';
import 'package:new_lianghua_app/dao/get_user_select_mission_dao.dart';
import 'package:new_lianghua_app/widget/qlist_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_result_data_model.dart';
import 'package:new_lianghua_app/model/get_user_select_mission_model.dart';


class TodayQList extends StatefulWidget {
  TodayQList({Key? key,required this.tabIndex,this.callBack }):super(key:key);
  int tabIndex;
  final callBack;
  @override
  _TodayQListState createState()=> _TodayQListState();
}

class _TodayQListState extends State<TodayQList> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;
  
  @override
  void initState(){

    _getUserInfo();
    controller = AnimationController(vsync:this,duration: const Duration(seconds: 1));
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

  dynamic missionList;

  List<Datum> missions = [];
  List<Widget> missionsShowList = [];

  List<Widget> Msgs=[];

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
    _load();
  }

  _load() async {
    if(userData != null ){
      missionList = await GetUserSelectMissionDao.getMissions(
          userData!.userPid,
          userData!.userLevel.substring(0,1),
          dateTime.toIso8601String().substring(0,10),
      );

      if (missionList.code == 200) {
        missions = missionList.data;
        if (missions.isNotEmpty) {

          for (var item in missions) {
            dynamic mission= await GetMissionRecordDao.missionRecord(userData!.userPid,item.id.toString(),userData!.userLevel.substring(0,1));

            missionsShowList.add(
              QListItem(
                name: item.taskName,
                number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
                time: item.planningStartTime!.toIso8601String().substring(11,16)+'~'+item.planningEndTime!.toIso8601String().substring(11,16),
                star: item.stars,
                percent: item.finishRate,
                remark: item.remark ?? '暂无描述',
                address: item.address ?? '暂未标注地点',
                currentAddress: mission.data==null?"还未上传":mission.data.address,
                taskId:item.id.toString(),
                defaultId: item.defaultTaskId.toString(),
                planCount:item.planningCount,
                unit:item.taskUnit,
                date: 1,
                userID:userData!.userPid,
                userLevel:userData!.userLevel,
                imgs:mission.data==null?"":mission.data.missionImgs,
                startTime: item.planningStartTime,
                endTime: item.planningEndTime,
                tabIndex: widget.tabIndex,
                callBack: ()=>onChange(widget.tabIndex),
                pageIndex: 0,
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

  late int t;
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
              constraints: const BoxConstraints(
                  minHeight: 800
              ),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end:Alignment.bottomCenter,
                      colors: [Color.fromRGBO(208, 240, 238, 1),Color.fromRGBO(228, 233, 250, 1),Color.fromRGBO(234, 239, 253, 1)]
                  )
              ),
              child:Container(
                  padding: const EdgeInsets.only(top:90,bottom:25),
                  child: missions.isNotEmpty && Msgs != []?
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
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top:25,bottom:8),
                            child: Text(
                              '还没有任务计划',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Colors.black12,
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
                              color: Colors.black12,
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
          child: const Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF6E85D3),
        )
      ],
    ).show();
  }
}
