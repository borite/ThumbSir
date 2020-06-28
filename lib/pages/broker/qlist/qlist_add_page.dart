import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/dao/user_select_mission_dao.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_view_mini_tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QListAddPage extends StatefulWidget {
  @override
  _QListAddPageState createState() => _QListAddPageState();
}

class _QListAddPageState extends State<QListAddPage> {
  final TextEditingController remarkController=TextEditingController();
  RegExp remarkReg;
  bool remarkBool = false;
  int chooseId = 0;

  LoginResultData userData;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uinfo));
      });
    }
  }
  _load() async {
    var taskList = await GetDefaultTaskDao.httpGetDefaultTask();
    if (taskList.code == 200) {
      setState(() {
        tasks = taskList.data;
        _loading = false;
      });
    } else {
      _onLoadAlert(context);
    }
  }

  var taskMsg;
  List<Datum> tasks = [];
  List<Widget> tasksShowList = [];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    remarkReg = FeedBackReg;
    _getUserInfo();
    _load();
  }
  
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  int _starIndex = 0;
  int itemCount = 1;
  bool isRemark = false;

  List taskList;

  Widget taskItem() {
    Widget content;
    if (tasks != null) {
      for (var item in tasks) {
//        bool _isChoose = false;
        tasksShowList.add(
          GestureDetector(
            onTap: (){
              setState(() {
                chooseId = item.id;
              });
              print(item.id);
            },
            child: Container(
              width: 100,
              height: 28,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                item.taskName,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF0E7AE6),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
    }
    content = Wrap(
      spacing: 15,
      runSpacing: 10,
      children: tasksShowList,
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                            child: Text('添加明日任务',style: TextStyle(
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
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>QListViewMiniTasksPage()));
                              },
                              child: Text(
                                '上级为您安排了最低任务量，点击查看',
                                style: TextStyle(
                                  color: Color(0xFFF24848),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )

                    ),
                    // 选择任务
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 20,
                                height: 20,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Color(0xFF93C0FB),
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
                                child: Text('选择任务',style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              ),
                            ],
                          ),
                          Text('修改',style: TextStyle(
                            color: Color(0xFF5580EB),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),)
                        ],
                      ),
                    ),
                    taskItem(),
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 20),
                            child: Text('任务数量',style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          ),
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
                            child: Text('组',style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          ),
                        ],
                      ),
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
                              color: Color(0xFF93C0FB),
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
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _starIndex=1;
                              });
                            },
                            child: Container(
                                width: 45,
                                height: 30,
                                padding: EdgeInsets.only(right: 15),
                                child: _starIndex ==0 ?
                                Image(image: AssetImage('images/star1_e.png'),fit: BoxFit.fill,):
                                Image(image: AssetImage('images/star1_big.png'),fit: BoxFit.fill,)
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _starIndex=2;
                              });
                            },
                            child: Container(
                                width: 45,
                                height: 30,
                                padding: EdgeInsets.only(right: 15),
                                child: _starIndex==2 ?
                                Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                    :_starIndex==3 ?
                                Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                    :_starIndex==4 ?
                                Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                    :_starIndex==5 ?
                                Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                    :
                                Image(image: AssetImage('images/star2_e.png'),fit: BoxFit.fill,)
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _starIndex=3;
                              });
                            },
                            child: Container(
                                width: 45,
                                height: 30,
                                padding: EdgeInsets.only(right: 15),
                                child: _starIndex==3 ?
                                Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                    :_starIndex==4 ?
                                Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                    :_starIndex==5 ?
                                Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                    :
                                Image(image: AssetImage('images/star3_e.png'),fit: BoxFit.fill,)
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _starIndex=4;
                              });
                            },
                            child: Container(
                                width: 45,
                                height: 30,
                                padding: EdgeInsets.only(right: 15),
                                child: _starIndex==4 ?
                                Image(image: AssetImage('images/star4_big.png'),fit: BoxFit.fill,)
                                    :_starIndex==5 ?
                                Image(image: AssetImage('images/star4_big.png'),fit: BoxFit.fill,)
                                    :
                                Image(image: AssetImage('images/star4_e.png'),fit: BoxFit.fill,)
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _starIndex=5;
                              });
                            },
                            child: Container(
                                width: 45,
                                height: 30,
                                padding: EdgeInsets.only(right: 15),
                                child: _starIndex==5 ?
                                Image(image: AssetImage('images/star5_big.png'),fit: BoxFit.fill,)
                                    :
                                Image(image: AssetImage('images/star5_e.png'),fit: BoxFit.fill,)
                            ),
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
                              color: Color(0xFF93C0FB),
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
                            child: Text('时间',style: TextStyle(
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
                            Text('明日可填写的时间段有11:00-12:00，18:30-20:00',style: TextStyle(
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
                                    color: Color(0xFF0E7AE6),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                                StartTime(),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '分 '+
                                        startTime.hour.toString().padLeft(2, '0') + ':' +
                                        startTime.minute.toString().padLeft(2, '0') ,
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
                                    color: Color(0xFF0E7AE6),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                                EndTime(),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '分 '+
                                        endTime.hour.toString().padLeft(2, '0') + ':' +
                                        endTime.minute.toString().padLeft(2, '0') ,
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
                              color: Color(0xFF93C0FB),
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
                    // 地址
                    Container(
                      width: 335,
                      height: 32,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('+ 添加地址',style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0E7AE6),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),textAlign: TextAlign.center,),
                    ),
                    // 添加备注
                    isRemark == false ?
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isRemark = true;
                        });
                      },
                      child: Container(
                        width: 335,
                        height: 32,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('+ 添加备注',style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0E7AE6),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),textAlign: TextAlign.center,),
                      ),
                    )
                        :
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 50),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF5580EB)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: remarkController,
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                          hintText:'添加备注',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // 注意
                    Text('注意!',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text('任务开始后可在量化页面拍摄或上传任务交付物的照片，系统会自动审核任务完成百分比；请在任务时间内完成任务并在任务结束后60分钟内上传或拍摄交付物照片，超时视为未完成，不可修改。',style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                    // 完成
                    GestureDetector(
                      onTap: ()async{
                      await UserSelectMissionDao.selectMission(
                          userData.companyId,
                          userData.userPid,
                          chooseId.toString(), // adminTaskId,
                          userData.userLevel.substring(0,1),
                          startTime.toIso8601String(),
                          endTime.toIso8601String(),
                          _starIndex.toString(),
                          itemCount.toString(),
                          '北京市', // address,
                          remarkController.text,
                      );
                      },
                      child: Container(
                        width: 200,
                        height: 32,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 50),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('完成',style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF93C0FB),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),textAlign: TextAlign.center,),
                      ),
                    ),
                  ]
              )
            ],
          )
      ),
    );
  }
  Widget StartTime(){
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
        print(time);
        setState(() {
          startTime=time;
        });
      },
    );
  }
  Widget EndTime(){
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
        print(time);
        setState(() {
          endTime=time;
        });
      },
    );
  }
  _onChanged(String text){
    if(text != null){
      setState(() {
        remarkBool = remarkReg.hasMatch(remarkController.text);
      });
    }
  }
  _onLoadAlert(context) {
    Alert(
      context: context,
      title: "加载任务失败",
      desc: "请检查网络连接情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _loading = false;
            });
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}

