import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/sell_need_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:ThumbSir/model/set_kpimission_item_model.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';

import 'my_client_page.dart';

class SellNeedDetailPage extends StatefulWidget {
  final cid;
  final mainNeed;
  final userName;

  SellNeedDetailPage({Key key,
    this.cid,this.mainNeed,this.userName
  }):super(key:key);
  @override
  _SellNeedDetailPageState createState() => _SellNeedDetailPageState();
}

class _SellNeedDetailPageState extends State<SellNeedDetailPage> {
  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  ScrollController _memberScrollController = ScrollController();
  final TextEditingController countController=TextEditingController();
  bool _loading = false;

  final TextEditingController userNameController = TextEditingController();
  String userName;
  RegExp nameReg;
  bool userNameBool;
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;
  final TextEditingController careerController=TextEditingController();
  String career;
  RegExp careerReg;
  bool careerBool = false;
  final TextEditingController mapController=TextEditingController();
  RegExp mapReg;
  bool mapBool = false;
  final TextEditingController likeController=TextEditingController();
  RegExp likeReg;
  bool likeBool = false;
  final TextEditingController msgController=TextEditingController();
  RegExp msgReg;
  bool msgBool = false;
  final TextEditingController memberController=TextEditingController();
  RegExp memberReg;
  bool memberBool = false;

  String dealMinCount = "购买住宅";
  String needMinCount = "购买住宅";
  String incomeMinCount = "10万以下";
  String comeMinCount = "社区开发";
  String memberMinCount = "妻子";
  int _starIndex = 0;
  int itemCount = 1;
  List<String> tags = [];
  List idList = [];
  String selectTaskIDs="";
  int itemLength = 0;
  List missionContent=new List();
  // List<Datum> tasks = [];
  List<String> way = [];
  List<String> period = [];
  List<String> direction = [];
  List<String> lift =[];
  List<String> floor = [];
  List<String> age = [];
  List<String> finish = [];
  List<String> traffic =[];
  List<String> school = [];
  List<String> hospital = [];
  List<String> park = [];
  List<String> bank = [];
  List<String> manager = [];
  List<String> market = [];
  List<String> tax = [];
  List<String> special = [];

  List<DealInfo> deal=new List();
  List<NeedInfo> need=new List();
  List<FamilyMember> member=new List();

  DateTime _selectedDate=DateTime(2020,1,1);
  DateTime _selectedBirthdayDate=DateTime(1980,1,1);

  int _radioGroupA = 0;

  void _handleRadioValueChanged(int value) {
    setState(() {
      _radioGroupA = value;
    });
  }

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

  // _load() async {
  //   var taskList = await GetDefaultTaskDao.httpGetDefaultTask();
  //   if (taskList.code == 200) {
  //
  //     List<Datum> filteredList=new List();
  //
  //     taskList.data.forEach((element) {
  //       if(element.id!=12 && element.id!=13 && element.id!=14){
  //         filteredList.add(element);
  //       }
  //     });
  //
  //     setState(() {
  //       tasks = filteredList;
  //       _loading = false;
  //     });
  //   } else {
  //     // _onLoadAlert(context);
  //   }
  // }

  @override
  void initState() {
    nameReg = TextReg;
    phoneReg = telPhoneReg;
    careerReg = TextReg;
    mapReg = FeedBackReg;
    likeReg = TextReg;
    msgReg = FeedBackReg;
    memberReg = TextReg;
    _getUserInfo();
    // _load();
    way=["全款","商款","组合贷","无要求"];
    period=["2个月内","3个月内","4个月内","半年内","无要求"];
    direction = ["东","南","西","北","无要求"];
    lift =["带电梯","无要求"];
    floor =["底层","低楼层","中楼层","高楼层","顶层","无要求"];
    age = ["5年以内","10年以内","15年以内","20年以内","20年以上","无要求"];
    finish = ["精装修","普通装修","毛坯房","无要求"];
    traffic = ["近公交","近地铁","无要求"];
    school = ["优质学区","普通学区","无要求"];
    hospital = ["三甲医院","普通医院","无要求"];
    park = ["有公园","无要求"];
    bank = ["有银行","无要求"];
    manager = ["优质物业","普通物业","无要求"];
    market = ["大型购物商场","大型超市","小区内超市","无要求"];
    tax = ["满五唯一","满两年","无要求"];
    special = ["安静","带车位","停车方便","绿化率高","容积率低","小区面积大","无要求"];

    super.initState();

  }

  @override
  void dispose(){
    _dealScrollController.dispose();
    _needScrollController.dispose();
    _memberScrollController.dispose();
    memberController.dispose();
    userNameController.dispose();
    phoneNumController.dispose();
    careerController.dispose();
    mapController.dispose();
    likeController.dispose();
    msgController.dispose();
    countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
            child:Container(
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
                                  // 首页和标题
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 28,
                                          padding: EdgeInsets.only(top: 3),
                                          child: Image(image: AssetImage('images/back.png'),),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('张先生的购买住宅需求',style: TextStyle(
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

                          // 付款方式
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '核心需求1：付款方式',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          Container(
                              width: 335,
                              // title: '可选的任务名称（ 多选 ）',
                              child: FormField<List<String>>(
                                  initialValue: tags,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 1) {
                                      return "选择不可多于1项";
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: way,
                                                  // 存储形式
                                                  // value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                                  // 展示形式
                                                  label: (index,item)=>item
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                String ids="";
                                                val.forEach((element) {
                                                  var item=selectItemFromJson(element);
                                                  print(item);
                                                  ids+=item.id+',';
                                                  selectTaskIDs = ids;
                                                  print(selectTaskIDs);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              itemConfig: ChipsChoiceItemConfig(
                                                selectedColor: Color(0xFF5580EB),
                                                selectedBrightness: Brightness.dark,
                                                unselectedColor: Color(0xFF5580EB),
                                                unselectedBorderOpacity: .3,
                                              ),
                                              isWrapped: true,
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                state.errorText ?? state.value.length.toString() + '/1 可选',
                                                style: TextStyle(
                                                    color: state.hasError
                                                        ? Colors.redAccent
                                                        : Colors.green
                                                ),
                                              )
                                          )
                                        ]);}
                              )
                          ),
                          // 对核心需求的描述
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '对核心需求-付款方式的描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
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
                                hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 定金
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '核心需求2：定金',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('最低定金数额',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onCountPressed(context);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      itemCount.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("万",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 对核心需求的描述
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '对核心需求-居室的描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
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
                                hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 首付
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '核心需求3：首付',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('最低首付数额',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onCountPressed(context);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      itemCount.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("万",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 对核心需求的描述
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '对核心需求-朝向的描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
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
                                hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 其他需求
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '其他需求：',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          // 成交周期
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '成交周期',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          Container(
                              width: 335,
                              // title: '可选的任务名称（ 多选 ）',
                              child: FormField<List<String>>(
                                  initialValue: tags,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 1) {
                                      return "选择不可多于1项";
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: period,
                                                  // 存储形式
                                                  // value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                                  // 展示形式
                                                  label: (index,item)=>item
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                String ids="";
                                                val.forEach((element) {
                                                  var item=selectItemFromJson(element);
                                                  print(item);
                                                  ids+=item.id+',';
                                                  selectTaskIDs = ids;
                                                  print(selectTaskIDs);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              itemConfig: ChipsChoiceItemConfig(
                                                selectedColor: Color(0xFF5580EB),
                                                selectedBrightness: Brightness.dark,
                                                unselectedColor: Color(0xFF5580EB),
                                                unselectedBorderOpacity: .3,
                                              ),
                                              isWrapped: true,
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                state.errorText ?? state.value.length.toString() + '/1 可选',
                                                style: TextStyle(
                                                    color: state.hasError
                                                        ? Colors.redAccent
                                                        : Colors.green
                                                ),
                                              )
                                          )
                                        ]);}
                              )
                          ),

                          // 其他
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '其他',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
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
                                hintText:'请填写要求名称，1~10字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
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
                                hintText:'请填写要求内容，1~10字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 综合描述
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '综合描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
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
                                hintText:'请填写客户需求的综合描述，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 下一步
                          GestureDetector(
                            onTap: ()async{
                              // if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
                              //   _onRefresh();
                              //   _finishPressed(context);
                                _otherNeedPressed(context);
                                // var addResult = await AddCustomerDao.addCustomer(
                                //     userData.companyId,
                                //     userData.userPid,
                                //     "5",
                                //     userNameController.text,
                                //     _radioGroupA.toString(),
                                //     phoneNumController.text,
                                //     _selectedBirthdayDate.toIso8601String(),
                                //     _starIndex.toString(),
                                //     careerController.text==null?"未知":careerController.text,
                                //     incomeMinCount,
                                //     likeController.text==null?"未知":likeController.text,
                                //     msgController.text==null?"未知":msgController.text,
                                //     mapController.text==null?"未知":mapController.text,
                                //     member,  // 家庭成员
                                //     deal,  // 成交历史
                                // );
                                // print(addResult);
                                // if (addResult.code == 200) {
                                //   _onRefresh();
                                //   if (userData.userLevel.substring(0, 1) == "6") {
                                //     Navigator.push(context, MaterialPageRoute(
                                //         builder: (context) => MyTradedPage()));
                                //   }
                                //   if (userData.userLevel.substring(0, 1) == "4") {
                                //     Navigator.push(context, MaterialPageRoute(
                                //         builder: (context) => STradedPage()));
                                //   }
                                //   if (userData.userLevel.substring(0, 1) == "5") {
                                //     Navigator.push(context, MaterialPageRoute(
                                //         builder: (context) => MTradedPage()));
                                //   }
                                // } else {
                                //   _onRefresh();
                                //   _onOverLoadPressed(context);
                                // }
                              // }else{
                              //   // 必填信息不完整的弹窗
                              //   _onMsgPressed(context);
                              // }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration: phoneBool == true &&
                                    userNameBool == true && _starIndex != 0?
                                BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF5580EB)
                                )
                                    :
                                BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF93C0FB)
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text('完成',style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                )
                            ),
                          )
                        ]
                    )
                  ],
                )
            )
        )
    );
  }

  // 输入任务数量弹窗
  _onCountPressed(context) {
    Alert(
      context: context,
      title: "输入任务数量",
      content: Column(
        children: <Widget>[
          TextField(
            controller: countController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if(int.parse(countController.text) > 0){
              setState(() {
                itemCount = int.parse(countController.text.toString());
              });
              Navigator.pop(context);
            }else{
              _onCountWrongPressed(context);
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
          width: 120,
        )
      ],
    ).show();
  }

  // 任务数量不得小于1弹窗
  _onCountWrongPressed(context) {
    Alert(
      context: context,
      title: "任务数量不得小于1",
      desc: "请重试",
      buttons: [
        DialogButton(
          child: Text(
            "知道了",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show();
  }

  _finishPressed(context) {
    Alert(
      context: context,
      title: "添加客户成功",
      desc: "是否继续完善需求信息？",
      buttons: [
        DialogButton(
          child: Text(
            "去完善",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyClientPage()));
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "再等等",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
              if (userData.userLevel.substring(0, 1) == "6") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyClientPage()));
              }
              if (userData.userLevel.substring(0, 1) == "4") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => STradedPage()));
              }
              if (userData.userLevel.substring(0, 1) == "5") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MTradedPage()));
              }
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }

  _otherNeedPressed(context){
    Alert(
      context: context,
      title: "成功完善购买住宅需求",
      desc: "还有出售住宅需求未完善，是否继续完善需求信息？",
      buttons: [
        DialogButton(
          child: Text(
            "去完善",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SellNeedPage()));
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "再等等",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if (userData.userLevel.substring(0, 1) == "6") {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyClientPage()));
            }
            if (userData.userLevel.substring(0, 1) == "4") {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => STradedPage()));
            }
            if (userData.userLevel.substring(0, 1) == "5") {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MTradedPage()));
            }
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }


  _onMsgPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "必填信息还未填写完整",
      desc: "请确认客户姓名、需求、重要度、手机号码是否正确填写",
      buttons: [
        DialogButton(
          child: Text(
            "知道了",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _onOverLoadPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "请检查网络后重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }


  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
  _onMapChanged(String text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
      });
    }
  }
  _onLikeChanged(String text){
    if(text != null){
      setState(() {
        likeBool = likeReg.hasMatch(likeController.text);
      });
    }
  }
  _onMsgChanged(String text){
    if(text != null){
      setState(() {
        msgBool = msgReg.hasMatch(msgController.text);
      });
    }
  }
  _onMemberChanged(String text){
    if(text != null){
      setState(() {
        memberBool = memberReg.hasMatch(memberController.text);
      });
    }
  }
}


