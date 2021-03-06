import 'dart:convert';
import 'package:ThumbSir/dao/get_user_select_mission_dao.dart';
import 'package:ThumbSir/model/get_user_select_mission_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/qlist_check_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/mission_record_model.dart';
import 'package:ThumbSir/dao/get_user_mission_records_dao.dart';

class QListTaskListSearchResultPage extends StatefulWidget {
  final chooseDate;
  QListTaskListSearchResultPage({this.chooseDate});
  @override
  _QListTaskListSearchResultPageState createState() => _QListTaskListSearchResultPageState();
}

class _QListTaskListSearchResultPageState extends State<QListTaskListSearchResultPage> {
  DateTime selectedDate;
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginResultData userData;
  String uinfo;
  var result;


  var missionList;

  List<Datum> missions = [];
  List<Widget> missionsMorningShowList = [];
  List<Widget> msgs=[];

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
        selectedDate.toIso8601String().substring(0,10),
      );
      if (missionList.code == 200) {
        missions = missionList.data;
        if (missions.length>0) {

          for (var item in missions) {
            GetMissionRecord m_record= await UserSelectMissionDao.missionRecord(userData.userPid,item.id.toString(),userData.userLevel.substring(0,1));
            missionsMorningShowList.add(
//              name: item.taskName,
//              number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
//              time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
//              star: item.stars,
//              percent: item.finishRate,
//              remark: item.remark == null ? '暂无描述':item.remark,
//              address: item.address == null ? '暂未标注地点':item.address,
//              currentAddress: m_record.data==null?"还未上传":m_record.data.address,
//              taskId:item.id.toString(),
//              defaultId: item.defaultTaskId.toString(),
//              planCount:item.planningCount,
//              unit:item.taskUnit,
//              date: 1,
//              imgs:m_record.data==null?"":m_record.data.missionImgs,
//              startTime: item.planningStartTime,
//              endTime: item.planningEndTime,
//              pageIndex: this.widget.pageIndex,
//              tabIndex: this.widget.tabIndex,
//              callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
              QListCheckItem(
                name: item.taskName,
                number: item.defaultTaskId == 15 || item.defaultTaskId == 16 || item.defaultTaskId == 13? "":item.planningCount.toString()+item.taskUnit,
                time: item.planningStartTime.toIso8601String().substring(11,16)+'~'+item.planningEndTime.toIso8601String().substring(11,16),
                star: item.stars,
                percent: item.finishRate,
                remark: item.remark == null ? '暂无描述':item.remark,
                address: item.address == null ? '暂未标注地点':item.address,
                currentAddress: m_record.data==null?"还未上传":m_record.data.address,
                imgs:m_record.data==null?"":m_record.data.missionImgs
              ),
            );
          }
        }
        setState(() {
          msgs=missionsMorningShowList;
        });
      } else {
        _onLoadAlert(context);
      }
    }
  }

  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale = 'zh_Cn';
    selectedDate = widget.chooseDate;
    _getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
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
                        padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
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
                                  child: Text('往期量化任务',style: TextStyle(
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
                    // 选择日期
                    Align(
                      alignment: Alignment(0,-1),
                      child: Container(
                        width: 335,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(
                                color: Color(0x99CCCCCC),
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
                                  padding:EdgeInsets.only(left: 8,right: 8,top: 1),
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    child:Image(image: AssetImage('images/date.png')),
                                  ),
                                ),
                                Text(
                                  selectedDate.toIso8601String().substring(0,10),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => SomeCalendar(
                                      primaryColor: Color(0xff93C0FB),
                                      mode: SomeMode.Single,
                                      labels: new Labels(
                                        dialogDone: '确定',
                                        dialogCancel: '取消',
                                      ),
                                      isWithoutDialog: false,
                                      selectedDate: selectedDate,
                                      startDate: Jiffy().subtract(years: 3),
                                      lastDate: Jiffy().add(months: 9),
                                      textColor: Color(0xFF93C0FB),
                                      done: (date) {
                                        setState(() {
                                          selectedDate = date;
                                          missionsMorningShowList=[];
                                          _load();
                                        });
                                      },
                                    ));
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '日期',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Padding(
                                    padding:EdgeInsets.only(left: 5,right: 8),
                                    child: Image(image: AssetImage('images/next.png')),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // 量化列表
                    Padding(
                      padding: EdgeInsets.only(top:30,bottom:25),
                      child: msgs != [] && missions.length != 0?
                      Column(
                        children: msgs,
                      )
                          :
                      Container(
                          margin: EdgeInsets.only(top: 25),
                          width: 335,
                          height: 104,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 25,bottom: 8),
                                child: Text(
                                  '当日没有任务计划',
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
                                '换其他日期试试吧~',
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
                  ]
              )
            ],
          )
      ),
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
