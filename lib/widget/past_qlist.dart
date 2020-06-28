import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';

class PastQList extends StatefulWidget {
  @override
  _PastQListState createState() => _PastQListState();
}

class _PastQListState extends State<PastQList>  with SingleTickerProviderStateMixin{
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;
  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale = 'zh_Cn'; // to change the calendar format based on localization
    controller = AnimationController(vsync:this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 780,end:280).animate(
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.only(top:animation.value,bottom:30),
          child: Container(
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
            margin: EdgeInsets.only(left: 30,right: 30),
            padding: EdgeInsets.all(20),
            height: 300,
            child: SomeCalendar(
              primaryColor: Color(0xff93C0FB),
              mode: SomeMode.Single,
              scrollDirection: Axis.horizontal,
              isWithoutDialog: true,
              selectedDate: selectedDate,
              startDate: Jiffy().subtract(years: 2),
              lastDate: Jiffy().add(months: 1),
              textColor: Color(0xFF93C0FB),
              done: (date) {
                print(date);
                setState(() {
                  selectedDate = date;
                  showSnackBar(selectedDate.toString());
                });
              },
              labels: Labels(
                dialogCancel: '取消',
                dialogDone: '确定',
              ),
            ),
          ),
        )
      ],
    );
  }
  void showSnackBar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(x),
    ));
  }
}
