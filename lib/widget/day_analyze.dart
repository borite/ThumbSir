import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'analyze_item.dart';

class DayAnalyze extends StatefulWidget {
  @override
  _DayAnalyzeState createState() => _DayAnalyzeState();
}

class _DayAnalyzeState extends State<DayAnalyze> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale = 'zh_Cn';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.only(top:270,bottom:25),
                  child:Column(
                    children: <Widget>[
                      // 每一条量化
                      AnalyzeItem(
                        name: "带看",
                        sum:"3",
                        finish: "2",
                        percent: 80,
                      ),
                      AnalyzeItem(
                        name: "带看",
                        sum:"3",
                        finish: "2",
                        percent: 100,
                      ),
                      AnalyzeItem(
                        name: "带看",
                        sum:"3",
                        finish: "2",
                        percent: 100,
                      ),
                      AnalyzeItem(
                        name: "带看",
                        sum:"3",
                        finish: "2",
                        percent: 50,
                      ),
                      AnalyzeItem(
                        name: "带看",
                        sum:"3",
                        finish: "2",
                        percent: 80,
                      ),
                    ],
                  ),
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
                      height: 300,
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
          child: Container(
            width: 335,
            height: 40,
            margin: EdgeInsets.only(top: 80),
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
                      padding:EdgeInsets.only(left: 8,right: 8),
                      child: Image(image: AssetImage('images/date.png')),
                    ),
                    Text(
                      '2020-04-05',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0E7AE6),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => _onDayPicker(context),
                  child: Row(
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
                )
              ],
            ),
          ),
        ),
        // 完成度
        Align(
          alignment: Alignment(0,-1),
          child: Container(
            width: 290,
            height: 150,
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
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(left: 20),
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        startAngle: 280,
                        angleRange: 360,
                        customWidths: CustomSliderWidths(progressBarWidth: 10),
                        customColors: CustomSliderColors(
                          progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                          trackColor: Color(0x20CCCCCC),
                          dotColor: Colors.transparent,
                        ),
                        infoProperties: InfoProperties(
                            mainLabelStyle: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF2692FD),
                            )
                        )
                    ),
                    min: 0,
                    max: 100,
                    initialValue: 80,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                        padding:EdgeInsets.fromLTRB(20, 15, 10, 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('综合完成度',style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),),
                          ],
                        )
                    ),
                    Padding(
                        padding:EdgeInsets.fromLTRB(0, 0, 10, 10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('计划：共6项',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                          ],
                        )
                    ),
                    Padding(
                        padding:EdgeInsets.fromLTRB(0, 0, 10, 10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('已完成：4项',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                          ],
                        )
                    ),
                    Padding(
                        padding:EdgeInsets.fromLTRB(0, 0, 10, 10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('未完成：2项',style: TextStyle(color: Color(0xFFF24848),fontSize: 14),),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ],
    );

  }
  _onDayPicker(context) {
    Alert(
      context: context,
      title: "",
      content: SomeCalendar(
        primaryColor: Color(0xff93C0FB),
        mode: SomeMode.Single,
        scrollDirection: Axis.horizontal,
        isWithoutDialog: true,
        selectedDate: selectedDate,
        startDate: Jiffy().subtract(years: 2),
        lastDate: Jiffy().add(months: 1),
        textColor: Color(0xFF93C0FB),
        done: (date) {
          setState(() {
            selectedDate = date;
            showSnackbar(selectedDate.toString());
          });
        },
        labels: Labels(
          dialogCancel: '取消',
          dialogDone: '确定',
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
//          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }

  void showSnackbar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(x),
    ));
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

