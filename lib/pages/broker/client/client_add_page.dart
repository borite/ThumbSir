import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/add_new_customer_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/buy_need_page.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'my_client_page.dart';

class ClientAddPage extends StatefulWidget {
  @override
  _ClientAddPageState createState() => _ClientAddPageState();
}

class _ClientAddPageState extends State<ClientAddPage> {
  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  ScrollController _memberScrollController = ScrollController();
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

  List<DealInfo> deal=new List();
  List<BuySellNeedInfo> need=new List();
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
                                        child: Text('新增客户',style: TextStyle(
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
                          // 客户姓名
                          Container(
                            width: 335,
                            child: Text(
                              '客户姓名：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入客户姓名",
                            tipText: "请输入客户姓名",
                            errorTipText: "请输入客户姓名",
                            rightText: "请输入客户姓名",
                            controller: userNameController,
                            inputType: TextInputType.text,
                            reg: nameReg,
                            onChanged: (text){
                              setState(() {
                                userName = text;
                                userNameBool = nameReg.hasMatch(userName);
                              });
                            },
                          ),

                          // 需求
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '需求（必填）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemCount: need.length,
                              controller: _needScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 2, 10, 4),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              child: Text(
                                                need[index].buySellNeedReason,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                need.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 20,
                                                color:Colors.transparent,
                                                child: Image(image: AssetImage("images/delete_blue.png"),),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                );
                              },

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
                                  "+ 添加客户需求",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 成交历史
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '成交历史（非必填）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemCount: deal.length,
                              controller: _dealScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                               return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 2, 10, 4),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                              ),
                                              child: Text(
                                                deal[index].dealReason,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(8, 1, 10, 3),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xFF5580EB),
                                                  )
                                              ),
                                              child: Text(
                                                "时间："+deal[index].dealTime.toIso8601String().substring(0,10),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF5580EB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                deal.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 20,
                                                color:Colors.transparent,
                                                child: Image(image: AssetImage("images/delete_blue.png"),),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                );
                              },
                              
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addDealAlertPressed(context);
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
                                  "+ 添加成交历史",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 客户来源
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '客户来源：',
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
                              datas: ["社区开发", "店面接待", "电话开发", "老客户转介绍","其他"],
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

                          // 重要度
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '重要度：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _starIndex=1;
                                          });
                                        },
                                        child: Container(
                                            width: 39,
                                            height: 25,
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
                                            width: 39,
                                            height: 25,
                                            padding: EdgeInsets.only(right: 15),
                                            child: _starIndex==2 ?
                                            Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                                :_starIndex==3 ?
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
                                            width: 39,
                                            height: 25,
                                            padding: EdgeInsets.only(right: 15),
                                            child: _starIndex==3 ?
                                            Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                                :
                                            Image(image: AssetImage('images/star3_e.png'),fit: BoxFit.fill,)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 客户手机号
                          Container(
                            width: 335,
                            child: Text(
                              '客户手机号码：',
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
                            tipText: "请输入客户的手机号码",
                            errorTipText: "请输入格式正确的手机号码",
                            rightText: "手机号码格式正确",
                            controller: phoneNumController,
                            inputType: TextInputType.phone,
                            reg: phoneReg,
                            onChanged: (text){
                              setState(() {
                                phoneNum = text;
                                phoneBool = phoneReg.hasMatch(phoneNum);
                              });
                            },
                          ),
                          // 客户生日
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 25),
                            child: Text(
                              '客户生日：',
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
                          // 客户性别
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '客户性别：',
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
                                  onChanged: _handleRadioValueChanged,
                                  title: Text('男'),
                                  selected: _radioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged,
                                  title: Text('女'),
                                  selected: _radioGroupA == 1,
                                ),
                              ],
                            ),
                          ),
                          // 客户职业
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '客户职业（非必填）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入客户的职业",
                            tipText: "请输入客户的职业",
                            errorTipText: "请输入客户的职业",
                            rightText: "请输入客户的职业",
                            controller: careerController,
                            inputType: TextInputType.text,
                            reg: careerReg,
                            onChanged: (text){
                              setState(() {
                                career = text;
                                careerBool = careerReg.hasMatch(career);
                              });
                            },
                          ),
                          // 客户年收入
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '客户年收入：',
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
                                  incomeMinCount = s;
                                });
                              },
                              datas: ["10万以下", "10万-30万", "30万-50万", "50万-100万","100万-500万", "500万-1000万", "1000万以上","未知"],
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
                          // 客户住址
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '客户住址（非必填）：',
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
                                hintText:'请填写客户的常用住址，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // 客户爱好
                          Container(
                            width: 335,
                            child: Text(
                              '客户爱好（非必填）：',
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
                              controller: likeController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onLikeChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写客户的爱好，提供选择维护礼物的灵感',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // 客户描述
                          Container(
                            width: 335,
                            child: Text(
                              '客户描述（非必填）：',
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
                                hintText:'请填写描述，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // 家庭成员
                          Container(
                            width: 335,
                            child: Text(
                              '客户的家庭成员（非必填）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemCount: member.length,
                              controller: _memberScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                                              decoration: BoxDecoration(
                                                border: Border(right: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFCCCCCC),
                                                ))
                                              ),
                                              child: Text(
                                                member[index].memberRole,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF5580EB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              width: 210,
                                              padding: EdgeInsets.fromLTRB(20, 0, 10, 3),
                                              child: Text(
                                                member[index].memberHobby,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF5580EB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                member.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 20,
                                                color:Colors.transparent,
                                                child: Image(image: AssetImage("images/delete_blue.png"),),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                );
                              },

                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addMemberAlertPressed(context);
                              setState(() {
                                memberController.text = "";
                              });
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: 335,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xFF93C0FB)
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "+ 添加家庭成员",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              if(userNameBool == true && phoneBool == true && _starIndex != 0 && need.length!=0 ){
                                _onRefresh();
                                // _finishPressed(context);
                                var addResult = await AddNewCustomerDao.addNewCustomer(
                                    userData.companyId,
                                    userData.userPid,
                                    "5",
                                    userNameController.text,
                                    _radioGroupA.toString(),
                                    phoneNumController.text,
                                    _selectedBirthdayDate.toIso8601String(),
                                    _starIndex.toString(),
                                    careerController.text==null?"未知":careerController.text,
                                    incomeMinCount,
                                    likeController.text==null?"未知":likeController.text,
                                    msgController.text==null?"未知":msgController.text,
                                    mapController.text==null?"未知":mapController.text,
                                    comeMinCount,
                                    member,  // 家庭成员
                                    deal,  // 成交历史
                                    need,  // 需求信息
                                );
                                print(addResult);
                                if (addResult.code == 200) {
                                  _onRefresh();
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
                                } else {
                                  _onRefresh();
                                  _onOverLoadPressed(context);
                                }
                              }else{
                                // 必填信息不完整的弹窗
                                _onMsgPressed(context);
                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration: phoneBool == true &&
                                    userNameBool == true && _starIndex != 0 && need.length!=0?
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
      title: "添加客户需求",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("需求类型：",style: TextStyle(
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
              var d=new BuySellNeedInfo(buySellNeedReason: needMinCount);
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
  _addMemberAlertPressed(context) {
    Alert(
      context: context,
      title: "添加家庭成员",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("选择成员：",style: TextStyle(
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
                  memberMinCount = s;
                });
              },
              datas: ["妻子", "丈夫","儿子", "女儿", "父亲", "母亲","哥哥", "姐姐","弟弟", "妹妹", "宠物","其他"],
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
                child: Text("家庭成员的描述：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
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
              controller: memberController,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              onChanged: _onMemberChanged,
              maxLines: null,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                hintText:'爱好、习惯等……',
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
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
              var m=new FamilyMember(memberRole: memberMinCount,memberHobby: memberController.text);
              member.add(m);
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


