import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class QListChangePage extends StatefulWidget {
  @override
  _QListChangePageState createState() => _QListChangePageState();
}

class _QListChangePageState extends State<QListChangePage> {
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
                            child: Text('修改任务',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        ],
                      ),
                  ),
                  // 选择任务
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Color(0xFF24CC8E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('更换任务',style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 28,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF24CC8E)
                        ),
                        child: Text('带看',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: 100,
                        height: 28,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text('实勘',style: TextStyle(fontSize: 14,color: Color(0xFF24CC8E),fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: 100,
                        height: 28,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text('收钥匙',style: TextStyle(fontSize: 14,color: Color(0xFF24CC8E),fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: 100,
                        height: 28,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text('打业主电话',style: TextStyle(fontSize: 14,color: Color(0xFF24CC8E),fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                  // 重要性标注
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Color(0xFF24CC8E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('重要性标注',style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image(image: AssetImage('images/star1_e.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image(image: AssetImage('images/star2_e.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image(image: AssetImage('images/star3_e.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image(image: AssetImage('images/star4_e.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image(image: AssetImage('images/star5_e.png'),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,top: 15),
                    child: Row(
                    children: <Widget>[
                      Text('1-5颗星，1颗为不重要，5星为最重要',style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      )),
                    ],
                    )

                  ),
                  // 时间
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Color(0xFF24CC8E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('修改时间',style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20,bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Text('修改前的时间段为11:00-12:00',style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          )),
                        ],
                      )

                  ),
                  // 开始时间
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Text('开始时间',style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF24CC8E),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              ),
                              hourMinute(),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  '分 '+
                                      _dateTime.hour.toString().padLeft(2, '0') + ':' +
                                      _dateTime.minute.toString().padLeft(2, '0') ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            top: 50,
                            left: 150,
                            child: Text(
                              '时',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          )
                        ],
                      )

                  ),
                  // 结束时间
                  Container(
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Text('结束时间',style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF24CC8E),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              ),
                              hourMinute(),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  '分 '+
                                      _dateTime.hour.toString().padLeft(2, '0') + ':' +
                                      _dateTime.minute.toString().padLeft(2, '0') ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            top: 50,
                            left: 150,
                            child: Text(
                              '时',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          )
                        ],
                      )

                  ),
                  // 任务描述
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          height: 20,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Color(0xFF24CC8E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '4',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('任务描述',style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 335,
                    height: 32,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('+ 添加地址',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF24CC8E),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
                  ),
                  Container(
                    width: 335,
                    height: 32,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('+ 添加备注',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF24CC8E),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
                  ),
                  // 备注
                  Text('注意!',style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text('修改任务后，之前的任务会被当前修改后的任务取代，若修改后的任务与已有的其他任务时间冲突，请及时调整其他任务的时间，以保障全天时间合理排满！',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 完成
                  Container(
                    width: 200,
                    height: 32,
                    padding: EdgeInsets.all(3),
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 80),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('完成',style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF24CC8E),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
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
      color: Color(0xFF24CC8E),
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFF24CC8E),
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
