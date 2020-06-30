import 'dart:convert';

import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_leader_dao.dart';
import 'package:ThumbSir/dao/add_team_member_dao.dart';
import 'package:ThumbSir/dao/get_leader_dao.dart';
import 'package:ThumbSir/dao/get_user_by_phone_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/mycenter/invitation_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  var phoneResult;
  var phoneResultData;
  var phoneShowState = 0;
  var areaResult;
  var areaResultData;
  var areaShowState = 0;

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
                                userData != null && userData.userLevel.substring(0,1) == "6"?
                                '添加上级成员'
                                :userData != null && userData.userLevel.substring(0,1) == "1"?
                                '添加下级成员'
                                :'添加上下级成员',
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

                    userData != null &&userData.userLevel.substring(0,1) != '6'?
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
                    )
                    :Container(height: 1,),
                    userData != null &&userData.userLevel.substring(0,1) != '6'?
                    Container(
                      width: 350,
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
                              child: GestureDetector(
                                onTap: ()async{
                                  if(phoneBool == true){
                                    phoneResult = await GetUserByPhoneDao.getUserByPhone(phoneNumController.text);
                                    if(phoneResult != null){
                                      if(phoneResult.code == 200){
                                        setState(() {
                                          phoneResultData = phoneResult.data;
                                          phoneShowState = 1;
                                        });
                                      }else if(phoneResult.code == 404){
                                        setState(() {
                                          phoneShowState = 2;
                                        });
                                      }
                                    }
                                  }else{}
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image(image: AssetImage('images/search.png'),),
                                ),
                              )
                          )
                        ],
                      ),
                    )
                    :Container(height: 1,),
                    // 搜索结果
                    phoneShowState == 1 ?
                    Container(
                      width: 335,
                      padding: EdgeInsets.fromLTRB(10,0,15,0),
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              if(int.parse(userData.userLevel.substring(0,1))+1 == int.parse(phoneResultData.userLevel.substring(0,1))){
                                _onChooseMemberAlertPressed(context);
                              }else{
                                _onChooseMemberLevelAlertPressed(context);
                              }
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
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image(
                                            image:phoneResultData.headImg != null?
                                            NetworkImage(phoneResultData.headImg)
                                                :
                                            AssetImage('images/my_big.png'),
                                          ),
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
                                                  phoneResultData.userName,
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF333333),
                                                    fontWeight: FontWeight.normal,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                phoneResultData.phone,
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
                                  Text(
                                    phoneResultData.userLevel.substring(2,),
                                    style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    :phoneShowState == 2?
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        '未查询到注册手机号为'+phoneNumController.text+'的用户',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                    :Container(width: 335,),

                    //找领导输入区域
                    userData != null && userData.userLevel.substring(0,1) != '1' && userData.leaderId == null?
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
                    )
                    :Container(height: 1,),
                    userData != null &&userData.userLevel.substring(0,1) != '1' && userData.leaderId == null?
                    Container(
                      width: 350,
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
                                child: GestureDetector(
                                  onTap: ()async{
                                    if(areaBool == true){
                                      areaResult = await GetLeaderDao.httpGetLeader(userData.companyId, areaController.text, (int.parse(userData.userLevel.substring(0,1))-1).toString());
                                      if(areaResult != null){
                                        if(areaResult.code == 200){
                                          setState(() {
                                            areaResultData = areaResult.data;
                                            areaShowState = 1;
                                          });
                                        }else{
                                          setState(() {
                                            areaShowState = 2;
                                          });
                                        }
                                      }
                                    }else{}
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    child: Image(image: AssetImage('images/search.png'),),
                                  ),
                                )
                            )
                          ]
                      )
                    )
                    :Container(height: 1,),
                    // 搜索结果
                    areaShowState == 1 ?
                    Container(
                      width: 335,
                      padding: EdgeInsets.fromLTRB(10,0,15,0),
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              _onChooseLeaderAlertPressed(context);
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
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image(
                                            image:areaResultData.headImg != null?
                                            NetworkImage(areaResultData.headImg)
                                                :
                                            AssetImage('images/my_big.png'),
                                          ),
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
                                                  areaResultData.userName,
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF333333),
                                                    fontWeight: FontWeight.normal,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                areaResultData.phone,
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
                                  Text(
                                    areaResultData.userLevel.substring(2,),
                                    style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    :areaShowState == 2?
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '未查询到区域为'+areaController.text+'的上级用户',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          width: 335,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            '请确认您与对方是否为同一公司、对方是否为您的上一层级以及填写的区域名是否准确。',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    )
                    :Container(width: 335,),
                  ]
              )
            ],
          )
      ),
    );
  }
  _onChooseLeaderAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "申请挂载上级",
      desc: "是否申请成为TA的下级，来建立上下级关系？",
      buttons: [
        DialogButton(
            child: Text(
              "申请",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              // 申请挂载上级
              var leaderResult = await AddLeaderDao.addLeaderPost(userData.userPid, areaResultData.userPid);
              if(leaderResult.code == 200){
                _onLeaderResult200AlertPressed(context);
              }else if(leaderResult.code == 410){
                _onResult410AlertPressed(context);
              }else{
                _onLeaderResult400AlertPressed(context);
              }
            },
            color: Color(0xFF5580EB)
        ),
        DialogButton(
          child: Text(
            "不申请",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){Navigator.pop(context);},
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onChooseMemberAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "添加对方成为下级",
      desc: "是否向TA发送职位联接邀请，来建立上下级关系？",
      buttons: [
        DialogButton(
            child: Text(
              "发送",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              // 申请挂载上级
              var memberResult = await AddTeamMemberDao.addMemberPost(userData.userPid, phoneResultData.userPid);
              if(memberResult.code == 200){
                _onMemberResult200AlertPressed(context);
              }
              if(memberResult.code == 420){
                _onResult420AlertPressed(context);
              }
              if(memberResult.code == 410){
                _onResult410AlertPressed(context);
              }
            },
            color: Color(0xFF5580EB)
        ),
        DialogButton(
          child: Text(
            "不发送",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){Navigator.pop(context);},
            color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onChooseMemberLevelAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "无法添加TA为下级",
      desc: "对方的职级须比您低一级才能添加，如果是职位调动造成此结果，请对方在个人中心修改职级信息",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.pop(context);},
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
  _onLeaderResult200AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "挂载求情已发送",
      desc: "对方的消息中心会收到您的申请，请提醒对方查看，待对方同意后即可建立联接",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
  _onMemberResult200AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "联接邀请已发送",
      desc: "对方的消息中心会收到您的邀请，请提醒对方查看，待对方同意后即可建立联接",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
  _onLeaderResult400AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "联接邀请发送失败",
      desc: "请检查网络连接情况，稍后重试",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
  _onResult410AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "联接邀请发送失败",
      desc: "您已给对方发送过上下级联接请求，请提醒对方查看消息中心。",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
  _onResult420AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "联接邀请发送失败",
      desc: "对方已经与您建立了上下级联接，请在个人中心的成员列表查看。",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
}
