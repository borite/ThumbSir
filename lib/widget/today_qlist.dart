import 'dart:convert';
import 'package:ThumbSir/widget/loading.dart';
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
//    _onRefresh();
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
  bool _loading = false;

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
          dateTime.toIso8601String(),
      );
      if (missionList.code == 200) {
        setState(() {
          missions = missionList.data;
          _loading = false;
        });
      } else {
        _onLoadAlert(context);
      }
    }
  }

  Widget taskMorningItem() {
    Widget content;
    if (missions != null) {
      for (var item in missions) {
        print(int.parse(item.planningEndTime.toIso8601String().substring(11,13)));
        if(int.parse(item.planningEndTime.toIso8601String().substring(11,13)) <= 12){
          missionsMorningShowList.add(
            QListItem(
              name: item.taskName,
              number: item.taskeCount.toString()+item.taskUnit,
              time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
              star: item.stars,
              percent: item.finishRate,
              remark: '客户很满意',
              address: '北京市海淀区',
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
              number: item.taskeCount.toString()+item.taskUnit,
              time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
              star: item.stars,
              percent: item.finishRate,
              pageIndex: this.widget.pageIndex,
              tabIndex: this.widget.tabIndex,
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
              number: item.taskeCount.toString()+item.taskUnit,
              time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
              star: item.stars,
              percent: item.finishRate,
              pageIndex: this.widget.pageIndex,
              tabIndex: this.widget.tabIndex,
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

    p = widget.pageIndex;
    t = widget.tabIndex;
    return Scaffold(
      body: ProgressDialog(
        loading: _loading,
        msg: "加载中...",
        child:ListView(
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
                )
            )
          ],
        ),
      )
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
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
