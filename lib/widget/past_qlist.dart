import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastQList extends StatefulWidget {
  const PastQList({Key? key}) : super(key: key);

  @override
  _PastQListState createState() => _PastQListState();
}

class _PastQListState extends State<PastQList>  with SingleTickerProviderStateMixin{
  DateTime selectedDate = DateTime.now();
  // List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;
  @override
  void initState() {
    Intl.systemLocale = 'zh_Cn'; // to change the calendar format based on localization
    controller = AnimationController(vsync:this,duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 980,end:180).animate(
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
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end:Alignment.bottomCenter,
            //         colors: [Color.fromRGBO(208, 240, 238, 1),Color.fromRGBO(228, 233, 250, 1),Color.fromRGBO(234, 239, 253, 1)]
            //     )
            // ),
            padding: EdgeInsets.only(top:animation.value,bottom:30),
            child: Container(
              height: 300,
              margin: const EdgeInsets.only(left: 30,right: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(
                      color: Color(0xFFcccccc),
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
                  )
                  ],
                  color: Colors.white
              ),
              // child: SomeCalendar(
              //   primaryColor: const Color(0xFF999999),
              //   mode: SomeMode.Single,
              //   scrollDirection: Axis.horizontal,
              //   isWithoutDialog: true,
              //   selectedDate: selectedDate,
              //   startDate: Jiffy().subtract(years: 2),
              //   lastDate: Jiffy().add(months: 1),
              //   textColor: const Color(0xFF666666),
              //   done: (date) {
              //     setState(() {
              //       selectedDate = date;
              //     });
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTaskListSearchResultPage(
              //       chooseDate:selectedDate
              //     )));
              //   },
              //   labels: Labels(
              //     dialogCancel: '取消',
              //     dialogDone: '确定',
              //   ),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
