import 'dart:convert';
import 'package:ThumbSir/dao/get_personal_data_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/widget/pie_chart_support.dart';
import 'package:ThumbSir/widget/user_analyze_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:fl_chart/fl_chart.dart';

class QListAnalyzeChartPage extends StatefulWidget {
  @override
  _QListAnalyzeChartPageState createState() => _QListAnalyzeChartPageState();
}

class _QListAnalyzeChartPageState extends State<QListAnalyzeChartPage> with SingleTickerProviderStateMixin{
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loading = false;
  var sumResult;
  var listResult;
  var startTime = DateTime.now();
  var showEndTime = DateTime.now();
  var endTime = DateTime.now();

  List<Widget> showList = [];
  List<Widget> msgs=[];

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
    var getDataResult = await GetPersonalDataDao.getPersonalData(
        userData.userPid,
        userData.companyId,
        startTime.toIso8601String().substring(0,11)+'00:00:00.000000',
        endTime.toIso8601String().substring(0,11)+'23:59:59.000000',
    );
    if(getDataResult != null){
      if(getDataResult.code == 200){
          _loading =false;
          sumResult = getDataResult.data.zonghe;
          listResult = getDataResult.data.list;
          if (listResult.length>0) {
            for(var item in listResult) {
              showList.add(
                UserAnalyzeItem(
                  name: item.taskName,
                  sum:item.planCount.toString(),
                  finish: item.finishCount.toString(),
                  percent: item.finishRate*100,
                  timePercent: double.parse((item.timeProportion*100).toStringAsFixed(2)),
                  unit: item.taskUnit,
                ),
              );
            };
          }
          setState(() {
            msgs=showList;
          });
      }
    }else{
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _getUserInfo();
    _onRefresh();
    initializeDateFormatting();
    Intl.systemLocale = 'zh_Cn'; // to change the calendar format based on localization
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(top:80,bottom:40),
                        child: PieChartSupport(),
                    )
                )
              ],
            ),
            // 背景
            Positioned(
              child: Column(
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ClipPath(
                        clipper: BottomClipper(),
                        child:
                        //  背景
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF0E7AE6),Color(0xFF93C0FB)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image:AssetImage('images/circle_s.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            ),
            // 日期
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 40,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 返回
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                    child: Container(
                      width: 28,
                      color: Colors.transparent,
                      child: Image(image: AssetImage('images/back_white.png'),),
                    ),
                  ),
                  // 日期
                  GestureDetector(
                    onTap: ()async{
                      showDialog(
                          context: context,
                          builder: (_) => SomeCalendar(
                            mode: SomeMode.Range,
                            scrollDirection: Axis.horizontal,
                            startDate: Jiffy().subtract(years: 3),
                            lastDate: Jiffy().add(months: 1),
                            primaryColor: Color(0xff93C0FB),
                            textColor: Color(0xFF93C0FB),
                            isWithoutDialog: false,
                            selectedDates: selectedDates,
                            labels: Labels(
                              dialogCancel: '取消',
                              dialogDone: '确定',
                            ),
                            done: (date) {
                              setState(() {
                                selectedDates = date;
                                startTime = date[0];
                                showEndTime = date[date.length - 1];
                                endTime = date[date.length-1];
                                showList.clear();
                                _load();
                              });
                            },
                          )
                      );
                    },
                    child: Container(
                      width: 270,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(
                              color: Color(0x990E7AE6),
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
                                padding:EdgeInsets.only(left: 8,right: 8,top: 2),
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  child:Image(image: AssetImage('images/date.png')),
                                ),
                              ),
                              Text(
                                startTime.toIso8601String().substring(0,10) +'至'+showEndTime.toIso8601String().substring(0,10),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0E7AE6),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '日期',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left: 5,right: 8),
                                child: Image(image: AssetImage('images/next.png')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 右边
                  Container(width: 20,)
                ],
              ),
            ),
            // 完成度
            Align(
              alignment: Alignment(0,-1),
              child: Container(
                  width: 290,
                  height: 170,
                  margin: EdgeInsets.only(top: 110),
                  // 综合完成度
                  child: Text(
                    '温馨提示：时间占比以每天10小时为基数计算',
                    style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 10),
                    textAlign: TextAlign.center,
                  ),

              ),
            ),

          ],
        ),
      ),
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}

// 导航区域下曲线
class BottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height-70.0); //第2个点
    var firstControlPoint = Offset(size.width/2, size.height);
    var firstEdnPoint = Offset(size.width, size.height-70.0);
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEdnPoint.dx,
        firstEdnPoint.dy
    );
    path.lineTo(size.width, size.height-50.0); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}