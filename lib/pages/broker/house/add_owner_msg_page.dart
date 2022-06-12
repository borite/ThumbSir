import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/buy_need_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'house_list_page.dart';

class AddOwnerMsgPage extends StatefulWidget {
  @override
  _AddOwnerMsgPageState createState() => _AddOwnerMsgPageState();
}

class _AddOwnerMsgPageState extends State<AddOwnerMsgPage> {
  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  ScrollController _memberScrollController = ScrollController();
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

  List<DealInfo> deal=[];
  List<NeedInfo> need=[];
  List<FamilyMember> member=[];

  DateTime _selectedDate=DateTime(2020,1,1);
  DateTime _selectedBirthdayDate=DateTime(1980,1,1);

  List<String> tags = [];
  List<String> special = [];

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
    nameReg = TextReg;
    phoneReg = telPhoneReg;
    careerReg = TextReg;
    mapReg = FeedBackReg;
    likeReg = TextReg;
    msgReg = FeedBackReg;
    memberReg = TextReg;
    _getUserInfo();
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
                                        child: Text('完善业主隐私信息',style: TextStyle(
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

                          // 温馨提示
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '以下信息仅维护人可编辑，且仅对维护人及其直属上级可见',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFF24848),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          // 业主身份证照片
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '业主身份证照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addNeedAlertPressed(context);
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: 335,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xFF93C0FB)
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "+ 上传业主身份证照片",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 房本照片
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '房本照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addNeedAlertPressed(context);
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: 335,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xFF93C0FB)
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "+ 上传房本照片",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 出售委托协议
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '出售委托协议照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addNeedAlertPressed(context);
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: 335,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xFF93C0FB)
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "+ 上传出售委托协议",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // 出售委托协议到期时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '出售委托协议到期时间：',
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
                              initialDate: DateTime(1980),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedBirthdayDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),

                          // 独家委托协议
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '独家委托协议照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addNeedAlertPressed(context);
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: 335,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xFF93C0FB)
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "+ 上传独家委托协议照片",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // 独家委托协议到期时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '独家委托协议到期时间：',
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
                              initialDate: DateTime(1980),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedBirthdayDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              // if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
                              //   _onRefresh();
                                _finishPressed(context);
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
  _addDealAlertPressed(context) {
    Alert(
      context: context,
      title: "添加成交历史",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("成交原因：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            height: 120,
            margin: EdgeInsets.only(top: 18),
            child: WheelChooser(
              onValueChanged: (s){
                setState(() {
                  dealMinCount = s;
                });
              },
              datas: ["购买住宅", "购买商铺", "购买公寓", "购买车位","出售住宅", "出售商铺", "出售公寓", "出售车位","租赁住宅", "租赁商铺", "租赁公寓", "租赁车位","出租住宅", "出租商铺", "出租公寓", "出租车位",],
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
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("成交时间：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            width: 240,
            child: DatePickerWidget(
              looping: true, // default is not looping
              firstDate: DateTime(2000),
              lastDate: DateTime(2030, 1, 1),
              initialDate: DateTime(2020,1,1),
              dateFormat: "yyyy年-MMMM月-dd日",
              locale: DatePicker.localeFromString('zh'),
              onChange: (DateTime newDate, _) => _selectedDate = newDate,
              pickerTheme: DateTimePickerTheme(
                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                dividerColor: Color(0xFF5580EB),
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            setState(() {
              var d=new DealInfo(dealReason: dealMinCount,dealTime: _selectedDate);
              deal.add(d);
            });
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
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
        ),
      ],
    ).show();
  }
  _addNeedAlertPressed(context) {
    Alert(
      context: context,
      title: "添加学校信息",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("学校名称：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            height: 120,
            margin: EdgeInsets.only(top: 18),
            child: WheelChooser(
              onValueChanged: (s){
                setState(() {
                  needMinCount = s;
                });
              },
              datas: ["购买住宅", "购买商铺", "购买公寓", "购买车位","出售住宅", "出售商铺", "出售公寓", "出售车位","租赁住宅", "租赁商铺", "租赁公寓", "租赁车位","出租住宅", "出租商铺", "出租公寓", "出租车位",],
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
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            setState(() {
              var d=new NeedInfo(needReason: needMinCount);
              need.add(d);
            });
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
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
        ),
      ],
    ).show();
  }
  _finishPressed(context) {
    Alert(
      context: context,
      title: "配套与优势信息完善成功",
      desc: "是否继续完善业主隐私信息？",
      buttons: [
        DialogButton(
          child: Text(
            "去完善",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BuyNeedPage()));
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
}


