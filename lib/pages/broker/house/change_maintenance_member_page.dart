import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_leader_info_dao.dart';
import 'package:ThumbSir/dao/get_user_by_phone_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../dao/change_maintenance_user_dao.dart';
import 'house_list_page.dart';
import 'house_upload_entrust_page.dart';

class ChangeMaintenanceMemberPage extends StatefulWidget {
  final houseId;
  ChangeMaintenanceMemberPage({Key? key,
    this.houseId
  }):super(key:key);
  @override
  _ChangeMaintenanceMemberPageState createState() => _ChangeMaintenanceMemberPageState();
}

class _ChangeMaintenanceMemberPageState extends State<ChangeMaintenanceMemberPage> {
  var phoneResult;
  var phoneResultData;
  var phoneShowState = 0;
  var areaResult;
  var areaResultData;
  var areaShowState = 0;

  final TextEditingController areaController = TextEditingController();
  late String area;
  late RegExp areaReg;
  bool areaBool = false;
  final TextEditingController phoneNumController=TextEditingController();
  late String phoneNum;
  late RegExp phoneReg;
  bool phoneBool = false;

  dynamic leaderInfo;

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
    if(userData != null){
      _loadLeader();
    }
  }

  _loadLeader()async{
    if(userData!.leaderId != null){
      var getLeaderResult = await GetLeaderInfoDao.httpGetLeaderInfo(
        userData!.leaderId,
        userData!.companyId,
      );
      if(getLeaderResult.code == 200){
        setState(() {
          leaderInfo = getLeaderResult.data!.leaderInfo;
        });
      }
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
                                '查找同事',
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

                    //输入手机号
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        '请输入新维护人的手机号码进行查询',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5580EB),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          Input(
                            hintText: "手机号码",
                            tipText: "请输入要查找的同事的手机号码",
                            errorTipText: "请输入要查找的同事的手机号码",
                            rightText: "手机号码格式正确",
                            controller: phoneNumController,
                            inputType: TextInputType.phone,
                            reg: phoneReg,
                            onChanged: (text){
                              setState(() {
                                phoneNum = text;
                                phoneBool = phoneReg.hasMatch(phoneNum);
                              });
                            }, password: false,
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
                              _onChooseMemberAlertPressed(context);
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
                                          child: phoneResultData.headImg != null?
                                          Image(
                                            image: NetworkImage(phoneResultData.headImg)
                                          ) :Image(image: AssetImage('images/my_big.png'),),
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
      title: "您确定要将房源维护人变更给TA吗？",
      desc: "确认变更后不可修改，请慎重选择",
      buttons: [
        DialogButton(
            child: Text(
              "确认",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              // 调用修改维护人接口
              var memberResult = await ChangeMaintenanceUserDao.changeMaintenanceUser(widget.houseId.toString(), phoneResultData.userPid);
              // 调用成功后返回200成功，跳转到列表页
              if(memberResult.code == 200){
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
              }
              //返回210弹出是否完善委托信息弹窗
              if(memberResult.code == 210){
                _onResult210AlertPressed(context);
              }
            },
            color: Color(0xFF5580EB)
        ),
        DialogButton(
          child: Text(
            "再想想",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){Navigator.pop(context);},
            color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onResult210AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "维护人已变更，但委托信息不完整",
      desc: "是否补充上传委托协议？",
      buttons: [
        DialogButton(
            child: Text(
              "去上传",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              // 跳转到上传委托协议和起始终止时间页面，成功后返回房源列表页
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseUploadEntrustPage(
                houseId: widget.houseId,
              )));
            },
            color: Color(0xFF5580EB)
        ),
        DialogButton(
          child: Text(
            "暂不上传",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            // 跳转到列表页
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
