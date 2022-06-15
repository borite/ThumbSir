import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/add_house_step1_dao.dart';
import 'package:ThumbSir/dao/get_company_list_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/company_list_model.dart';
import 'house_add_basic_msg_page.dart';
import 'house_list_page.dart';

class HouseAddPage extends StatefulWidget {
  @override
  _HouseAddPageState createState() => _HouseAddPageState();
}

class _HouseAddPageState extends State<HouseAddPage> {
  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  ScrollController _memberScrollController = ScrollController();
  bool _loading = false;
  final TextEditingController countController=TextEditingController();
  int itemCount = 1;
  final TextEditingController communityController=TextEditingController();
  String communityName = "";
  final TextEditingController addressController=TextEditingController();
  String address = "";
  final TextEditingController userNameController = TextEditingController();
  late String userName;
  late RegExp nameReg;
  bool userNameBool = false;
  final TextEditingController phoneNumController=TextEditingController();
  late String phoneNum;
  late RegExp phoneReg;
  bool phoneBool = false;
  final TextEditingController agentNameController = TextEditingController();
  late String agentName;
  late RegExp agentReg;
  bool agentNameBool = false;
  final TextEditingController agentPhoneNumController=TextEditingController();
  late String agentPhoneNum;
  late RegExp agentPhoneReg;
  bool agentPhoneBool = false;
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

  String needMinCount = "出售住宅";
  String tradeMinCount = "着急";
  String incomeMinCount = "10万以下";
  String comeMinCount = "社区开发";
  String reasonMinCount = "闲置";

  List<DealInfo> deal=[];
  List<NeedInfo> need=[];
  List<FamilyMember> member=[];
  DateTime selectedDate=DateTime(2021,1,1);

  dynamic _radioGroupA = 0;
  dynamic addResult;

  // String text;
  // String p1;
  // String p2;
  // String p3;
  // void _incrementCounter() async {
  //   CityResult result = await showCityPicker(context,
  //       initCity: CityResult()
  //         ..province = p1
  //         ..city = p2
  //         ..county = p3
  //   );
  //
  //   if (result == null) {
  //     return;
  //   }
  //
  //   p1 = result?.province;
  //   p2 = result?.city;
  //   p3 = result?.county;
  //
  //   setState(() {
  //     text = "${result?.province} - ${result?.city} - ${result?.county}";
  //   });
  // }

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  late Datum selectedItem;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  late List<Datum> companies;
  final list = <Datum>[];

  _load() async {
    var r = await GetCompanyListDao.httpGetCompanyList();
    companies = r.data!;
  }

  @override
  void initState() {
    nameReg = TextReg;
    phoneReg = telPhoneReg;
    careerReg = TextReg;
    mapReg = FeedBackReg;
    likeReg = TextReg;
    msgReg = FeedBackReg;
    memberReg = TextReg;
    agentReg = TextReg;
    agentPhoneReg = telPhoneReg;
    _getUserInfo();
    _load();
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
    agentNameController.dispose();
    agentPhoneNumController.dispose();
    addressController.dispose();
    communityController.dispose();
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
                              padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
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
                                        child: Text('新增房源',style: TextStyle(
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
                          // 选择房源所在区域
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '房源所在区域：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          GestureDetector(
                            // onTap: _incrementCounter,
                            child: Container(
                              width: 335,
                              height: 40,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF2692FD)),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:EdgeInsets.only(left: 10),
                                    child: Text(
                                      // text ?? "点击选择",
                                      "点击选择",
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:EdgeInsets.only(right: 10),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 房源所在小区
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    '房源所在小区：',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _onCommunityPressed(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                      ),
                                      child: Text(
                                        communityName==""?"点击输入":communityName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF5580EB),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                    ),
                                  ),
                                  Text(
                                    '小区',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),

                                ],
                              )
                          ),

                          // 房源地址
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  '房源地址：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onAddressPressed(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      // address,
                                      address==""?"点击输入":address,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                  ),
                                ),
                              ],
                            )
                          ),

                          // 报价
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15,bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('报价:',style: TextStyle(
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

                          // 房源来源
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '房源来源：',
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
                              datas: ["社区开发", "店面接待", "电话开发", "老客户再交易","老客户转介绍","其他"],
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
                          // 交易类型
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '交易类型：',
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
                                  needMinCount = s;
                                });
                              },
                              datas: ["出售住宅", "出售公寓", "出售商铺", "出售车位","出租住宅", "出租住宅", "出租住宅", "出租住宅",],
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
                          // 交易迫切度
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '交易迫切度：',
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
                                  tradeMinCount = s;
                                });
                              },
                              datas: ["着急", "诚心", "一般", "下架","已成交"],
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

                          // 出售原因
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '交易原因：',
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
                                  reasonMinCount = s;
                                });
                              },
                              datas: ["闲置","变现", "换房改善", "离开当前城市","其他"],
                              // 出租
                              // datas: ["闲置", "离开当前城市","其他"],
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

                          // 期望成交时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 25),
                            child: Text(
                              '期望成交时间：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(1940),
                              lastDate: DateTime(2030, 1, 1),
                              initialDate: DateTime(2021),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => selectedDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),

                          // 房源介绍
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '房源介绍：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 30),
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
                                hintText:'此介绍可以通过分享展示给客户，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 业主姓名
                          Container(
                            width: 335,
                            child: Text(
                              '业主姓名：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入业主姓名",
                            tipText: "请输入业主姓名",
                            errorTipText: "请输入业主姓名",
                            rightText: "请输入业主姓名",
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

                          // 业主手机号
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '业主手机号码：',
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
                            tipText: "请输入业主的手机号码",
                            errorTipText: "请输入格式正确的手机号码",
                            rightText: "手机号码格式正确",
                            controller: phoneNumController,
                            inputType: TextInputType.phone,
                            reg: phoneReg,
                            password: false,
                            onChanged: (text){
                              setState(() {
                                phoneNum = text;
                                phoneBool = phoneReg.hasMatch(phoneNum);
                              });
                            },
                          ),

                          // 是否有代理人
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
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
                                  groupValue: _radioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _radioGroupA = value;
                                    });
                                  },
                                  title: Text('本人交易'),
                                  selected: _radioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _radioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _radioGroupA = value;
                                    });
                                  },
                                  title: Text('有代理人'),
                                  selected: _radioGroupA == 1,
                                ),
                              ],
                            ),
                          ),
                          _radioGroupA == 1?
                          Column(
                            children: [
                              // 代理人姓名
                              Container(
                                width: 335,
                                child: Text(
                                  '代理人姓名：',
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
                                controller: agentNameController,
                                inputType: TextInputType.text,
                                reg: agentReg,
                                password: false,
                                onChanged: (text){
                                  setState(() {
                                    agentName = text;
                                    agentNameBool = agentReg.hasMatch(agentName);
                                  });
                                },
                              ),

                              // 代理人手机号
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  '代理人手机号码：',
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
                                controller: agentPhoneNumController,
                                inputType: TextInputType.phone,
                                reg: agentPhoneReg,
                                password: false,
                                onChanged: (text){
                                  setState(() {
                                    agentPhoneNum = text;
                                    agentPhoneBool = agentPhoneReg.hasMatch(agentPhoneNum);
                                  });
                                },
                              ),
                            ],
                          ):Container(width: 1,),


                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              if(communityName!="" && address!="" && userNameBool == true && phoneBool == true ){
                                _onRefresh();
                                addResult = await AddHouseStep1Dao.addHouseStep1(
                                  userData!.companyId,   // 公司id
                                  userNameController.text, // 业主姓名
                                  phoneNumController.text,  // 业主电话
                                  userData!.userPid, // 录入人id
                                  selectedDate.toString(), // 期望成交时间
                                  needMinCount.substring(0,2), // 交易类型
                                  needMinCount.substring(3,4), // 房源类型
                                  "",// text, // 房源所在区域
                                  communityName, // 房源小区名称
                                  address, // 房源具体地址
                                  comeMinCount, // 房屋来源
                                    itemCount, // 房屋价格
                                  tradeMinCount, // 交易迫切度
                                  reasonMinCount, // 交易原因
                                  agentNameController.text, // 代理人姓名
                                  agentPhoneNumController.text, // 代理人手机号码
                                  mapController.text, // 房源介绍
                                  "", // 房屋权属
                                );
                                if (addResult.code == 200 || addResult.code ==210) {
                                  _onRefresh();
                                  _finishPressed(context);
                                } else {
                                  _onRefresh();
                                  _onOverLoadPressed(context);
                                }
                              }
                              else{
                                _onRefresh();
                                // 必填信息不完整的弹窗
                                _onMsgPressed(context);
                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration: communityName!="" && address!="" && userNameBool == true && phoneBool == true ?
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

  // 输入报价数额弹窗
  _onCountPressed(context) {
    Alert(
      context: context,
      title: "请输入报价数额（单位万元）",
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
            setState(() {
              itemCount = int.parse(countController.text.toString());
            });
            Navigator.pop(context);
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
  // 输入小区名称弹窗
  _onCommunityPressed(context) {
    Alert(
      context: context,
      title: "输入小区名称",
      desc:'例如金鱼池小区，仅输入金鱼池即可',
      content: Column(
        children: <Widget>[
          TextField(
            controller: communityController,
            keyboardType: TextInputType.text,
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
            setState(() {
              communityName = communityController.text;
            });
            Navigator.pop(context);
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
  // 输入房源地址弹窗
  _onAddressPressed(context) {
    Alert(
      context: context,
      title: "输入房源地址",
      desc:"仅输入楼栋号+单元号+门牌号即可，例如1号楼1单元101室",
      content: Column(
        children: <Widget>[
          TextField(
            controller: addressController,
            keyboardType: TextInputType.text,
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
            setState(() {
              address = addressController.text;
            });
            Navigator.pop(context);
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

  _finishPressed(context) {
    Alert(
      context: context,
      title: "添加房源成功",
      desc: "是否继续完善房源基本信息？",
      buttons: [
        DialogButton(
          child: Text(
            "去完善",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HouseAddBasicMsgPage(
                    houseId:addResult.data.houseId,
                    totalPrice: addResult.data.housePrice,
                )));
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


  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
  _onMapChanged(dynamic text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
      });
    }
  }
}


