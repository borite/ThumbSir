import 'package:ThumbSir/dao/get_section_data_dao.dart';
import 'package:ThumbSir/widget/team_analyze_item.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';

class TeamAnalyzeDetailPage extends StatefulWidget {
  final section;
  final companyId;
  TeamAnalyzeDetailPage({this.section,this.companyId});
  @override
  _TeamAnalyzeDetailPageState createState() => _TeamAnalyzeDetailPageState();
}

class _TeamAnalyzeDetailPageState extends State<TeamAnalyzeDetailPage> with SingleTickerProviderStateMixin{
  var tabs = [];

  DateTime selectedDate = DateTime.now();
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

  _load()async{
    var getDataResult = await GetSectionDataDao.httpGetSectionData(
      widget.section,
      widget.companyId,
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
                TeamAnalyzeItem(
                  name: item.taskName,
                  sum:item.planCount.toString(),
                  finish: item.finishCount.toString(),
                  percent: item.finishRate==1.0?100:item.finishRate*100,
                  timePersent :double.parse((item.timeProportion*100).toStringAsFixed(2)),
                  unit: item.taskUnit,
                  taskId:item.defaultTaskId.toString(),
                  section:widget.section,
                  companyId:widget.companyId,
                  startTime:startTime.toIso8601String().substring(0,11)+'00:00:00.000000',
                  endTime:endTime.toIso8601String().substring(0,11)+'23:59:59.000000',
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
    _load();
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
            // 内容列表
            Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(top:240,bottom:25),
                            child: msgs != [] ?
                            Column(
                              children: msgs,
                            )
                                :Container(width: 1,)
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
                              height: 290,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF0E7AE6),Color(0xFF93C0FB)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                image: DecorationImage(
                                  image:AssetImage('images/circle_s.png'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                  ),
                ),
                // 日期
                Align(
                  alignment: Alignment(0,-1),
                  child: GestureDetector(
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
                      width: 335,
                      height: 40,
                      margin: EdgeInsets.only(top: 75),
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
                                padding:EdgeInsets.only(left: 8,right: 8,top: 1),
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
                ),
                // 综合完成度
                Align(
                  alignment: Alignment(0,-1),
                  child: Container(
                      width: 280,
                      height: 125,
                      margin: EdgeInsets.only(top: 140),
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
                      // 综合完成度
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(left: 20),
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      startAngle: 280,
                                      angleRange: 360,
                                      customWidths: CustomSliderWidths(progressBarWidth: 7),
                                      customColors: CustomSliderColors(
                                        progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                                        trackColor: Color(0x20CCCCCC),
                                        dotColor: Colors.transparent,
                                      ),
                                      infoProperties: InfoProperties(
                                          mainLabelStyle: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF2692FD),
                                          )
                                      )
                                  ),
                                  min: 0,
                                  max: 100,
                                  initialValue: sumResult != null ? sumResult.finishRate*100:0,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                      width: 150,
                                      padding:EdgeInsets.fromLTRB(20, 10, 10, 10),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '综合完成度',
                                            style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 150,
                                      padding:EdgeInsets.fromLTRB(20, 0, 10, 5),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            sumResult != null ? '计划：共'+sumResult.planCount.toString()+'项':'计划：共0项',
                                            style: TextStyle(color: Color(0xFF666666),fontSize: 14),textAlign: TextAlign.left,),
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 150,
                                      padding:EdgeInsets.fromLTRB(20, 0, 10, 10),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            sumResult != null ? '已完成：'+sumResult.finishCount.toString()+'项':'已完成：4项',
                                            style: TextStyle(color: Color(0xFF666666),fontSize: 14),textAlign: TextAlign.left,),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 250,
                            child: Text(
                              '温馨提示：时间占比以每天10小时为基数计算',
                              style: TextStyle(color: Color(0xFF999999),fontSize: 10),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),

                  ),
                ),
              ],
            ),
            // 导航栏
            Padding(
                padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image(image: AssetImage('images/back_white.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.section+'团队分析',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                          ),),
                        )
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
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
