import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TeamListMemberPage extends StatefulWidget {
  @override
  _TeamListMemberPageState createState() => _TeamListMemberPageState();
}

class _TeamListMemberPageState extends State<TeamListMemberPage> {
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
    return Container(
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
                                child: Text('马思唯的量化任务',style: TextStyle(
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
                                padding:EdgeInsets.only(left: 8,right: 8),
                                child: Image(image: AssetImage('images/date.png')),
                              ),
                              Text(
                                '2020-04-05',
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
                                        showSnackbar(selectedDate.toString());
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
                    child: Column(
                      children: <Widget>[
                      // 每一条量化
                      _continueItem('带看','3套','10:00-11:00',65),
                      _finishItem('带看','3套','10:00-11:00'),
                      _extendItem('带看','3套','10:00-11:00',77),
                      _continueItem('带看','3套','10:00-11:00',30),
                      _continueItem('带看','3套','10:00-11:00',65),
                      ],
                    ),
                  )
                ]
            )
          ],
        )
    );
  }
  void showSnackbar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(x),
    ));
  }
  // 未完成的item
  _continueItem(String name,String number,String time,double percent){
    return Stack(
      children: <Widget>[
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 300,
                height: 104,
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
                child: Column(
                  children: <Widget>[
                    // 项目和数量
                    Container(
                      width: 270,
                      padding: EdgeInsets.only(top:12),
                      child: Row(
                        children: <Widget>[
                          Image(image: AssetImage('images/time.png'),),
                          Padding(
                            padding:EdgeInsets.only(left:4),
                            child: Text(
                              name,
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF0E7AE6),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:4,top:3),
                            child: Text(
                              number,
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                      width:270,
                      padding:EdgeInsets.only(top:5,bottom: 8),
                      child: Text(
                        '时间 '+time,
                        style:TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:270,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star1.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star2.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star3.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star4.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star5.png'),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        // 圆形进度条
        Positioned(
          left: 260,
          top:14,
          child: Container(
            width: 74,
            height: 74,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(37),
              boxShadow: [BoxShadow(
                  color: Color(0xFFcccccc),
                  offset: Offset(2, 2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              )],
            ),
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
                        fontSize: 14,
                        color: Color(0xFF2692FD),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      )
                  )
              ),
              min: 0,
              max: 100,
              initialValue: percent,
            ),
          ),
        )
      ],
    );
  }

  // 已完成的item
  _finishItem(String name,String number,String time){
    return Stack(
      children: <Widget>[
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 300,
                height: 104,
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
                child: Column(
                  children: <Widget>[
                    // 项目和数量
                    Container(
                      width: 270,
                      padding: EdgeInsets.only(top:12),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '恭喜你!完成 '+name,
                            style:TextStyle(
                              fontSize: 20,
                              color: Color(0xFF24CC8E),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:4,top:3),
                            child: Text(
                              number,
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF24CC8E),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                      width:270,
                      padding:EdgeInsets.only(top:5,bottom: 8),
                      child: Text(
                        '时间 '+time,
                        style:TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:270,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star1.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star2.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star3.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star4.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star5.png'),),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),

        // 已完成圆形进度条
        Positioned(
          left: 260,
          top:14,
          child: Container(
            width: 74,
            height: 74,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(37),
              boxShadow: [BoxShadow(
                  color: Color(0xFFcccccc),
                  offset: Offset(2, 2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              )],
            ),
            child: Image(image:AssetImage('images/finish.png')),
          ),
        )
      ],
    );
  }

  // 展开的item
  _extendItem(String name,String number,String time,double percent){
    return Stack(
      children: <Widget>[
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 335,
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
                child: Column(
                  children: <Widget>[
                    // 项目和数量
                    Container(
                      width: 335,
                      padding: EdgeInsets.only(top:12,left:15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                name,
                                style:TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF24CC8E),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:4,top:3),
                                child: Text(
                                  number,
                                  style:TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF24CC8E),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 完成度
                    Container(
                      padding: EdgeInsets.only(top:80,left:20),
                      width: 335,
                      child: Text(
                        '完成度',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:335,
                      padding: EdgeInsets.only(top:20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left:20,right: 42),
                            child: Text(
                              '重要性',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star1.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star2.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star3.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star4.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star5.png'),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                        width:335,
                        padding:EdgeInsets.only(bottom: 20),
                        child:Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20,right: 83),
                              child: Text(
                                '时间',
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              time,
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                    ),
                    // 任务描述
                    Container(
                        width:335,
                        child:
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '任务描述',
                            style:TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                    ),
                    // 任务描述详情
                    Container(
                        width:335,
                        child:
                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                          child: Text(
                            '共带看3套房，客户对第二套比较满意,共带看3套房，客户对第二套比较满意,共带看3套房，客户对第二套比较满意',
                            style:TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                    ),
                    // 定位
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          // 每一条定位
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage('images/site_small.png'),),
                                ),
                                Text(
                                  '新华大街新华地铁口惠明小区',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage('images/site_small.png'),),
                                ),
                                Text(
                                  '新华大街新华地铁口惠明小区',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage('images/site_small.png'),),
                                ),
                                Text(
                                  '新华大街新华地铁口惠明小区',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 图片上传
                    Container(
                        width:335,
                        child:
                        Padding(
                          padding: EdgeInsets.only(left: 20,top: 10,bottom: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '图片上传',
                                style:TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                        )
                    ),
                    // 图片
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    // 收起按钮
                    Container(
                      width: 33,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Image(
                        image: AssetImage('images/upbtn.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        // 圆形进度条
        Positioned(
          top:35,
          left: 115,
          child: Container(
            width: 110,
            height: 110,
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                  startAngle: 280,
                  angleRange: 360,
                  customWidths: CustomSliderWidths(progressBarWidth: 12),
                  customColors: CustomSliderColors(
                    progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                    trackColor: Color(0x20CCCCCC),
                    dotColor: Colors.transparent,
                  ),
                  infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF2692FD),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      )
                  )
              ),
              min: 0,
              max: 100,
              initialValue: percent,
            ),
          ),
        )
      ],
    );
  }
}
