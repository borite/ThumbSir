import 'package:ThumbSir/pages/mycenter/self_defined_task_page.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class ChooseMiniTaskPage extends StatefulWidget {
  @override
  _ChooseMiniTaskPageState createState() => _ChooseMiniTaskPageState();
}

class _ChooseMiniTaskPageState extends State<ChooseMiniTaskPage> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle.png'),
            fit: BoxFit.fitHeight,
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
                  // 选择任务
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              '选择任务',
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
                  // 任务item
                  Container(
                    padding: EdgeInsets.only(top: 40,bottom: 50),
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF5580EB)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF5580EB)
                          ),
                          child: Text('休息',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('带看',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('实勘',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('打业主电话',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('过户',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('录入房源',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('签委托',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                        Container(
                          width: 100,
                          height: 28,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('面访业主',style: TextStyle(fontSize: 14,color: Color(0xFF5580EB),fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,),textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                  // 最低完成量
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '最低完成量',
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
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '设置每日最低完成任务数量：',
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
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 120,
                          margin: EdgeInsets.only(top: 28),
                          child: WheelChooser(
                            onValueChanged: (s) => print(s),
                            datas: ["1", "2", "3", "4", "5","6","7","8","9","10"],
                            selectTextStyle: TextStyle(
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: 12
                            ),
                            unSelectTextStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: 12
                            ),
                          ),
                        ),
                        Text('项',style: TextStyle(
                          color: Color(0xFF0E7AE6),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Container(
                        child: Text(
                            '说明：设置每日最低完成任务数量是规定经纪人每日最少完成上面所选的任务中的任意几项任务就算今日任务量达标。',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      )
                  ),
                  // 下一步
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
                            child: Text('下一步',style: TextStyle(
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
