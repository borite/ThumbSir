import 'package:ThumbSir/pages/mycenter/self_defined_task_page.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class ChooseMiniTaskNumberPage extends StatefulWidget {
  @override
  _ChooseMiniTaskNumberPageState createState() => _ChooseMiniTaskNumberPageState();
}

class _ChooseMiniTaskNumberPageState extends State<ChooseMiniTaskNumberPage> {
  DateTime _dateTime = DateTime.now();
  int itemCount = 1;

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
                            child: Text('为下级设置最低任务量',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        ],
                      ),
                  ),
                  // 编辑任务数量
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              '编辑任务数量',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      )
                  ),
                  // 说明
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '设置每一项任务的每天最低完成数量：',
                            style: TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  // 每一项
                  Column(
                    children: <Widget>[
                      Container(
                        width: 335,
                        height: 60,
                        margin: EdgeInsets.only(top: 20),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20,right: 15),
                                child: Image(image: AssetImage('images/task.png'),),
                              ),
                              Text('实勘',style: TextStyle(
                                color: Color(0xFF5580EB),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 20,
                                height: 20,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xFF5580EB),width: 1),
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    if(itemCount >= 2){
                                      setState(() {
                                        itemCount = itemCount - 1;
                                      });
                                    }else{}
                                  },
                                  child: Text('-',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.center,),
                                ),
                              ),
                              Text(
                                itemCount.toString(),
                                style: TextStyle(
                                  color: Color(0xFF5580EB),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                              ),),
                              Container(
                                width: 20,
                                height: 20,
                                margin: EdgeInsets.only(left: 15,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xFF5580EB),width: 1),
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      itemCount = itemCount + 1;
                                    });
                                  },
                                  child: Text('+',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.center,),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text('套/人/天',style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              ),
                            ],
                          )
                        ]),
                      ),
                      Container(
                        width: 335,
                        height: 60,
                        margin: EdgeInsets.only(top: 20),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 15),
                                    child: Image(image: AssetImage('images/task.png'),),
                                  ),
                                  Text('打电话',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('+',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Text('50',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 15,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('-',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text('套/人/天',style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ),
                                ],
                              )
                            ]),
                      ),
                      Container(
                        width: 335,
                        height: 60,
                        margin: EdgeInsets.only(top: 20),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 15),
                                    child: Image(image: AssetImage('images/task.png'),),
                                  ),
                                  Text('面访业主',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('+',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Text('1',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 15,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('-',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text('套/人/天',style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ),
                                ],
                              )
                            ]),
                      ),
                      Container(
                        width: 335,
                        height: 60,
                        margin: EdgeInsets.only(top: 20),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 15),
                                    child: Image(image: AssetImage('images/task.png'),),
                                  ),
                                  Text('实勘',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('+',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Text('1',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 15,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('-',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text('套/人/天',style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ),
                                ],
                              )
                            ]),
                      ),
                      Container(
                        width: 335,
                        height: 60,
                        margin: EdgeInsets.only(top: 20),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 15),
                                    child: Image(image: AssetImage('images/task.png'),),
                                  ),
                                  Text('实勘',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('+',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Text('1',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 15,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('-',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text('套/人/天',style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ),
                                ],
                              )
                            ]),
                      ),
                      Container(
                        width: 335,
                        height: 60,
                        margin: EdgeInsets.only(top: 20),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 15),
                                    child: Image(image: AssetImage('images/task.png'),),
                                  ),
                                  Text('实勘',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('+',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Text('1',style: TextStyle(
                                    color: Color(0xFF5580EB),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(left: 15,right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                                    ),
                                    child: Text('-',style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text('套/人/天',style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                  // 完成
                  Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 50,top: 100),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF5580EB)
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: GestureDetector(
                            onTap: (){
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
                            },
                            child: Text('完成',style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.center,),
                          )
                      )
                  ),
                ]
            )
          ],
        )
    );
  }
}
