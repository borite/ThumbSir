import 'dart:convert';
import 'package:ThumbSir/dao/get_last_level_customer_num_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/manager/traded/team_traded_member_page.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupHousePage extends StatefulWidget {
  @override
  _GroupHousePageState createState() => _GroupHousePageState();
}

class _GroupHousePageState extends State<GroupHousePage> {
  var leaderResult;
  bool _loading = false;
  var listResult;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];
  List<Widget> msgs=[];

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
    if(userData != null){
      _load();
    }else{
      setState(() {
        _loading =false;
      });
    }
  }

  _load()async{
    dynamic getMemberListResult = await GetLastLevelCustomerNumDao.httpGetLastLevelCustomerNum(
        userData!.userPid,
        userData!.companyId,
    );
    if(getMemberListResult != null){
      if(getMemberListResult.code == 200){
          _loading =false;
          leaderResult = getMemberListResult.data!.zong;
          listResult = getMemberListResult.data!.list;
          if (listResult.length>0) {
            for(var item in listResult) {
              showList.add(
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamTradedMemberPage(
                      userId: item.userPid,
                      userLevel: item.userLevel,
                      userName: item.userName,
                    )));
                  },
                  child: Container(
                    width: 335,
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                    color: Colors.transparent,
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
                                  border: Border.all(color: Color(0xFF93C0FB),width: 1)
                              ),
                              child:ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child:item.headImg != null ?
                                  Image(
                                    image: NetworkImage(item.headImg)
                                  ):Image(image: AssetImage('images/my_big.png'),)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 150,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        item.userName,
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
                                    width: 150,
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      item.customerCount != null ?
                                      '个人拥有客户数：'+item.customerCount.toString()
                                          :'个人拥有客户数：0',
                                      style:TextStyle(
                                        fontSize: 12,
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
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Image(image: AssetImage('images/next.png'),),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          setState(() {
            msgs=showList;
          });
        if(listResult.length>0){
          setState(() {
            hasMember = true;
          });
        }
      }else{
        setState(() {
          hasMember = false;
        });
      }
    }else{
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _getUserInfo();
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      padding: EdgeInsets.only(left: 15,top: 5,bottom: 10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // 题目
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushAndRemoveUntil(
                                      new MaterialPageRoute(builder: (context) => new Home( )
                                      ), (route) => route == null);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: 26,
                                  padding: EdgeInsets.only(top: 3),
                                  child: Image(image: AssetImage('images/home.png'),),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('团队房源',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                          // 消息提醒和个人中心按钮
                          Row(
                            children: <Widget>[
                              Container(
                                width: 28,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                  },
                                  child: ClipOval(
                                    child: Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          border:Border.all(color: Color(0xFF0E7AE6),width: 1),
                                          borderRadius: BorderRadius.circular(13),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          child:Image(
                                            width: 26,
                                            height:26,
                                            image: AssetImage('images/bell.png'),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20,left: 25),
                                width: 28,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                                  },
                                  child: ClipOval(
                                    child: Container(
                                        width: 26,
                                        decoration: BoxDecoration(
                                          border:Border.all(color: Color(0xFF0E7AE6),width: 1),
                                          borderRadius: BorderRadius.circular(13),
                                          color: Colors.white,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          child:Image(
                                            width: 26,
                                            height:26,
                                            image: AssetImage('images/my.png'),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                  // 头像
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 25,right: 15,top: 5),
                            child: Text(
                              userData != null ? userData!.section:'',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.normal,
                              ),),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 12,left: 25),
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
                              leaderResult != null?
                              '团队（含负责人）拥有客户数：'+ leaderResult.toString()
                                  :'团队（含负责人）拥有客户数：0',
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
                      ),
                    ],
                  ),
                  // 成员列表
                  Padding(
                    padding: EdgeInsets.only(top: 40,bottom: 40),
                    child: hasMember == true && msgs != [] ?
                    Column(
                      children: msgs,
                    )
                        :
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            '还没有下级成员哦~',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ),
                        Text(
                          '点击右上角进入个人中心，添加下级成员吧！',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            )
          ],
        )
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}
