import 'package:ThumbSir/dao/get_user_select_mission_dao.dart';
import 'package:ThumbSir/widget/gift_item.dart';
import 'package:ThumbSir/widget/qlist_check_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/get_user_select_mission_model.dart';
import 'package:ThumbSir/model/mission_record_model.dart';
import 'package:ThumbSir/dao/get_user_mission_records_dao.dart';

class TeamTradedMemberPage extends StatefulWidget {
  final userId;
  final userLevel;
  final userName;
  TeamTradedMemberPage({this.userId,this.userLevel,this.userName});
  @override
  _TeamTradedMemberPageState createState() => _TeamTradedMemberPageState();
}

class _TeamTradedMemberPageState extends State<TeamTradedMemberPage> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var missionList;

  List<Datum> missions = [];
  List<Widget> missionsMorningShowList = [];
  List<Widget> msgs=[];

  _load() async {
    var missionList = await GetUserSelectMissionDao.getMissions(
      widget.userId,
      widget.userLevel.substring(0,1),
      selectedDate.toIso8601String().substring(0,10),
    );
    if (missionList.code == 200) {
        missions = missionList.data;
        if (missions.length>0) {
          for (var item in missions) {
            GetMissionRecord m_record= await UserSelectMissionDao.missionRecord(widget.userId,item.id.toString(),widget.userLevel.substring(0,1));
            print(m_record);
            missionsMorningShowList.add(
              GiftItem(
                date:"2020-01-23",
                giftMsg:"故宫礼盒套装",
                price:"288",
                dec:"邮寄",
                type:"业务礼",
                item: item,
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
  @override
  void initState() {
    _load();
    initializeDateFormatting();
    Intl.systemLocale = 'zh_Cn';
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
                                  child: Text(
                                    widget.userName+'的客户',
                                    style: TextStyle(
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
                    // 客户列表
                    Padding(
                      padding: EdgeInsets.only(top:30,bottom:25),
                      child: missions.length != 0  && msgs != [] ?
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
                                  '该成员未添加客户',
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
                                '提醒TA添加吧~',
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
