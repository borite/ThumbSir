import 'dart:convert';
import 'package:ThumbSir/dao/add_house_step3_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/house/house_add_owner_msg_page.dart';
import 'package:ThumbSir/pages/house/house_list_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';

import 'house_edit_around_msg_page.dart';

class HouseAddAroundMsgPage extends StatefulWidget {
  final houseId;
  HouseAddAroundMsgPage({Key key,
    this.houseId
  }):super(key:key);
  @override
  _HouseAddAroundMsgPageState createState() => _HouseAddAroundMsgPageState();
}

class _HouseAddAroundMsgPageState extends State<HouseAddAroundMsgPage> {
  bool _loading = false;
  List missionContent=new List();
  String select="";
  int itemLength = 0;

  ScrollController _schoolScrollController = ScrollController();
  ScrollController _trafficScrollController = ScrollController();
  ScrollController _amuseScrollController = ScrollController();
  ScrollController _hospitalScrollController = ScrollController();
  ScrollController _bankScrollController = ScrollController();
  ScrollController _parkScrollController = ScrollController();

  final TextEditingController schoolNameController = TextEditingController();
  String schoolName;
  final TextEditingController schoolDistanceController = TextEditingController();
  String schoolDistance;
  final TextEditingController trafficNameController = TextEditingController();
  String trafficName;
  final TextEditingController trafficDistanceController = TextEditingController();
  String trafficDistance;
  final TextEditingController hospitalNameController = TextEditingController();
  String hospitalName;
  final TextEditingController hospitalDistanceController = TextEditingController();
  String hospitalDistance;
  final TextEditingController parkNameController = TextEditingController();
  String parkName;
  final TextEditingController parkDistanceController = TextEditingController();
  String parkDistance;
  final TextEditingController amuseNameController = TextEditingController();
  String amuseName;
  final TextEditingController amuseDistanceController = TextEditingController();
  String amuseDistance;
  final TextEditingController bankNameController = TextEditingController();
  String bankName;
  final TextEditingController bankDistanceController = TextEditingController();
  String bankDistance;
  final TextEditingController mapController = TextEditingController();
  String map;

  List<AroundInfo> school=new List();
  List<AroundInfo> traffic=new List();
  List<AroundInfo> hospital=new List();
  List<AroundInfo> park=new List();
  List<AroundInfo> bank=new List();
  List<AroundInfo> amuse=new List();

  int _radioGroupA = 0;

  List<String> tags = [];
  List<String> special = [];

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
    _getUserInfo();
    special = ["安静","带车位","带小院","停车方便","绿化率高","容积率低","小区面积大","人车分流","视野好"];
    super.initState();
  }

  @override
  void dispose(){
    _schoolScrollController.dispose();
    schoolNameController.dispose();
    schoolDistanceController.dispose();
    _trafficScrollController.dispose();
    trafficNameController.dispose();
    trafficDistanceController.dispose();
    _amuseScrollController.dispose();
    amuseNameController.dispose();
    amuseDistanceController.dispose();
    _bankScrollController.dispose();
    bankNameController.dispose();
    bankDistanceController.dispose();
    _parkScrollController.dispose();
    parkNameController.dispose();
    parkDistanceController.dispose();
    _hospitalScrollController.dispose();
    hospitalNameController.dispose();
    hospitalDistanceController.dispose();
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
                                        child: Text('完善房源配套与优势信息',style: TextStyle(
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

                          // 学校信息
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '学校信息：',
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
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged,
                                  title: Text('是学区房'),
                                  selected: _radioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged,
                                  title: Text('不是学区房'),
                                  selected: _radioGroupA == 1,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemCount: school.length,
                              controller: _schoolScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 4, 10, 6),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)
                                                ),
                                              ),
                                              child: Text(
                                                school[index].name,
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
                                                "步行距离："+school[index].distance+"米",
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
                                                school.removeAt(index);
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
                              _addSchoolMsgAlertPressed(context);
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
                                  "+ 添加学校信息",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 交通信息
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '交通信息：',
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
                              itemCount: traffic.length,
                              controller: _trafficScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 4, 10, 6),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                              ),
                                              child: Text(
                                                traffic[index].name,
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
                                                "步行距离："+traffic[index].distance+"米",
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
                                                traffic.removeAt(index);
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
                              _addTrafficMsgAlertPressed(context);
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
                                  "+ 添加交通信息",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 娱乐信息
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '娱乐信息：',
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
                              itemCount: amuse.length,
                              controller: _amuseScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 4, 10, 6),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                              ),
                                              child: Text(
                                                amuse[index].name,
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
                                                "步行距离："+amuse[index].distance,
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
                                                amuse.removeAt(index);
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
                              _addAmuseMsgAlertPressed(context);
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
                                  "+ 添加娱乐信息",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 医院信息
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '医院信息：',
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
                              itemCount: hospital.length,
                              controller: _hospitalScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 4, 10, 6),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                              ),
                                              child: Text(
                                                hospital[index].name,
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
                                                "步行距离："+hospital[index].distance+"米",
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
                                                hospital.removeAt(index);
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
                              _addHospitalMsgAlertPressed(context);
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
                                  "+ 添加医院信息",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 银行信息
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '银行信息：',
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
                              itemCount: bank.length,
                              controller: _bankScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 4, 10, 6),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                              ),
                                              child: Text(
                                                bank[index].name,
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
                                                "步行距离："+bank[index].distance+"米",
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
                                                bank.removeAt(index);
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
                              _addBankMsgAlertPressed(context);
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
                                  "+ 添加银行信息",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 公园信息
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '公园信息：',
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
                              itemCount: park.length,
                              controller: _parkScrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10, 4, 10, 6),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF5580EB),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                              ),
                                              child: Text(
                                                park[index].name,
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
                                                "步行距离："+park[index].distance+"米",
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
                                                park.removeAt(index);
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
                              _addParkMsgAlertPressed(context);
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
                                  "+ 添加公园信息",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 优势信息
                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '优势信息：',
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
                                    if (value.length > 9) {
                                      return "选择不可多于9项";
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
                                                  source: special,
                                                  // 存储形式
                                                  value:(index,item)=>item,
                                                  // 展示形式
                                                  label: (index,item)=>item
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                select="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  select+=item + ',';
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
                                                state.errorText ?? state.value.length.toString() + '/9 可选',
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

                          // 其他优势
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '优势补充：',
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
                              // onChanged: _onMapChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写补充优势，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                                _finishPressed(context);
                                _onRefresh();
                                // _otherNeedPressed(context);
                                var addResult = await AddHouseStep3Dao
                                    .addHouseStep3(
                                    widget.houseId,
                                    _radioGroupA==0?true:false,
                                    json.encode(school),
                                    json.encode(traffic),
                                    json.encode(amuse),
                                    json.encode(hospital),
                                    json.encode(bank),
                                    json.encode(park),
                                    select,
                                    mapController.text
                                );
                                print(addResult);
                                if (addResult.code == 200 ||
                                    addResult.code == 201) {
                                  _onRefresh();
                                  _finishPressed(context);
                                } else {
                                  _onRefresh();
                                  _onOverLoadPressed(context);
                                  // }
                                  // }else{
                                  //   // 必填信息不完整的弹窗
                                  //   _onMsgPressed(context);
                                  // }
                                };
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
  _addSchoolMsgAlertPressed(context) {
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
              width: 120,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
              ),
              child: TextField(
                controller: schoolNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("步行距离：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: schoolDistanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("米",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          )

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(schoolNameController.text!=null && schoolNameController.text !=null
                && schoolDistanceController.text !=null && schoolDistanceController.text!=""){
              setState(() {
                schoolName = schoolNameController.text;
                schoolDistance = schoolDistanceController.text;
                var d=new AroundInfo(name: schoolName,distance: schoolDistance);
                school.add(d);
                schoolNameController.text = "";
                schoolDistanceController.text = "";
              });
              Navigator.pop(context);
            }else{
              _onMsgPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            schoolNameController.text = "";
            schoolDistanceController.text = "";
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _addTrafficMsgAlertPressed(context) {
    Alert(
      context: context,
      title: "添加交通信息",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("交通站名：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("如：地铁2、4、13号线西直门站",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 2),
                child: Text("或公交332、632、651路西直门站",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
              width: 200,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
              ),
              child: TextField(
                controller: trafficNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("步行距离：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: trafficDistanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("米",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          )

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(trafficNameController.text!=null && trafficNameController.text !=null
                && trafficDistanceController.text !=null && trafficDistanceController.text!=""){
              setState(() {
                trafficName = trafficNameController.text;
                trafficDistance = trafficDistanceController.text;
                var d=new AroundInfo(name: trafficName,distance: trafficDistance);
                traffic.add(d);
                trafficNameController.text = "";
                trafficDistanceController.text = "";
              });
              Navigator.pop(context);
            }else{
              _onMsgPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            trafficNameController.text = "";
            trafficDistanceController.text = "";
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _addAmuseMsgAlertPressed(context) {
    Alert(
      context: context,
      title: "添加娱乐信息",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("商场或场所名称：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
              ),
              child: TextField(
                controller: amuseNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("步行距离：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: amuseDistanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("米",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          )

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(amuseNameController.text!=null && amuseNameController.text !=null
                && amuseDistanceController.text !=null && amuseDistanceController.text!=""){
              setState(() {
                amuseName = amuseNameController.text;
                amuseDistance = amuseDistanceController.text;
                var d=new AroundInfo(name: amuseName,distance: amuseDistance);
                amuse.add(d);
                amuseNameController.text = "";
                amuseDistanceController.text = "";
              });
              Navigator.pop(context);
            }else{
              _onMsgPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            amuseNameController.text = "";
            amuseDistanceController.text = "";
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _addParkMsgAlertPressed(context) {
    Alert(
      context: context,
      title: "添加公园信息",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("公园名称：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
              ),
              child: TextField(
                controller: parkNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("步行距离：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: parkDistanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("米",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          )

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(parkNameController.text!=null && parkNameController.text !=null
                && parkDistanceController.text !=null && parkDistanceController.text!=""){
              setState(() {
                parkName = parkNameController.text;
                parkDistance = parkDistanceController.text;
                var d=new AroundInfo(name: parkName,distance: parkDistance);
                park.add(d);
                parkNameController.text = "";
                parkDistanceController.text = "";
              });
              Navigator.pop(context);
            }else{
              _onMsgPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            parkNameController.text = "";
            parkDistanceController.text = "";
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _addBankMsgAlertPressed(context) {
    Alert(
      context: context,
      title: "添加银行信息",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("银行名称：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
              ),
              child: TextField(
                controller: bankNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("步行距离：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: bankDistanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("米",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          )

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(bankNameController.text!=null && bankNameController.text !=null
                && bankDistanceController.text !=null && bankDistanceController.text!=""){
              setState(() {
                bankName = bankNameController.text;
                bankDistance = bankDistanceController.text;
                var d=new AroundInfo(name: bankName,distance: bankDistance);
                bank.add(d);
                bankNameController.text = "";
                bankDistanceController.text = "";
              });
              Navigator.pop(context);
            }else{
              _onMsgPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            bankNameController.text = "";
            bankDistanceController.text = "";
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _addHospitalMsgAlertPressed(context) {
    Alert(
      context: context,
      title: "添加医院信息",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("医院名称：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
              ),
              child: TextField(
                controller: hospitalNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              )
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("步行距离：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: hospitalDistanceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("米",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          )

        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(hospitalNameController.text!=null && hospitalNameController.text !=null
                && hospitalDistanceController.text !=null && hospitalDistanceController.text!=""){
              setState(() {
                hospitalName = hospitalNameController.text;
                hospitalDistance = hospitalDistanceController.text;
                var d=new AroundInfo(name: hospitalName,distance: hospitalDistance);
                hospital.add(d);
                hospitalNameController.text = "";
                hospitalDistanceController.text = "";
              });
              Navigator.pop(context);
            }else{
              _onMsgPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            hospitalNameController.text = "";
            hospitalDistanceController.text = "";
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
      title: "必填信息未填写完整",
      desc: "名称与距离同时填写才可提交",
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
                builder: (context) => HouseAddOwnerMsgPage()));
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
                  builder: (context) => HouseListPage()));
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
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}


