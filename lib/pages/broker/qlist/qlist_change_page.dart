import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/modify_mission_dao.dart';
import 'package:ThumbSir/model/choose_item_model.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_view_mini_tasks_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/s_qlist_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chips_choice/chips_choice.dart';

class QListChangePage extends StatefulWidget {
  final id;
  final taskName;
  final taskUnit;
  final defaultTaskID;
  final stars;
  final planningCount;
  final planningStartTime;
  final planningEndTime;
  final remark;
  final address;
  final date;
  QListChangePage({
    this.id,this.taskName,this.taskUnit,this.defaultTaskID,this.stars,this.planningCount,
    this.planningStartTime,this.planningEndTime,this.remark,this.address,this.date
});
  @override
  _QListChangePageState createState() => _QListChangePageState();
}

class _QListChangePageState extends State<QListChangePage> {
  final TextEditingController remarkController=TextEditingController();
  RegExp remarkReg;
  bool remarkBool = false;
  final TextEditingController mapController=TextEditingController();
  RegExp mapReg;
  bool mapBool = false;
  String chooseId;
  String chooseUnit;
  var widgetStartTime;
  var widgetEndTime;
  String tag = "1";

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
      });
    } else {
      _onLoadAlert(context);
    }
  }

  var taskMsg;
  List<Datum> tasks = [];
  List<Widget> tasksShowList = [];

  var startTime;
  var endTime;
  int _starIndex;
  int itemCount;
  bool isRemark = false;
  bool isMap = false;

  List taskList;

  @override
  void initState() {
    super.initState();
    remarkReg = FeedBackReg;
    _getUserInfo();
    _load();
    chooseId = widget.defaultTaskID;
    widgetStartTime = widget.planningStartTime.toString();
    widgetEndTime = widget.planningEndTime.toString();
    _starIndex = widget.stars;
    itemCount = widget.planningCount;
    chooseUnit = widget.taskUnit;
    remarkController.text = widget.remark;
    mapController.text = widget.address;
    if(widget.remark!=null){
      setState(() {
        isRemark = true;
      });
    }
    if(widget.address!=null){
      setState(() {
        isMap = true;
      });
    }
    startTime = widget.date == 1 ? DateTime.now():DateTime.now().add(Duration(days: 1));
    endTime = widget.date == 1 ? DateTime.now():DateTime.now().add(Duration(days: 1));
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
                    Container(
//                      padding: EdgeInsets.all(15),
                      child:Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 50,
                              child: Image(image: AssetImage('images/back.png'),),
                            ),
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
                    // 查看最低任务
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
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
                        Text('修改前任务为：'+widget.taskName,style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        )
                        ),
                        ],
                      ),

                    ),
                    Content(
                      title: '可选的任务名称',
                      child: ChipsChoice<String>.single(
                        value: tag,
                        options:  ChipsChoiceOption.listFrom<String,Datum>(
                            source: tasks,
                            // 存储形式
                            value:(index,item)=>'{"id":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                            // 展示形式
                            label: (index,item)=>item.taskName
                        ),
                        onChanged: (val){
                          setState((){
                            tag = val;
                            var item = chooseItemFromJson(val);
                            chooseId = item.id;
                            chooseUnit = item.taskUnit;
                          });
                        },
                        itemConfig: ChipsChoiceItemConfig(
                          selectedColor: Color(0xFF24CC8E),
                          selectedBrightness: Brightness.dark,
                          unselectedColor: Color(0xFF24CC8E),
                          unselectedBorderOpacity: .3,
                        ),
                        isWrapped: true,
                      ),
                    ),
                    // 若选择其他描述必填提示
                    chooseId == '12' ?
                    Padding(
                        padding: EdgeInsets.only(left: 20,bottom: 15),
                        child: Row(
                          children: <Widget>[
                            Text('注意：若选择"其他"，任务描述为必填项',style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFF24848),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            )),
                          ],
                        )
                    )
                        :Container(width: 1,),
                    chooseId == "13" || chooseId == "15" || chooseId == "16"?
                    Container(width: 1,)
                        :
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
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
                          GestureDetector(
                            onTap: (){
                              if(itemCount >= 2){
                                setState(() {
                                  itemCount = itemCount - 1;
                                });
                              }else{}
                            },
                            child: Container(
                              width: 40,
                              height: 20,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFF24CC8E),width: 1),
                              ),
                              child: Text('-',style: TextStyle(
                                color: Color(0xFF24CC8E),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            ),
                          ),
                          Text(
                            itemCount.toString(),
                            style: TextStyle(
                              color: Color(0xFF24CC8E),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                itemCount = itemCount + 1;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 20,
                              margin: EdgeInsets.only(left: 15,right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFF24CC8E),width: 1),
                              ),
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
                            child: Text(chooseUnit,style: TextStyle(
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
                    chooseId == "13" || chooseId == "15" || chooseId == "16"?
                    Container(width: 1,)
                        :
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
                    chooseId == "13" || chooseId == "15" || chooseId == "16"?
                    Container(width: 1,)
                        :
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
                    chooseId == "13" || chooseId == "15" || chooseId == "16"?
                    Container(width: 1,)
                        :
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
                    chooseId == "13"?
                    Container(width: 1,)
                        :
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
                              chooseId =="15" || chooseId=="16" ?
                              '2':'3',
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
                    chooseId == "13"?
                    Container(width: 1,)
                        :
                    Padding(
                        padding: EdgeInsets.only(left: 20,bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                        widgetStartTime != null && widgetEndTime != null ?
                                '修改前的时间段为'+widgetStartTime.substring(11,16)+'-'+widgetEndTime.substring(11,16)
                                :'',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                            )),
                          ],
                        )

                    ),
                    // 开始时间
                    chooseId == "13"?
                    Container(width: 1,)
                        :
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
                                StartTime(),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '分',
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
                    chooseId == "13"?
                    Container(width: 1,)
                        :
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
                                EndTime(),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '分',
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
                    chooseId == "13"?
                    Container(width: 1,)
                        :
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
                              chooseId =="15" || chooseId=="16" ?
                              '3':'4',
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
                    chooseId == "13"?
                    Container(width: 1,)
                        :
                    chooseId != "13" && isMap == false ?
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isMap = true;
                        });
                      },
                      child: Container(
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
                    )
                        :
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 50),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF24CC8E)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: mapController,
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        onChanged: _onMapChanged,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                          hintText:'添加地址',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
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
                          border: Border.all(width: 1,color: Color(0x9024CC8E)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('+ 添加备注',style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF24CC8E),
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
                        border: Border.all(width: 1,color: Color(0xFF24CC8E)),
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

                    // 备注
                    Text('注意!',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text('修改任务后，之前的任务会被当前修改后的任务取代，若修改后的任务与已有的其他任务时间冲突，请调整其他任务的时间，以保障全天时间合理安排！',style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                    // 完成
                    GestureDetector(
                      onTap: ()async {
                        if (endTime
                            .difference(startTime)
                            .inMinutes <= 0) {
                          _onTimeWrong(context);
                        } else {
                          if (chooseId == "15" || chooseId == "16") {
                            var result1516 = await ModifyMissionDao
                                .modifyMission(
                              widget.id,
                              userData.companyId,
                              userData.userPid,
                              chooseId,
                              userData.userLevel.substring(0, 1),
                              startTime.toIso8601String(),
                              endTime.toIso8601String(),
                              _starIndex.toString(),
                              itemCount.toString(),
                              '',
                              remarkController.text,
                            );
                            if (result1516.code == 200) {
                              if (userData.userLevel.substring(0, 1) == "6") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => QListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "4") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SQListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "5") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ManagerQListPage()));
                              }
                            } else {
                              _onTimeAlertPressed(context);
                            }
                          }
                          if (chooseId == "13") {
                            var result13 = await ModifyMissionDao.modifyMission(
                              widget.id,
                              userData.companyId,
                              userData.userPid,
                              chooseId,
                              userData.userLevel.substring(0, 1),
                              startTime.toIso8601String(),
                              endTime.toIso8601String(),
                              _starIndex.toString(),
                              itemCount.toString(),
                              '',
                              remarkController.text,
                            );
                            if (result13.code == 200) {
                              if (userData.userLevel.substring(0, 1) == "6") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => QListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "4") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SQListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "5") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ManagerQListPage()));
                              }
                            } else {
                              _onTimeAlertPressed(context);
                            }
                          }
                          if (chooseId == "12" && isRemark == true &&
                              remarkController.text != '') {
                            var result12 = await ModifyMissionDao.modifyMission(
                              widget.id,
                              userData.companyId,
                              userData.userPid,
                              chooseId,
                              userData.userLevel.substring(0, 1),
                              startTime.toIso8601String(),
                              endTime.toIso8601String(),
                              _starIndex.toString(),
                              itemCount.toString(),
                              '',
                              remarkController.text,
                            );
                            if (result12.code == 200) {
                              if (userData.userLevel.substring(0, 1) == "6") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => QListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "4") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SQListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "5") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ManagerQListPage()));
                              }
                            } else {
                              _onTimeAlertPressed(context);
                            }
                          }
                          if (chooseId != "-1" && chooseId != "12" &&
                              chooseId != "13" && chooseId != "15" &&
                              chooseId != "16" && _starIndex != 0) {
                            var resultOther = await ModifyMissionDao
                                .modifyMission(
                              widget.id,
                              userData.companyId,
                              userData.userPid,
                              chooseId,
                              userData.userLevel.substring(0, 1),
                              startTime.toIso8601String(),
                              endTime.toIso8601String(),
                              _starIndex.toString(),
                              itemCount.toString(),
                              '',
                              remarkController.text,
                            );
                            print(widget.id);
                            if (resultOther.code == 200) {
                              if (userData.userLevel.substring(0, 1) == "6") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => QListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "4") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SQListPage()));
                              }
                              if (userData.userLevel.substring(0, 1) == "5") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ManagerQListPage()));
                              }
                            } else {
                              _onTimeAlertPressed(context);
                            }
                          } else {}
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 32,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 50),
                        decoration: chooseId == "13" || chooseId == "15" || chooseId == "16" ?
                        BoxDecoration(
                            border: Border.all(width: 1, color: Color(0xFF24CC8E)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF24CC8E)
                        )
                            :chooseId == "12" && isRemark == true && remarkController.text != ''?
                        BoxDecoration(
                            border: Border.all(width: 1, color: Color(0xFF24CC8E)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF24CC8E)
                        )
                            :chooseId != "-1" && chooseId != "12" && chooseId != "13" &&chooseId != "15" &&chooseId != "16" &&_starIndex != 0 ?
                        BoxDecoration(
                            border: Border.all(width: 1, color: Color(0xFF24CC8E)),
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF24CC8E)
                        )
                            :
                        BoxDecoration(
                            border: Border.all(width: 1, color: Color(0x9024CC8E)),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                        ),
                        child: Text(
                          '完成',
                          style: TextStyle(
                            fontSize: 16,
                            color:chooseId == "13" || chooseId == "15" || chooseId == "16" ?
                            Colors.white
                                :chooseId == "12" && isRemark == true && remarkController.text != ''?
                            Colors.white
                                :chooseId != "-1" && chooseId != "12" && chooseId != "13" &&chooseId != "15" &&chooseId != "16" &&_starIndex != 0 ?
                            Colors.white: Color(0x9024CC8E),
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
  _onChanged(String text){
    if(text != null){
      setState(() {
        remarkBool = remarkReg.hasMatch(remarkController.text);
      });
    }
  }
  _onMapChanged(String text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
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
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }

  _onTimeAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "当前时间与已有任务时间冲突",
      desc: "请选择其它时间，各任务的计划时间不可重复",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }

  _onTimeWrong(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "结束时间不得早于开始时间",
      desc: "请重新选择结束时间",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }


  Widget StartTime(){
    return TimePickerSpinner(
      normalTextStyle: TextStyle(
        fontSize: 20,
        color: Color(0xFF666666),
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 24,
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
        setState(() {
          widget.date == 1 ?
          startTime=time
              :
          startTime=time.add(Duration(days: 1));
        });
      },
    );
  }
  Widget EndTime(){
    return TimePickerSpinner(
      normalTextStyle: TextStyle(
        fontSize: 20,
        color: Color(0xFF666666),
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 24,
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
        setState(() {
          widget.date == 1 ?
          endTime=time
              :
          endTime=time.add(Duration(days: 1));
        });
      },
    );
  }
}
class Content extends StatelessWidget {

  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Color(0x205580EB),
            child: Text(
              title,
              style: TextStyle(
                  color: Color(0xFF24CC8E),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}