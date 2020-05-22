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

class _PastQListState extends State<PastQList> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale = 'zh_Cn'; // to change the calendar format based on localization
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.only(top:250,bottom:30),
          child: Container(
            child:
            SomeCalendar(
              primaryColor: Color(0xff93C0FB),
              mode: SomeMode.Single,
              scrollDirection: Axis.horizontal,
              isWithoutDialog: false,
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
          ),
        )
      ],
    );
  }
  void showSnackbar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(x),
    ));
  }
}
