import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/change_member_dao.dart';
import 'package:ThumbSir/dao/get_user_by_phone_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradedSearchPage extends StatefulWidget {
  final oldMemberId;
  TradedSearchPage({this.oldMemberId});
  @override
  _TradedSearchPageState createState() => _TradedSearchPageState();
}

class _TradedSearchPageState extends State<TradedSearchPage> {
  var phoneResult;
  var phoneResultData;
  var phoneShowState = 0;

  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;

  LoginResultData userData;
  String uinfo;
  var result;

  int star=1;

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
    phoneReg = TextReg;
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
                                '查找客户',
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
                    Container(
                      width: 350,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          Input(
                            hintText: "请输入客户姓名或手机号",
                            tipText: "请输入要查找的客户姓名或手机号",
                            errorTipText: "请输入要查找的客户姓名或手机号",
                            rightText: "请输入要查找的客户姓名或手机号",
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
                    ),
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
                                color: Colors.transparent,
                                border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 240,
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
                                              width: 240,
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
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          width: 20,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 3),
                                          child: star == 0 ?
                                          Image(image: AssetImage('images/star1_e.png'),
                                            fit: BoxFit.fill,) :
                                          Image(image: AssetImage('images/star1_big.png'),
                                            fit: BoxFit.fill,)
                                      ),
                                      Container(
                                          width: 20,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 3),
                                          child: star == 2 ?
                                          Image(image: AssetImage('images/star2_big.png'),
                                            fit: BoxFit.fill,)
                                              : star == 3 ?
                                          Image(image: AssetImage('images/star2_big.png'),
                                            fit: BoxFit.fill,)
                                              :
                                          Image(image: AssetImage('images/star2_e.png'),
                                            fit: BoxFit.fill,)
                                      ),
                                      Container(
                                          width: 20,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 3),
                                          child: star == 3 ?
                                          Image(image: AssetImage('images/star3_big.png'),
                                            fit: BoxFit.fill,)
                                              :
                                          Image(image: AssetImage('images/star3_e.png'),
                                            fit: BoxFit.fill,)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                  color: Colors.transparent,
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 240,
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
                                              width: 240,
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
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          width: 20,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 3),
                                          child: star == 0 ?
                                          Image(image: AssetImage('images/star1_e.png'),
                                            fit: BoxFit.fill,) :
                                          Image(image: AssetImage('images/star1_big.png'),
                                            fit: BoxFit.fill,)
                                      ),
                                      Container(
                                          width: 20,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 3),
                                          child: star == 2 ?
                                          Image(image: AssetImage('images/star2_big.png'),
                                            fit: BoxFit.fill,)
                                              : star == 3 ?
                                          Image(image: AssetImage('images/star2_big.png'),
                                            fit: BoxFit.fill,)
                                              :
                                          Image(image: AssetImage('images/star2_e.png'),
                                            fit: BoxFit.fill,)
                                      ),
                                      Container(
                                          width: 20,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 3),
                                          child: star == 3 ?
                                          Image(image: AssetImage('images/star3_big.png'),
                                            fit: BoxFit.fill,)
                                              :
                                          Image(image: AssetImage('images/star3_e.png'),
                                            fit: BoxFit.fill,)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    :phoneShowState == 2 ?
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                      child: Text(
                        '未查询到姓名或手机号为未查询到姓名或手机号为'+phoneNumController.text+'的用户',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                        :Container(width: 1,)
                  ]
              )
            ],
          )
      ),
    );
  }

  _onChooseMemberAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "添加对方成为下级",
      desc: "是否由他替换该职位？",
      buttons: [
        DialogButton(
            child: Text(
              "确定",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              // 替换成员
              var changeResult = await ChangeMemberDao.changeMember(widget.oldMemberId, phoneResultData.userPid);
              if(changeResult.code == 200){
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(builder: (context) => new Home( )
                    ), (route) => route == null);
              }else{
                _onResult420AlertPressed(context);
              }
            },
            color: Color(0xFF5580EB)
        ),
        DialogButton(
          child: Text(
            "取消",
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
  _onResult420AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "更换成员失败",
      desc: "请检查网络情况，稍后重试。",
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
