import 'dart:convert';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_leader_and_team_member_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrokerCenterGroupPage extends StatefulWidget {
  @override
  _BrokerCenterGroupPageState createState() => _BrokerCenterGroupPageState();
}

class _BrokerCenterGroupPageState extends State<BrokerCenterGroupPage> {
  var leaderAndMemberResult;
  bool hasMember = false;

  bool _loading = false;

  LoginResultData userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  int exT;
  String uinfo;
  var result;

  List<Widget> brokers = [];

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      exT = result.exTokenTime.millisecondsSinceEpoch; // token时间转时间戳
      if(exT >= _dateTime){
        this.setState(() {
          userData=LoginResultData.fromJson(json.decode(uinfo));
        });
      }else{
        _onLogoutAlertPressed(context);
      }
    }
  }

  _load()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId= prefs.getString("userID");
    leaderAndMemberResult = await GetLeaderAndTeamMemberDao.getLeaderAndTeamMember(userId);
    if(leaderAndMemberResult != null){
      if(leaderAndMemberResult.code == 200){
        // 存储上级id
        prefs.setString('leaderID', leaderAndMemberResult.data.leader.userPid);
        setState(() {
          hasMember = true;
          _loading =false;
        });
      }else{
        setState(() {
          hasMember = false;
          _loading = false;
        });
      }
    }else{
      setState(() {
        hasMember = false;
        _loading = false;
      });
    }
  }

  // 经纪人列表
  Widget brokerItem(){
    Widget content;
    for(var item in leaderAndMemberResult.data.teamMember) {
      brokers.add(
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFCCCCCC),width: 1)
                    ),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image(
                        image: item.headImg != null?
                        NetworkImage(item.headImg)
                        :
                        AssetImage('images/my_big.png'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              leaderAndMemberResult.data.teamMember == null?'':item.userName,
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            leaderAndMemberResult.data.teamMember == null?Container(width: 1,):
                                item.isVip == false ? Container(width: 1,):
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Image(image: AssetImage('images/vip_yellow.png'),),
                            )
                          ],
                        ),
                        Container(
                          width: 200,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            leaderAndMemberResult.data.teamMember == null?'':item.phone,
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
            ],
          ),
        ),
      );
    };
    content =Column(
      children: brokers,
    );
    return content;
  }

  @override
  void initState() {
    _getUserInfo();
    _load();
    _onRefresh();
    super.initState();
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
                          padding: EdgeInsets.all(15),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Image(image: AssetImage('images/back.png'),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text('小组成员',style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF5580EB),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),),
                                  )
                                ],
                              ),
                              leaderAndMemberResult == null?
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMemberPage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF93C0FB),width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text('申请挂载上级',style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              )
                              :leaderAndMemberResult.code == 200 ?Container(width: 1,)
                              :GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMemberPage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF93C0FB),width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text('申请挂载上级',style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              )
                            ],
                          )
                      ),
                      // 店长
                      hasMember != false ?
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: <Widget>[
                                      // 店长头像
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(45)),
                                            color: Colors.white,
                                            border: Border.all(color: Color(0xFF24CC8E),width: 1)
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Image(
                                            image: leaderAndMemberResult.data.leader.headImg != null?
                                            NetworkImage(leaderAndMemberResult.data.leader.headImg)
                                            :
                                            AssetImage('images/my_big.png'),
                                          ),
                                        ),
                                      ),
                                      // 职位名称
                                      Container(
                                        padding: EdgeInsets.only(top: 60),
                                        width: 80,
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Color(0xFF24CC8E),width: 1),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top:2,left:5,right: 5),
                                            child: Text(
                                              leaderAndMemberResult.data.leader.userLevel != null?leaderAndMemberResult.data.leader.userLevel.substring(2,):'店长',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF24CC8E),
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  width: 200,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            leaderAndMemberResult.data== null?'':leaderAndMemberResult.data.leader.userName,
                                            style:TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          leaderAndMemberResult.data.leader.isVip== false?
                                          Container(width: 1,):
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Image(image: AssetImage('images/vip_yellow.png'),),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: 200,
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          leaderAndMemberResult.data== null?'':leaderAndMemberResult.data.leader.phone,
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
                          ],
                        ),
                      )
                      :
                      Container(
                          margin: EdgeInsets.only(top: 50),
                          width: 335,
                          height: 104,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(
                                  color: Color(0xFFcccccc),
                                  offset: Offset(0.0, 3.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0
                              )
                              ],
                              color: Colors.white
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 25,bottom: 8),
                                child: Text(
                                  '还没有同组成员',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    color: Color(0xFFCCCCCC),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                '挂载到同一上级下才能看到同级伙伴哦',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  color: Color(0xFFCCCCCC),
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                      ),
                      // 成员列表
                      hasMember != false && leaderAndMemberResult.data.teamMember != null?
                      brokerItem()
                      :
                      Container(width: 1,),
                    ]
                )
              ],
            )
        ),
    ));
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
  _onLogoutAlertPressed(context) {
    Alert(
      context: context,
      title: "需要重新登录",
      desc: "长时间未进行登录操作，需要重新登录验证",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("userInfo");
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home()
                ), (route) => route == null
            );
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
}


