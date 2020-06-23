import 'package:ThumbSir/dao/get_mission_s_dao.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QListViewMiniTasksPage extends StatefulWidget {
  @override
  _QListViewMiniTasksPageState createState() => _QListViewMiniTasksPageState();
}

class _QListViewMiniTasksPageState extends State<QListViewMiniTasksPage> {
  var getMissionSResult;
  bool hasMission = false;
  var missionsResult;
  List<Widget> missions = [];
  bool _loading = false;

  _load()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final leaderId= prefs.getString("leaderID");
    final companyId= prefs.getString("companyID");
//    getMissionSResult = await GetMissionSDao.getMissionS(companyId, leaderId);
    getMissionSResult = await GetMissionSDao.getMissionS('61855513-8e71-4ec1-9151-a815abc8caf4', '01f1b334-913b-4527-880e-2c9168e4bd6b');
    if(getMissionSResult != null){
      if(getMissionSResult.code == 200){
        setState(() {
          _loading =false;
          missionsResult = getMissionSResult.data;
          print(missionsResult);
        });
        if( getMissionSResult.data.length != 0){
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
    _load();
    _onRefresh();
  }

  // 下级成员列表
  Widget missionsItem(){
    Widget content;
    if(missionsResult != null){
      for(var item in missionsResult) {
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
                    item.taskTittleA,
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
                  item.taskCountA.toString(),
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
                              child: Text('最低任务量',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            )
                          ],
                        ),
                      ),
                      // 查看最低任务
                      Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 20, 50),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '完成以下任务中的任选 3 项',
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
                      hasMission == true ?
                      missionsItem()
                      :
                      Container(
                          margin: EdgeInsets.only(top: 50),
                          width: 335,
                          height: 104,
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
                                  '您的上级未设置最低任务量',
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
                                '请根据实际情况安排工作',
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