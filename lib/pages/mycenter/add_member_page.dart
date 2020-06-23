import 'dart:convert';

import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/mycenter/invitation_page.dart';
import 'package:ThumbSir/pages/mycenter/member_seach_result_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final TextEditingController areaController = TextEditingController();
  String area;
  RegExp areaReg;
  bool areaBool;
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;

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
    super.initState();
    _getUserInfo();
    areaReg = TextReg;
    phoneReg = telPhoneReg;
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
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                userData.userLevel.substring(0,1) == "6"?
                                '添加上级成员':'添加上下级成员',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                              ),),
                            )
                          ],
                        )
                    ),
                    //找下级输入手机号
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        '查找下级',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5580EB),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          Input(
                            hintText: "手机号码",
                            tipText: "请输入要查找的下级的手机号码",
                            errorTipText: "请输入要查找的下级的手机号码",
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
                          Positioned(
                              left: 300,
                              top: 18,
                              child: Container(
                                width: 25,
                                height: 25,
                                child: Image(image: AssetImage('images/search.png'),),
                              )
                          )
                        ],
                      ),
                    ),
                    // 搜索结果
                    Container(
                      width: 335,
                      padding: EdgeInsets.fromLTRB(10,0,15,0),
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberSeachResultPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(45)),
                                            color: Colors.white,
                                            border: Border.all(color: Color(0xFF93C0FB),width: 1)
                                        ),
                                        child:Image(
                                          image: AssetImage('images/my_big.png'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        width: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '马思维',
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF333333),
                                                    fontWeight: FontWeight.normal,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Image(image: AssetImage('images/vip_yellow.png'),),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                '18612345678',
                                                style:TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF999999),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('学院派物美店',style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    //找领导输入区域
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 50),
                      child: Text(
                        '查找上级',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5580EB),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 80,
                      child: Stack(
                          children: <Widget>[
                            Input(
                              hintText: "上级区域：如xxx大区、xxx店、xxx组",
                              errorTipText: "请输入要查找的上级的区域",
                              tipText: "请输入要查找的上级的区域",
                              rightText: "区域格式正确",
                              controller: areaController,
                              inputType: TextInputType.text,
                              reg: areaReg,
                              onChanged: (text){
                                setState(() {
                                  area = text;
                                  areaBool = areaReg.hasMatch(area);
                                });
                              },
                            ),
                            Positioned(
                                left: 300,
                                top: 18,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image(image: AssetImage('images/search.png'),),
                                )
                            )
                          ]
                      )
                    ),
                    // 搜索结果
                    Container(
                      width: 335,
                      padding: EdgeInsets.fromLTRB(10,0,15,0),
                      margin: EdgeInsets.only(top: 20,bottom: 30),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberSeachResultPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(45)),
                                            color: Colors.white,
                                            border: Border.all(color: Color(0xFF93C0FB),width: 1)
                                        ),
                                        child:Image(
                                          image: AssetImage('images/my_big.png'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        width: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '马思维',
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF333333),
                                                    fontWeight: FontWeight.normal,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Image(image: AssetImage('images/vip_yellow.png'),),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                '18612345678',
                                                style:TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF999999),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('学院派物美店',style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(45)),
                                          color: Colors.white,
                                          border: Border.all(color: Color(0xFF93C0FB),width: 1)
                                      ),
                                      child:Image(
                                        image: AssetImage('images/my_big.png'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '马思维1',
                                                style:TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF333333),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Image(image: AssetImage('images/vip_yellow.png'),),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              '18612345678',
                                              style:TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF999999),
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text('时代之光南门店',style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              )
            ],
          )
      ),
    );
  }
}
