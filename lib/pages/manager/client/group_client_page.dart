import 'dart:convert';
import 'package:ThumbSir/dao/client_get_last_level_customer_num_dao.dart';
import 'package:ThumbSir/dao/get_last_level_customer_num_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/manager/client/team_client_member_page.dart';
import 'package:ThumbSir/pages/manager/traded/team_traded_member_page.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupClientPage extends StatefulWidget {
  @override
  _GroupClientPageState createState() => _GroupClientPageState();
}

class _GroupClientPageState extends State<GroupClientPage> {
  var leaderResult;
  bool _loading = false;
  var listResult;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];
  List<Widget> msgs=[];

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
    if(userData != null){
      _load();
    }else{
      setState(() {
        _loading =false;
      });
    }
  }

  _load()async{
    var getMemberListResult = await ClientGetLastLevelCustomerNumDao.httpClientGetLastLevelCustomerNum(
        userData.userPid,
        userData.companyId,
    );
    if(getMemberListResult != null){
      if(getMemberListResult.code == 200){
          _loading =false;
          leaderResult = getMemberListResult.data.levelLeaderData;
          listResult = getMemberListResult.data.list;
          if (listResult.length>0) {
            for(var item in listResult) {
              showList.add(
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamClientMemberPage(
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
                                  child:Image(
                                    image: item.headImg != null ?
                                    NetworkImage(item.headImg)
                                        :
                                    AssetImage('images/my_big.png'),
                                  )
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
                                    width: 200,
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      '购买/租赁需求数：'+item.kehuNums.toString(),
                                      style:TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      item.kehuNums != null ?
                                      '出售/出租需求数：'+item.yezhuNums.toString()
                                          :'出售/出租需求数：0',
                                      style:TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      item.kehuNums != null ?
                                      '有多个需求的客户数：'+item.duoXuQiuNums.toString()
                                          :'有多个需求的客户数：0',
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
            };
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
                      padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
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
                                  width: 28,
                                  padding: EdgeInsets.only(top: 3),
                                  child: Image(image: AssetImage('images/home.png'),),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('团队客户',style: TextStyle(
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
                                width: 60,
                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                  },
                                  color: Colors.transparent,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightColor: Colors.transparent,
                                  highlightElevation: 0,
                                  splashColor: Colors.transparent,
                                  disabledColor: Colors.transparent,
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
                                margin: EdgeInsets.only(right: 10),
                                width: 60,
                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                                  },
                                  color: Colors.transparent,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightColor: Colors.transparent,
                                  highlightElevation: 0,
                                  splashColor: Colors.transparent,
                                  disabledColor: Colors.transparent,
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
                              userData != null ? userData.section:'',
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
                              border: userData != null ?
                              userData.userLevel.substring(0,1) == '1' ?
                              Border.all(color: Color(0xFF003273),width: 1) // 总经理深蓝色
                                  :userData.userLevel.substring(0,1) == '2' ?
                              Border.all(color: Color(0xFF7412F2),width: 1) // 副总经理深紫色
                                  :userData.userLevel.substring(0,1) == '3' ?
                              Border.all(color: Color(0xFF9149EC),width: 1) // 总监浅紫色
                                  :userData.userLevel.substring(0,1) == '4' ?
                              Border.all(color: Color(0xFFFF9600),width: 1)// 商圈经理橘色
                                  :
                              Border.all(color: Color(0xFF24CC8E),width: 1)
                                  :Border.all(color: Colors.white,width: 1), // 店长绿色,
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top:2,left:5,right: 5),
                            child: Text(
                              leaderResult != null?
                              '团队（含负责人）购买/租赁需求数：'+ leaderResult.keHuCount.toString()
                                  :'团队（含负责人）购买/租赁需求数：0',
                              style: TextStyle(
                                fontSize: 10,
                                color: userData != null ?
                                userData.userLevel.substring(0,1) == '1' ?
                                Color(0xFF003273) // 总经理深蓝色
                                    :userData.userLevel.substring(0,1) == '2' ?
                                Color(0xFF7412F2) // 副总经理深紫色
                                    :userData.userLevel.substring(0,1) == '3' ?
                                Color(0xFF9149EC) // 总监浅紫色
                                    :userData.userLevel.substring(0,1) == '4' ?
                                Color(0xFFFF9600)// 商圈经理橘色
                                    :
                                Color(0xFF24CC8E)// 店长绿色,
                                    :Colors.white, // 未加载白色
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 12,left: 25),
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                              border: userData != null ?
                              userData.userLevel.substring(0,1) == '1' ?
                              Border.all(color: Color(0xFF003273),width: 1) // 总经理深蓝色
                                  :userData.userLevel.substring(0,1) == '2' ?
                              Border.all(color: Color(0xFF7412F2),width: 1) // 副总经理深紫色
                                  :userData.userLevel.substring(0,1) == '3' ?
                              Border.all(color: Color(0xFF9149EC),width: 1) // 总监浅紫色
                                  :userData.userLevel.substring(0,1) == '4' ?
                              Border.all(color: Color(0xFFFF9600),width: 1)// 商圈经理橘色
                                  :
                              Border.all(color: Color(0xFF24CC8E),width: 1)
                                  :Border.all(color: Colors.white,width: 1), // 店长绿色,
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top:2,left:5,right: 5),
                            child: Text(
                              leaderResult != null?
                              '团队（含负责人）出售/出租需求数：'+ leaderResult.yeZhuCount.toString()
                                  :'团队（含负责人）出售/出租需求数：0',
                              style: TextStyle(
                                fontSize: 10,
                                color: userData != null ?
                                userData.userLevel.substring(0,1) == '1' ?
                                Color(0xFF003273) // 总经理深蓝色
                                    :userData.userLevel.substring(0,1) == '2' ?
                                Color(0xFF7412F2) // 副总经理深紫色
                                    :userData.userLevel.substring(0,1) == '3' ?
                                Color(0xFF9149EC) // 总监浅紫色
                                    :userData.userLevel.substring(0,1) == '4' ?
                                Color(0xFFFF9600)// 商圈经理橘色
                                    :
                                Color(0xFF24CC8E)// 店长绿色,
                                    :Colors.white, // 未加载白色
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 12,left: 25),
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                              border: userData != null ?
                              userData.userLevel.substring(0,1) == '1' ?
                              Border.all(color: Color(0xFF003273),width: 1) // 总经理深蓝色
                                  :userData.userLevel.substring(0,1) == '2' ?
                              Border.all(color: Color(0xFF7412F2),width: 1) // 副总经理深紫色
                                  :userData.userLevel.substring(0,1) == '3' ?
                              Border.all(color: Color(0xFF9149EC),width: 1) // 总监浅紫色
                                  :userData.userLevel.substring(0,1) == '4' ?
                              Border.all(color: Color(0xFFFF9600),width: 1)// 商圈经理橘色
                                  :
                              Border.all(color: Color(0xFF24CC8E),width: 1)
                                  :Border.all(color: Colors.white,width: 1), // 店长绿色,
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top:2,left:5,right: 5),
                            child: Text(
                              leaderResult != null?
                              '团队（含负责人）有多个需求的客户数：'+ leaderResult.duoXuQiuCount.toString()
                                  :'团队（含负责人）有多个需求的客户数：0',
                              style: TextStyle(
                                fontSize: 10,
                                color: userData != null ?
                                userData.userLevel.substring(0,1) == '1' ?
                                Color(0xFF003273) // 总经理深蓝色
                                    :userData.userLevel.substring(0,1) == '2' ?
                                Color(0xFF7412F2) // 副总经理深紫色
                                    :userData.userLevel.substring(0,1) == '3' ?
                                Color(0xFF9149EC) // 总监浅紫色
                                    :userData.userLevel.substring(0,1) == '4' ?
                                Color(0xFFFF9600)// 商圈经理橘色
                                    :
                                Color(0xFF24CC8E)// 店长绿色,
                                    :Colors.white, // 未加载白色
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
