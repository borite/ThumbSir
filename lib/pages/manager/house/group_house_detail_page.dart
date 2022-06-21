import 'dart:convert';
import 'package:ThumbSir/dao/get_last_level_house_resource_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/house/team_house_member_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupHouseDetailPage extends StatefulWidget {
  final houseItem;
  GroupHouseDetailPage({this.houseItem});
  @override
  _GroupHouseDetailPageState createState() => _GroupHouseDetailPageState();
}

class _GroupHouseDetailPageState extends State<GroupHouseDetailPage> {
  bool _loading = false;
  var leaderResult;
  var listResult;
  var leaderInfo;
  var leaderCount;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    this.setState(() {
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
    dynamic getLastListResult = await GetLastLevelHouseResourceDao.httpGetLastLevelHouseResource(
        widget.houseItem.userId,
        userData!.companyId,
    );
    if(getLastListResult != null){
      if(getLastListResult.code == 200){
        setState(() {
          _loading =false;
          listResult = getLastListResult.data.list;
          leaderCount = widget.houseItem.leaderHouseCount;
          leaderInfo = widget.houseItem;
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamHouseMemberPage(
                userName: item.userName,
                companyId: userData!.companyId,
                houseIDs: item.houseIDs.toString().replaceAll("[", "").replaceAll("]", ""),
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
                              image: NetworkImage(item.headImg),
                            ):Image(image: AssetImage('images/my_big.png'))
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
                                item.houseCount != null ?
                                '个人在维护房源数：'+item.houseCount.toString()
                                    :'个人在维护房源数：0',
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
                                child: Text('团队房源',style: TextStyle(
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
                                              widget.houseItem.teamName,
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
                                              '团队在维护房源数：'+widget.houseItem.areaHouseCount.toString(),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamHouseMemberPage(
                              userName: leaderInfo.leaderName,
                              companyId: userData!.companyId,
                              houseIDs: leaderInfo.leaderHouseIDs.toString().replaceAll("[", "").replaceAll("]", ""),
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
                                                  leaderInfo!=null?leaderInfo.leaderLevel.substring(2,):"",
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
                                                leaderInfo != null?leaderInfo.leaderName:'',
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
                                            width: 150,
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              leaderCount!=null?
                                              '个人在维护房源数：'+leaderCount.toString()
                                              :'个人在维护房源数：0',
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
