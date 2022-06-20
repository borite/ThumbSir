import 'dart:convert';
import 'package:ThumbSir/dao/client_get_last_level_customer_num_dao.dart';
import 'package:ThumbSir/dao/client_get_leader_info_dao.dart';
import 'package:ThumbSir/dao/get_last_level_customer_num_dao.dart';
import 'package:ThumbSir/dao/get_leader_info_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/client/team_client_member_page.dart';
import 'package:ThumbSir/pages/manager/traded/team_traded_member_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupClientDetailPage extends StatefulWidget {
  final leaderArea;
  final leaderName;
  final leaderID;
  final leaderAreaRate;
  GroupClientDetailPage({this.leaderArea,this.leaderName,this.leaderID,this.leaderAreaRate});
  @override
  _GroupClientDetailPageState createState() => _GroupClientDetailPageState();
}

class _GroupClientDetailPageState extends State<GroupClientDetailPage> {
  bool _loading = false;
  var leaderResult;
  var listResult;
  var leaderInfo;
  var leaderCount;
  var currentLevelResult;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];

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
    dynamic getLeaderResult = await ClientGetLeaderInfoDao.httpClientGetLeaderInfo(
        widget.leaderID,
        userData!.companyId,
    );
    dynamic getMemberListResult = await ClientGetLastLevelCustomerNumDao.httpClientGetLastLevelCustomerNum(
        widget.leaderID,
        userData!.companyId,
    );
    if(getMemberListResult != null && getLeaderResult != null ){
      if(getMemberListResult.code == 200 && getLeaderResult.code == 200){
        setState(() {
          _loading =false;
          listResult = getMemberListResult.data.list;
          leaderInfo = getLeaderResult.data.leaderInfo;
          leaderCount = getLeaderResult.data.levelLeaderData;
        });
        if(listResult != []){
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

  // 下级成员列表
  Widget memberItem(){
    Widget content;
    if(listResult != null){
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
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
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
                            ) :Image(image: AssetImage('images/my_big.png'),)
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
                              padding: EdgeInsets.only(top: 3),
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
                              padding: EdgeInsets.only(top: 2),
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
                              padding: EdgeInsets.only(top: 2),
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
      }
    }
    content =Column(
      children:showList,
    );
    return content;
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
                                child: Text('团队客户',style: TextStyle(
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
                  // 分页
                  Container(
                    width: 335,
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child: Column(
                      children: <Widget>[
                        // 组名
                        Container(
                            margin: EdgeInsets.only(bottom: 25,top: 5),
                            width: 335,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color:Color(0xFF93C0FB),width: 2),
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
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        color: Color(0xFF93C0FB),
                                      ),
                                      child:Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text(
                                          '区域',
                                          style:TextStyle(
                                            fontSize: 16,
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
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 200,
                                            padding: EdgeInsets.only(top: 8,bottom: 5),
                                            child: Text(
                                              widget.leaderArea,
                                              style:TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF666666),
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              '团队拥有的需求数：'+widget.leaderAreaRate.toString(),
                                              style:TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF999999),
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                        // 店长
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamClientMemberPage(
                              userId: leaderInfo.userPid,
                              userLevel: leaderInfo.userLevel,
                              userName: leaderInfo.userName,
                            )));
                          },
                          child: Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                                color: Colors.white,
                                                border: Border.all(color: Color(0xFF24CC8E),width: 1)
                                            ),
                                            child:Image(
                                              image: AssetImage('images/my_big.png'),
                                            ),
                                          ),
                                          Positioned(
                                            top: 60,
                                            left: 10,
                                            child: Container(
                                              width: 60,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0xFF24CC8E),width: 1),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(top:2,left:5,right: 5),
                                                child: Text(
                                                  leaderInfo!=null?leaderInfo.userLevel.substring(2,):"",
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
                                      width: 150,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                leaderInfo != null?leaderInfo.userName:'',
                                                style:TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF333333),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 200,
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(
                                              leaderCount!=null?
                                              '购买/租赁需求数：'+leaderCount.keHuCount.toString():'购买/租赁需求数：0',
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
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              leaderCount!=null?
                                              '出售/出租需求数：'+leaderCount.yeZhuCount.toString():'出售/出租需求数：0',
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
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              leaderCount!=null?
                                              '多个需求的客户数：'+leaderCount.duoXuQiuCount.toString():'多个需求的客户数：0',
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
                        // 成员列表
                        hasMember == true ?
                        memberItem()
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
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Text(
                              '提醒该成员添加下级成员吧！',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ])
          ])
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}