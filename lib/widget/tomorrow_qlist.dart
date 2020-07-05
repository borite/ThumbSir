import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ThumbSir/dao/get_user_select_mission_dao.dart';
import 'package:ThumbSir/model/get_user_select_mission_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TomorrowQList extends StatefulWidget {
  TomorrowQList({Key key,this.pageIndex,this.tabIndex,this.callBack }):super(key:key);
  int pageIndex;
  int tabIndex;
  final callBack;
  @override
  _TomorrowQListState createState() => _TomorrowQListState();
}

class _TomorrowQListState extends State<TomorrowQList>  with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController animationcController;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState(){
    _getUserInfo();
    animationcController = AnimationController(vsync:this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 500,end:25).animate(
        CurvedAnimation(parent: animationcController,curve: Curves.easeInOut)
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

    animationcController.forward();
    super.initState();
  }
  DateTime dateTime = DateTime.now().add(Duration(days: 1));

  var missionList;

  List<Datum> missions = [];
  List<Widget> missionsMorningShowList = [];
  List<Widget> missionsNoonShowList = [];
  List<Widget> missionsEveningShowList = [];

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
        setState(() {
          missions = missionList.data;
        });
      }
    }
  }

  Widget taskMorningItem() {
    Widget content;
    if (missions != null) {
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
              pageIndex: this.widget.pageIndex,
              tabIndex: this.widget.tabIndex,
              callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
            ),
          );
        }

      }
    }
    content = Column(
      children: missionsMorningShowList,
    );

    return content;
  }
  Widget taskNoonItem() {
    Widget content;
    if (missions != null) {
      for (var item in missions) {
        if( int.parse(item.planningEndTime.toIso8601String().substring(11,13))>12 && int.parse(item.planningEndTime.toIso8601String().substring(11,13))<=18){
          missionsNoonShowList.add(
            QListItem(
              name: item.taskName,
              number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
              time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
              star: item.stars,
              percent: item.finishRate,
              remark: item.remark == null ? '暂无描述':item.remark,
              pageIndex: this.widget.pageIndex,
              tabIndex: this.widget.tabIndex,
              address: item.address == null ? '暂未标注地点':item.address,
              callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
            ),
          );
        }

      }
    }
    content = Column(
      children: missionsNoonShowList,
    );

    return content;
  }
  Widget taskEveningItem() {
    Widget content;
    if (missions != null) {
      for (var item in missions) {
        if(int.parse(item.planningEndTime.toIso8601String().substring(11,13)) > 18){
          missionsEveningShowList.add(
            QListItem(
              name: item.taskName,
              number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
              time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
              star: item.stars,
              percent: item.finishRate,
              remark: item.remark == null ? '暂无描述':item.remark,
              pageIndex: this.widget.pageIndex,
              tabIndex: this.widget.tabIndex,
              address: item.address == null ? '暂未标注地点':item.address,
              callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
            ),
          );
        }

      }
    }
    content = Column(
      children: missionsEveningShowList,
    );

    return content;
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
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              constraints: BoxConstraints(
                  minHeight: 800
              ),
              decoration: BoxDecoration(color: Colors.white),
              child:Padding(
                padding: EdgeInsets.only(top:240,bottom:25),
                child: missions.length != 0 && widget.pageIndex == 0?
                taskMorningItem()
                    :missions.length != 0 && widget.pageIndex == 1?
                taskNoonItem()
                    :missions.length != 0 && widget.pageIndex == 2?
                taskEveningItem()
                    :
                Container(
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
                ),
              ))
        ],
      ),
    );
  }
}