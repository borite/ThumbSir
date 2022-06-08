import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/buy_need_detail_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';

class BuyNeedPage extends StatefulWidget {
  final cid;
  final mainNeed;
  final userName;

  BuyNeedPage({Key key,
    this.cid,this.mainNeed,this.userName
  }):super(key:key);
  @override
  _BuyNeedPageState createState() => _BuyNeedPageState();
}

class _BuyNeedPageState extends State<BuyNeedPage> {
  String items="";
  bool _loading = false;

  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  final TextEditingController agencyMemberScrollController = TextEditingController();
  String agencyPhoneNum = "-";
  RegExp agencyPhoneReg;
  bool agencyPhoneBool;
  final TextEditingController desideMemberController = TextEditingController();
  String desidePhoneNum = "-";
  RegExp desidePhoneReg;
  bool desidePhoneBool;
  final TextEditingController firstPriceNumController = TextEditingController();
  int firstPriceNum=1;
  RegExp firstPriceNumReg;
  bool firstPriceNumBool;
  final TextEditingController totalPriceNumController = TextEditingController();
  int totalPriceNum=1;
  RegExp totalPriceNumReg;
  bool totalPriceNumBool;
  final TextEditingController yaPriceNumController = TextEditingController();
  int yaPriceNum=1;
  RegExp yaPriceNumReg;
  bool yaPriceNumBool;
  final TextEditingController fuPriceNumController = TextEditingController();
  int fuPriceNum=1;
  RegExp fuPriceNumReg;
  bool fuPriceNumBool;
  final TextEditingController agencyNameController = TextEditingController();
  String agencyName = "-";
  RegExp agencyNameReg;
  bool agencyNameBool;
  final TextEditingController desideNameController = TextEditingController();
  String desideName = "-";
  RegExp desideNameReg;
  bool desideNameBool;
  final TextEditingController msgController=TextEditingController();
  RegExp msgReg;
  bool msgBool = false;

  String dealMinCount = "购买住宅";
  String needMinCount = "购买住宅";
  String incomeMinCount = "10万以下";
  String comeMinCount = "社区开发";
  List<String> tags = [];
  List idList = [];
  String selectTaskIDs="";
  int itemLength = 0;
  List missionContent=new List();
  List<String> tasks = [];

  List<DealInfo> deal=new List();
  List<NeedInfo> need=new List();
  List<FamilyMember> member=new List();

  int _desideRadioGroupA = 0;
  int _buyWayRadioGroupA = 0;
  int _statusRadioGroupA = 0;
  int _agencyRadioGroupA = 0;

  void _handleDesideRadioValueChanged(int value) {
    setState(() {
      _desideRadioGroupA = value;
    });
  }

  void _handleBuyWayRadioValueChanged(int value) {
    setState(() {
      _buyWayRadioGroupA = value;
    });
  }

  void _handleStatusRadioValueChanged(int value) {
    setState(() {
      _statusRadioGroupA = value;
    });
  }

  void _handleAgencyRadioValueChanged(int value) {
    setState(() {
      _agencyRadioGroupA = value;
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

  @override
  void initState() {
    agencyNameReg = TextReg;
    desideNameReg = TextReg;
    agencyPhoneReg = telPhoneReg;
    desidePhoneReg = telPhoneReg;
    totalPriceNumReg = TextReg;
    msgReg = FeedBackReg;
    firstPriceNumReg = TextReg;
    yaPriceNumReg = TextReg;
    fuPriceNumReg = TextReg;
    _getUserInfo();
    tasks=["面积","居室","朝向","电梯","楼层","楼龄","装修","交通","学区","医院","银行","公园","商场","物业","税费","特殊要求","其他"];
    super.initState();

  }

  @override
  void dispose(){
    _dealScrollController.dispose();
    _needScrollController.dispose();
    msgController.dispose();
    agencyNameController.dispose();
    agencyMemberScrollController.dispose();
    desideMemberController.dispose();
    desideNameController.dispose();
    firstPriceNumController.dispose();
    totalPriceNumController.dispose();
    yaPriceNumController.dispose();
    fuPriceNumController.dispose();
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
                                        child: Text(
                                          // '张先生的购买住宅需求',
                                          widget.userName+"的"+widget.mainNeed+"需求",
                                          style: TextStyle(
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

                          // 购房原因
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              widget.mainNeed.substring(0,2) +'原因：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 120,
                            margin: EdgeInsets.only(top: 18),
                            child: WheelChooser(
                              onValueChanged: (s){
                                setState(() {
                                  comeMinCount = s;
                                });
                              },

                              // 原因
                              datas:
                              widget.mainNeed == "购买住宅"?
                              ["刚需首套","改善", "婚房", "上学", "投资","养老","办公","其他"]
                              :widget.mainNeed == "购买商铺"?
                              ["投资","办公","其他"]
                              :widget.mainNeed == "租赁商铺"?
                              ["办公","其他"]
                              :widget.mainNeed == "购买车位"?
                              ["投资","自用","其他"]
                              :widget.mainNeed == "租赁车位"?
                              ["自用","其他"]
                              :widget.mainNeed == "购买公寓"?
                              ["自住", "投资","办公","其他"]
                              :widget.mainNeed == "租赁公寓"?
                              ["自住","办公","其他"]
                              :["上班","陪读", "换房周转", "办公","长辈暂住", "上学","其他"],
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

                          // 是否为购房决策人
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '是否为'+widget.mainNeed.substring(0,2)+'决策人：',
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
                            width: 335,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _desideRadioGroupA,
                                  onChanged: _handleDesideRadioValueChanged,
                                  title: Text('是'),
                                  selected: _desideRadioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _desideRadioGroupA,
                                  onChanged: _handleDesideRadioValueChanged,
                                  title: Text('否'),
                                  selected: _desideRadioGroupA == 1,
                                ),
                              ],
                            ),
                          ),

                          _desideRadioGroupA == 1?
                          Column(
                            children: [
                              // 决策人姓名
                              Container(
                                width: 335,
                                child: Text(
                                  '决策人姓名（选填）：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "请输入决策人姓名",
                                tipText: "请输入决策人姓名",
                                errorTipText: "请输入决策人姓名",
                                rightText: "请输入决策人姓名",
                                controller: desideNameController,
                                inputType: TextInputType.text,
                                reg: desideNameReg,
                                onChanged: (text){
                                  setState(() {
                                    desideName = text;
                                    desideNameBool = desideNameReg.hasMatch(desideName);
                                  });
                                },
                              ),
                              // 决策人手机号
                              Container(
                                width: 335,
                                child: Text(
                                  '决策人手机号码：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "手机号码",
                                tipText: "请输入决策人的手机号码",
                                errorTipText: "请输入格式正确的手机号码",
                                rightText: "手机号码格式正确",
                                controller: desideMemberController,
                                inputType: TextInputType.phone,
                                reg: desidePhoneReg,
                                onChanged: (text){
                                  setState(() {
                                    desidePhoneNum = text;
                                    desidePhoneBool = desidePhoneReg.hasMatch(desidePhoneNum);
                                  });
                                },
                              ),
                            ],
                          )
                          :Container(width: 1,),

                          // 是否有代理人
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '是否有代理人：',
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
                            width: 335,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _agencyRadioGroupA,
                                  onChanged: _handleAgencyRadioValueChanged,
                                  title: Text('否'),
                                  selected: _agencyRadioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _agencyRadioGroupA,
                                  onChanged: _handleAgencyRadioValueChanged,
                                  title: Text('是'),
                                  selected: _agencyRadioGroupA == 1,
                                ),
                              ],
                            ),
                          ),

                          _agencyRadioGroupA == 1?
                          Column(
                            children: [
                              // 代理人姓名
                              Container(
                                width: 335,
                                child: Text(
                                  '代理人姓名（选填）：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "请输入代理人姓名",
                                tipText: "请输入代理人姓名",
                                errorTipText: "请输入代理人姓名",
                                rightText: "请输入代理人姓名",
                                controller: agencyNameController,
                                inputType: TextInputType.text,
                                reg: agencyNameReg,
                                onChanged: (text){
                                  setState(() {
                                    agencyName = text;
                                    agencyNameBool = agencyNameReg.hasMatch(agencyName);
                                  });
                                },
                              ),
                              // 代理人手机号
                              Container(
                                width: 335,
                                child: Text(
                                  '代理人手机号码（选填）：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "手机号码",
                                tipText: "请输入代理人的手机号码",
                                errorTipText: "请输入格式正确的手机号码",
                                rightText: "手机号码格式正确",
                                controller: agencyNameController,
                                inputType: TextInputType.phone,
                                reg: agencyPhoneReg,
                                onChanged: (text){
                                  setState(() {
                                    agencyPhoneNum = text;
                                    agencyPhoneBool = agencyPhoneReg.hasMatch(agencyPhoneNum);
                                  });
                                },
                              ),
                            ],
                          )
                              :Container(width: 1,),


                          // 付款方式
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '付款方式：',
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
                          widget.mainNeed.substring(0,2)=="购买"?
                          Container(
                            width: 335,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _buyWayRadioGroupA,
                                  onChanged: _handleBuyWayRadioValueChanged,
                                  title: Text('贷款'),
                                  selected: _buyWayRadioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _buyWayRadioGroupA,
                                  onChanged: _handleBuyWayRadioValueChanged,
                                  title: Text('全款'),
                                  selected: _buyWayRadioGroupA == 1,
                                ),
                              ],
                            ),
                          )
                          :
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('押',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onYaPriceCountPressed(context);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      yaPriceNum.toString(),
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
                                  child: Text('付',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onFuPriceCountPressed(context);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      fuPriceNum.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 首付预算+总价预算或月租金预算+押金预算
                          widget.mainNeed.substring(0,2)=="购买"?
                          Column(
                            children: [
                              // 首付预算
                              _buyWayRadioGroupA == 0?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('首付预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onFirstPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          firstPriceNum.toString(),
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
                              ):Container(width: 1,),
                              // 总价预算
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('总价预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onTotalPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          totalPriceNum.toString(),
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
                            ],
                          )
                          :
                          Column(
                            children: [
                              // 月租金预算
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('月租金预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onFirstPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          firstPriceNum.toString(),
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
                                      child: Text("元/月",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              // 押金预算
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('押金预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onTotalPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          totalPriceNum.toString(),
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
                                      child: Text("元",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),



                          // 意向区域和小区
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '意向区域和小区：',
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
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: msgController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onMsgChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写客户的意向区域或小区，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 选择核心需求
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '选择核心需求(1~3项)',
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
                                    if (value.length > 3) {
                                      return "选择不可多于3项";
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
                                                  source: tasks,
                                                  // 存储形式
                                                  value:(index,item)=>item,
                                                  // 展示形式
                                                  label: (index,item)=>item
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                items="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  items+=item+',';
                                                  print(items);
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
                                                state.errorText ?? state.value.length.toString() + '/3 可选',
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
                              if (items != null&& items!="") {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (
                                    context) =>
                                    BuyNeedDetailPage(
                                        cid: widget.cid,
                                        mainNeed: widget.mainNeed,
                                        needReason: comeMinCount,
                                        userName: widget.userName,
                                        coreNeedNames: items,
                                        otherMsg:
                                        // 是否为购房决策人
                                        '是否为' +
                                            widget.mainNeed.substring(0, 2) +
                                            '决策人:' + (_desideRadioGroupA == 0
                                            ? "是"
                                            : "否") + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '决策人姓名:' + desideName + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '决策人手机号:' + desidePhoneNum + ","
                                            // 是否有代理人
                                            + '是否有' +
                                            widget.mainNeed.substring(0, 2) +
                                            '代理人:' + (_agencyRadioGroupA == 0
                                            ? "否"
                                            : "是") + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '代理人姓名:' + agencyName + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '代理人手机号:' + agencyPhoneNum + ","
                                            // 付款方式
                                            + "付款方式:" +
                                            (widget.mainNeed.substring(0, 2) ==
                                                "购买" && _buyWayRadioGroupA == 0
                                                ? "贷款"
                                                : widget.mainNeed.substring(
                                                0, 2) == "购买" &&
                                                _buyWayRadioGroupA == 1
                                                ? "全款"
                                                : "押" + yaPriceNum.toString() +
                                                "付" + fuPriceNum.toString()) +
                                            ","
                                            // 首付预算/月租金预算
                                            +
                                            (widget.mainNeed.substring(0, 2) ==
                                                "购买"
                                                ? "首付预算:" +
                                                firstPriceNum.toString() + "万"
                                                : "月租金预算:" +
                                                firstPriceNum.toString() +
                                                "元/月") + ","
                                            // 总价预算/押金预算
                                            +
                                            (widget.mainNeed.substring(0, 2) ==
                                                "购买"
                                                ? "总价预算:" +
                                                totalPriceNum.toString() + "万"
                                                : "押金预算:" +
                                                totalPriceNum.toString() +
                                                "元/月") + ","
                                            // 意向区域或小区
                                            + "意向区域或小区:" + msgController.text ??
                                            "无" + ','

                                    )));
                              }
                              else{
                                _onMsgPressed(context);
                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration:items != null&& items!=""?
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
                                    child: Text('下一步：完善需求信息',style: TextStyle(
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

  // 输入首付弹窗
  _onFirstPriceCountPressed(context) {
    Alert(
      context: context,
      title: "请输入金额数字",
      content: Column(
        children: <Widget>[
          TextField(
            controller: firstPriceNumController,
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
            if(int.parse(firstPriceNumController.text) > 0){
              setState(() {
                firstPriceNum = int.parse(firstPriceNumController.text.toString());
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

  // 输入总价弹窗
  _onTotalPriceCountPressed(context) {
    Alert(
      context: context,
      title: "请输入金额数字",
      content: Column(
        children: <Widget>[
          TextField(
            controller: totalPriceNumController,
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
            if(int.parse(totalPriceNumController.text) > 0){
              setState(() {
                totalPriceNum = int.parse(totalPriceNumController.text.toString());
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

  // 押n弹窗
  _onYaPriceCountPressed(context) {
    Alert(
      context: context,
      title: "输入押金月份数",
      content: Column(
        children: <Widget>[
          TextField(
            controller: yaPriceNumController,
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
            if(int.parse(yaPriceNumController.text) > 0){
              setState(() {
                yaPriceNum = int.parse(yaPriceNumController.text.toString());
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

  // 付n弹窗
  _onFuPriceCountPressed(context) {
    Alert(
      context: context,
      title: "输入付款周期月份数",
      content: Column(
        children: <Widget>[
          TextField(
            controller: fuPriceNumController,
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
            if(int.parse(fuPriceNumController.text) > 0){
              setState(() {
                fuPriceNum = int.parse(fuPriceNumController.text.toString());
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

  // 数量不得小于1弹窗
  _onCountWrongPressed(context) {
    Alert(
      context: context,
      title: "数值不得小于1",
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

  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }

  _onMsgChanged(String text){
    if(text != null){
      setState(() {
        msgBool = msgReg.hasMatch(msgController.text);
      });
    }
  }

  _onMsgPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "请至少选择1个核心需求",
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


