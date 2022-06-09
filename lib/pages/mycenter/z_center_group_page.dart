import 'dart:convert';
import 'package:ThumbSir/dao/get_next_level_users_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/pages/mycenter/z_center_group_detail_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ZCenterGroupPage extends StatefulWidget {
  @override
  _ZCenterGroupPageState createState() => _ZCenterGroupPageState();
}

class _ZCenterGroupPageState extends State<ZCenterGroupPage> {
  var getNextLevelUsersResult;
  bool hasMember = false;
  var membersResult;
  List<Widget> members = [];
  bool _loading = false;

  LoginResultData? userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  late int exT;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    dynamic result =loginResultDataFromJson(uInfo);
    exT = result.exTokenTime.millisecondsSinceEpoch; // token时间转时间戳
    if(exT >= _dateTime){
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uInfo));
      });
    }else{
      _onLogoutAlertPressed(context);
    }
  }

  _load()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId= prefs.getString("userID");
      getNextLevelUsersResult = await GetNextLevelUsersDao.getNextLevelUsers(userId!);
    if(getNextLevelUsersResult != null){
      if(getNextLevelUsersResult.code == 200){
        setState(() {
          _loading =false;
          membersResult = getNextLevelUsersResult.data;
        });
        if( getNextLevelUsersResult.data.length != 0){
          hasMember = true;
        }
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

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _load();
    _onRefresh();
  }

  // 下级成员列表
  Widget memberItem(){
    Widget content;
    if(membersResult != null){
      for(var item in membersResult) {
        members.add(
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ZCenterGroupDetailPage(
                myMsg : item,
              )));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.only(right: 15),
              width: 335,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(
                    color: Color(0xFFcccccc),
                    offset: Offset(0.0, 3.0),
                    blurRadius: 10.0,
                    spreadRadius: 2.0
                )],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          color: Color(0xFF93C0FB),
                          border: Border.all(color: Color(0xFFCCCCCC),width: 1),
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            (members.length+1).toString(),
                            style:TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 200,
                        child: Text(
                          getNextLevelUsersResult.data == null?'':item.section+'（ '+item.userName+' ）',
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image(image: AssetImage('images/next.png'),)
                ],
              ),
            ),
          ),
        );
      }
    }

    content =Column(
      children: members,
    );
    return content;
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
                                    child: Text(
                                      userData != null && userData!.userLevel.substring(0,1) == '1'?
                                      '添加下级成员':'添加上下级成员',
                                      style: TextStyle(
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
                        // 头像
                        Stack(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment(-1,-1),
                                  margin: EdgeInsets.only(top: 8,left: 35),
                                  child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(45)),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(
                                            color: Color(0xFFcccccc),
                                            offset: Offset(0.0, 3.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0
                                        )],
                                      ),
                                      child:ClipRRect(
                                        borderRadius: BorderRadius.circular(45),
                                        child:userData != null && userData!.headImg != null ?
                                        Image(image:NetworkImage(userData!.headImg))
                                            :
                                        Image(image: AssetImage('images/my_big.png'),),
                                      )
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 25,right: 15,top: 5),
                                          child: Text(
                                            userData!= null?userData!.userName:'',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.normal,
                                            ),),
                                        ),
                                        userData!= null && userData!.userIsVip == true?
                                        Container(
                                          width: 22,
                                          margin: EdgeInsets.only(top: 5),
                                          child: Image(image: AssetImage('images/vip_yellow.png'),),
                                        )
                                            :Container(width: 1,)
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 12,left: 25),
                                      child: Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: userData != null && userData!.userLevel.substring(0,1) == '3'?
                                                Color(0xFF9149EC) // 总监紫色
                                                    :userData != null && userData!.userLevel.substring(0,1) == '2'?
                                                Color(0xFF7412F2) // 副总深紫
                                                    :
                                                Color(0xFF003273),// 总经理深蓝
                                                width: 1),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(top:2,left:5,right: 5),
                                          child: Text(
                                            userData!= null?userData!.userLevel.substring(2,):'',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: userData != null && userData!.userLevel.substring(0,1) == '3'?
                                              Color(0xFF9149EC) // 总监紫色
                                                  :userData != null && userData!.userLevel.substring(0,1) == '2'?
                                              Color(0xFF7412F2) // 副总深紫
                                                  :
                                              Color(0xFF003273),// 总经理深蓝
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        // 成员列表
                        hasMember != false ?
                        Padding(
                          padding: EdgeInsets.only(top: 50,bottom: 40),
                          child: memberItem(),
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
                                    '还没有下级成员',
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
                                  '点击右上角与成员建立联接吧',
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
                      ]
                  )
                ],
              )
          )
        )
    );
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
