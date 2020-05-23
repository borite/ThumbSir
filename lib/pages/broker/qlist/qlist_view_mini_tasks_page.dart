import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class QListViewMiniTasksPage extends StatefulWidget {
  @override
  _QListViewMiniTasksPageState createState() => _QListViewMiniTasksPageState();
}

class _QListViewMiniTasksPageState extends State<QListViewMiniTasksPage> {
  DateTime _dateTime = DateTime.now();

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
                  // 任务
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
                            '带看',
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
                          '1',
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
                            '组',
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
                            '打电话',
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
                          '50',
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
                            '个',
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
                            '实勘',
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
                          '1',
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
                            '套',
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
                      ],
                    ),
                  ),
                ]
            )
          ],
        )
    );
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