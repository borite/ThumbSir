import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/add_house_step2_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'house_add_around_msg_page.dart';
import 'house_list_page.dart';

class HouseAddBasicMsgPage extends StatefulWidget {
  final houseId;
  HouseAddBasicMsgPage({Key? key,
    this.houseId,
  }):super(key:key);
  @override
  _HouseAddBasicMsgPageState createState() => _HouseAddBasicMsgPageState();
}

class _HouseAddBasicMsgPageState extends State<HouseAddBasicMsgPage> {
  final TextEditingController countController=TextEditingController();
  final TextEditingController areaController=TextEditingController();
  final TextEditingController roomController=TextEditingController();
  final TextEditingController sittingRoomController=TextEditingController();
  final TextEditingController kitchenController=TextEditingController();
  final TextEditingController toiletController=TextEditingController();
  final TextEditingController floorController=TextEditingController();
  final TextEditingController totalFloorController=TextEditingController();
  final TextEditingController houseAgeController=TextEditingController();
  final TextEditingController managementCompanyController=TextEditingController();
  late String companyName;
  late RegExp companyReg;
  bool companyNameBool = false;
  final TextEditingController managementPriceController=TextEditingController();
  bool _loading = false;

  int itemCount = 1;
  int areaCount = 1;
  int roomCount = 1;

  List<String> tags = [];
  List idList = [];

  String directionSelect="";
  String decorationSelect="";
  String elevatorSelect="";
  String taxSelect="";
  String managementSelect="";

  int itemLength = 0;
  List missionContent=[];
  // List<Datum> tasks = [];
  List<String> area = [];
  List<String> room = [];
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

  List<DealInfo> deal=[];
  List<NeedInfo> need=[];
  List<FamilyMember> member=[];

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  @override
  void initState() {
    companyReg = TextReg;

    areaController.text = "1";
    roomController.text = "1";
    sittingRoomController.text = "1";
    kitchenController.text = "1";
    toiletController.text = "1";
    floorController.text = "1";
    totalFloorController.text = "1";
    houseAgeController.text = "2000";
    managementPriceController.text = "0";

    _getUserInfo();
    // _load();
    direction = ["东","南","西","北","未知"];
    lift =["有电梯","无电梯","未知"];
    finish = ["精装修","普通装修","毛坯房","未知"];
    manager = ["优质物业","普通物业","无物业","未知"];
    tax = ["满五唯一","满两年","不满两年","无关","未知"];

    super.initState();

  }

  @override
  void dispose(){
    countController.dispose();
    areaController.dispose();
    roomController.dispose();
    sittingRoomController.dispose();
    kitchenController.dispose();
    toiletController.dispose();
    floorController.dispose();
    totalFloorController.dispose();
    houseAgeController.dispose();
    managementPriceController.dispose();
    managementCompanyController.dispose();
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
                                        child: Text('完善房源基本信息',style: TextStyle(
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

                          // 面积
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('面积:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: areaController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("平米",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 卧室数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('卧室数量:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: roomController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("间",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 客餐厅数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('客餐厅数量:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: sittingRoomController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("个",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 厨房数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('厨房数量:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: kitchenController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("个",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 卫生间数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('卫生间数量:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: toiletController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("个",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 所处楼层
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('所处楼层:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: floorController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("层",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 总楼层
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('总楼层:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: totalFloorController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("层",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 朝向
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '朝向：',
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
                                    if (value==null) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 4) {
                                      return "选择不可多于4项";
                                    }
                                    return null;
                                  },
                                  builder: (dynamic state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              choiceItems:  C2Choice.listFrom(
                                                  source: direction,
                                                  // 存储形式
                                                  value:(index,item)=>item.toString(),
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                directionSelect="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  print(item);
                                                  directionSelect+=item + ',';
                                                  print(directionSelect);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              choiceStyle: const C2ChoiceStyle(
                                                color: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              choiceActiveStyle: const C2ChoiceStyle(
                                                color: Color(0xFFFFFFFF),
                                                backgroundColor: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              wrapped: true,
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                state.errorText ?? state.value.length.toString() + '/4 可选',
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
                          // 装修
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '装修',
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
                                    if (value==null) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 1) {
                                      return "选择不可多于1项";
                                    }
                                    return null;
                                  },
                                  builder: (dynamic state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              choiceItems:  C2Choice.listFrom(
                                                  source: finish,
                                                  // 存储形式
                                                  value:(index,item)=>item.toString(),
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                decorationSelect="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  print(item);
                                                  decorationSelect+=item + ',';
                                                  print(decorationSelect);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              choiceStyle: const C2ChoiceStyle(
                                                color: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              choiceActiveStyle: const C2ChoiceStyle(
                                                color: Color(0xFFFFFFFF),
                                                backgroundColor: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              wrapped: true,
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
                          // 楼龄
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('建成年份:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: houseAgeController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("年",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 电梯
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '电梯',
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
                                    if (value==null) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 1) {
                                      return "选择不可多于1项";
                                    }
                                    return null;
                                  },
                                  builder: (dynamic state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              choiceItems:  C2Choice.listFrom(
                                                  source: lift,
                                                  // 存储形式
                                                  value:(index,item)=>item.toString(),
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                elevatorSelect="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  print(item);
                                                  elevatorSelect+=item + ',';
                                                  print(elevatorSelect);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              choiceStyle: const C2ChoiceStyle(
                                                color: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              choiceActiveStyle: const C2ChoiceStyle(
                                                color: Color(0xFFFFFFFF),
                                                backgroundColor: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              wrapped: true,
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
                          // 物业公司名称
                          Container(
                            width: 335,
                            child: Text(
                              '物业公司名称：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入物业公司名称",
                            tipText: "请输入物业公司名称",
                            errorTipText: "请输入物业公司名称",
                            rightText: "请输入物业公司名称",
                            controller: managementCompanyController,
                            inputType: TextInputType.text,
                            reg: companyReg,
                            onChanged: (text){
                              setState(() {
                                companyName = text;
                                companyNameBool = companyReg.hasMatch(companyName);
                              });
                            }, password: false,
                          ),
                          Container(
                              width: 335,
                              // title: '可选的任务名称（ 多选 ）',
                              child: FormField<List<String>>(
                                  initialValue: tags,
                                  validator: (value) {
                                    if (value==null) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 1) {
                                      return "选择不可多于1项";
                                    }
                                    return null;
                                  },
                                  builder: (dynamic state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              choiceItems:  C2Choice.listFrom(
                                                  source: manager,
                                                  // 存储形式
                                                  value:(index,item)=>item.toString(),
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                managementSelect="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  print(item);
                                                  managementSelect+=item + ',';
                                                  print(managementSelect);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              choiceStyle: const C2ChoiceStyle(
                                                color: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              choiceActiveStyle: const C2ChoiceStyle(
                                                color: Color(0xFFFFFFFF),
                                                backgroundColor: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              wrapped: true,
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
                          // 物业费
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('物业费:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: TextField(
                                      controller: managementPriceController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text("元/平米/月",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 税费
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '税费',
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
                                    if (value==null) {
                                      return '请选择核心任务的名称';
                                    }
                                    if (value.length > 1) {
                                      return "选择不可多于1项";
                                    }
                                    return null;
                                  },
                                  builder: (dynamic state) {
                                    return Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              choiceItems:  C2Choice.listFrom(
                                                  source: tax,
                                                  // 存储形式
                                                  value:(index,item)=>item.toString(),
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                taxSelect="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  print(item);
                                                  taxSelect+=item + ',';
                                                  print(taxSelect);
                                                  if(state.value != null){
                                                    setState(() {
                                                      itemLength = state.value.length;
                                                    });
                                                  }
                                                });
                                              },
                                              choiceStyle: const C2ChoiceStyle(
                                                color: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              choiceActiveStyle: const C2ChoiceStyle(
                                                color: Color(0xFFFFFFFF),
                                                backgroundColor: Color(0xFF5580EB),
                                                borderOpacity: .3,
                                              ),
                                              wrapped: true,
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

                          // 下一步
                          GestureDetector(
                            onTap: ()async {
                              // if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
                              _onRefresh();

                              //    _otherNeedPressed(context);
                              var addResult = await AddHouseStep2Dao
                                  .addHouseStep2(
                                  widget.houseId.toString(),
                                  areaController.text,
                                  roomController.text + "-" +
                                      sittingRoomController.text + "-" +
                                      kitchenController.text + "-" +
                                      toiletController.text,
                                  directionSelect == ""
                                      ? "未知"
                                      : directionSelect,
                                  floorController.text,
                                  totalFloorController.text,
                                  decorationSelect == ""
                                      ? "未知"
                                      : decorationSelect,
                                  houseAgeController.text,
                                  managementCompanyController.text+"-"+(managementSelect==""?"未知":managementSelect),
                                  managementPriceController.text,
                                  elevatorSelect == "" ? "未知" : elevatorSelect,
                                  taxSelect == "" ? "未知" : taxSelect
                              );
                              print(addResult);
                              if (addResult.code == 200 ||
                                  addResult.code == 201) {
                                _onRefresh();
                                _finishPressed(context);
                                // if (userData.userLevel.substring(0, 1) == "6") {
                                //   Navigator.push(context, MaterialPageRoute(
                                //       builder: (context) => MyTradedPage()));
                                // }
                                // if (userData.userLevel.substring(0, 1) == "4") {
                                //   Navigator.push(context, MaterialPageRoute(
                                //       builder: (context) => STradedPage()));
                                // }
                                // if (userData.userLevel.substring(0, 1) == "5") {
                                //   Navigator.push(context, MaterialPageRoute(
                                //       builder: (context) => MTradedPage()));
                                // }
                              } else {
                                _onRefresh();
                                _onOverLoadPressed(context);
                                // }
                                // }else{
                                //   // 必填信息不完整的弹窗
                                //   _onMsgPressed(context);
                                // }
                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration:
                                BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF5580EB)
                                ),
                                //     :
                                // BoxDecoration(
                                //     border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                //     borderRadius: BorderRadius.circular(8),
                                //     color: Color(0xFF93C0FB)
                                // )
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

  _finishPressed(context) {
    Alert(
      context: context,
      title: "房源基本信息完善成功",
      desc: "是否继续完善配套与优势信息？",
      buttons: [
        DialogButton(
          child: Text(
            "去完善",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HouseAddAroundMsgPage()));
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "再等等",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
              if (userData!.userLevel.substring(0, 1) == "6") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HouseListPage()));
              }
              if (userData!.userLevel.substring(0, 1) == "4") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => STradedPage()));
              }
              if (userData!.userLevel.substring(0, 1) == "5") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MTradedPage()));
              }
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
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
}


