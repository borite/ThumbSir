import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/sell_need_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/set_kpimission_item_model.dart';

import 'add_support_msg_page.dart';
import 'house_list_page.dart';

class AddSellNeedDetailPage extends StatefulWidget {
  @override
  _AddSellNeedDetailPageState createState() => _AddSellNeedDetailPageState();
}

class _AddSellNeedDetailPageState extends State<AddSellNeedDetailPage> {
  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  ScrollController _memberScrollController = ScrollController();
  final TextEditingController countController=TextEditingController();
  bool _loading = false;

  final TextEditingController userNameController = TextEditingController();
  late String userName;
  late RegExp nameReg;
  bool userNameBool = false;
  final TextEditingController phoneNumController=TextEditingController();
  late String phoneNum;
  late RegExp phoneReg;
  bool phoneBool = false;
  final TextEditingController careerController=TextEditingController();
  late String career;
  late RegExp careerReg;
  bool careerBool = false;
  final TextEditingController mapController=TextEditingController();
  late RegExp mapReg;
  bool mapBool = false;
  final TextEditingController likeController=TextEditingController();
  late RegExp likeReg;
  bool likeBool = false;
  final TextEditingController msgController=TextEditingController();
  late RegExp msgReg;
  bool msgBool = false;
  final TextEditingController memberController=TextEditingController();
  late RegExp memberReg;
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
    area=["50平米以下","50-70平米","70-90平米","90-120平米","120-140平米","140-160平米","160-200平米","200平米以上"];
    room=["1居室","2居室","3居室","4居室","5居室及以上"];
    direction = ["东","南","西","北"];
    lift =["有电梯","无电梯"];
    floor =["底层","低楼层","中楼层","高楼层","顶层","无要求"];
    age = ["5年以内","10年以内","15年以内","20年以内","20年以上","无要求"];
    finish = ["精装修","普通装修","毛坯房"];
    traffic = ["近公交","近地铁","无要求"];
    school = ["优质学区","普通学区","无要求"];
    hospital = ["三甲医院","普通医院","无要求"];
    park = ["有公园","无要求"];
    bank = ["有银行","无要求"];
    manager = ["优质物业","普通物业","无要求"];
    market = ["大型购物商场","大型超市","小区内超市","无要求"];
    tax = ["满五唯一","满两年","不满两年","无关"];
    special = ["安静","带车位","带小院","停车方便","绿化率高","容积率低","小区面积大","人车分流","视野好"];

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
                            // margin: EdgeInsets.only(top: 15),
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
                            margin: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(top: 10),
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
                              margin: EdgeInsets.only(top: 10),
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
                                                  value: (index,item)=>item.toString(),
                                                  source: direction,
                                                  // 存储形式
                                                  // value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
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
                                                  value: (index,item)=>item.toString(),
                                                  source: finish,
                                                  // 存储形式
                                                  // value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                                  // 展示形式
                                                  label: (index,item)=>item.toString()
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
                                                  // value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                                  // 展示形式
                                                  label: (index,item)=>item.toString(),
                                                value: (index,item)=>item.toString(),
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
                                                      itemLength = state.value!.length;
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
                                                state.errorText ?? state.value!.length.toString() + '/1 可选',
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
                            controller: userNameController,
                            inputType: TextInputType.text,
                            reg: nameReg,
                            onChanged: (text){
                              setState(() {
                                userName = text;
                                userNameBool = nameReg.hasMatch(userName);
                              });
                            }, password: false,
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
                                                  // value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                                  // 展示形式
                                                  label: (index,item)=>item.toString(),
                                                value: (index,item)=>item.toString(),
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
                            onTap: ()async{
                              // if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
                              //   _onRefresh();
                                 _finishPressed(context);
                              //    _otherNeedPressed(context);
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
                builder: (context) => AddSupportMsgPage()));
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
}


