import 'dart:convert';
import 'package:ThumbSir/dao/get_next_level_house_resource_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/house/team_house_member_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'group_house_detail_page.dart';

class TeamHouseDetailPage extends StatefulWidget {
  final houseItem;
  TeamHouseDetailPage({this.houseItem});
  @override
  _TeamHouseDetailPageState createState() => _TeamHouseDetailPageState();
}

class _TeamHouseDetailPageState extends State<TeamHouseDetailPage> {
  bool _loading = false;
  var leaderResult;
  var listResult;
  var currentLevelResult;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];
  List<Widget> msgs=[];
  dynamic leaderTeamHouseIDs;

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
    dynamic getResult = await GetNextLevelHouseResourceDao.getNextLevelHouseResource(
      widget.houseItem.userId,
      userData!.companyId,
      widget.houseItem.teamName
    );
    if(getResult != null){
      if(getResult.code == 200){
        setState(() {
          hasMember = true;
          _loading =false;
          leaderResult = getResult.data!.houseCount;
          listResult = getResult.data!.teams;
          leaderTeamHouseIDs = getResult.data!.hids;
          currentLevelResult = getResult.data!.userLevel;
        });
        if (listResult.length>0) {
          for(var item in listResult) {
            showList.add(
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamHouseMemberPage(
                    userName: item.teamName,
                    companyId: userData!.companyId,
                    houseIDs: item.areaIDs.toString().replaceAll("[", "").replaceAll("]", ""),
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
                              padding: EdgeInsets.only(top:16),
                              child: Text(
                                (listResult.indexOf(item)+1).toString(),
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
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 200,
                                  padding: EdgeInsets.only(top: 8,bottom: 5),
                                  child: Text(
                                    item.teamName+' （ '+ item.leaderName +' ）',
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
                                    '团队在维护房源数：'+item.areaHouseCount.toString(),
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
                      GestureDetector(
                        onTap: (){
                          if(currentLevelResult.substring(0,1) == '4'){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupHouseDetailPage(
                                houseItem : item
                            )));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamHouseDetailPage(
                                houseItem : item
                            )));
                          }
                        },
                        child: Image(image: AssetImage('images/next.png'),),
                      )

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
                  // 列表
                  Container(
                    width: 335,
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child: Column(
                      children: <Widget>[
                        // 组名
                        Container(
                            margin: EdgeInsets.only(bottom: 40,top: 5),
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
                        // 负责人
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
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
                                              border: currentLevelResult!=null?
                                              currentLevelResult.substring(0,1) == '2'?
                                              Border.all(color: Color(0xFF7412F2),width: 1) // 副总经理深紫色
                                                  :currentLevelResult.substring(0,1) == '3'?
                                              Border.all(color: Color(0xFF9149EC),width: 1) // 总监浅紫色
                                                  :
                                              Border.all(color: Color(0xFFFF9600),width: 1) // 商圈经理橘色
                                                  :Border.all(color: Colors.white,width: 1)
                                          ),
                                          child:ClipRRect(
                                              borderRadius: BorderRadius.circular(40),
                                              child:widget.houseItem != null ?
                                              widget.houseItem.leaderHeadUrl != null ?
                                              Image(
                                                image: NetworkImage(widget.houseItem.leaderHeadUrl),
                                              ):Image(image: AssetImage('images/my_big.png'))
                                                  :Image(image: AssetImage('images/my_big.png'))
                                          ),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 10,
                                          child: Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                border: currentLevelResult!=null?
                                                currentLevelResult.substring(0,1) == '2'?
                                                Border.all(color: Color(0xFF7412F2),width: 1) // 副总经理深紫色
                                                    :currentLevelResult.substring(0,1) == '3'?
                                                Border.all(color: Color(0xFF9149EC),width: 1) // 总监浅紫色
                                                    :
                                                Border.all(color: Color(0xFFFF9600),width: 1) // 商圈经理橘色
                                                    :Border.all(color: Colors.white,width: 1),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top:2,left:5,right: 5),
                                              child: Text(
                                                currentLevelResult!=null?currentLevelResult.substring(2,):"",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: currentLevelResult!=null?
                                                  currentLevelResult.substring(0,1) == '2'?
                                                  Color(0xFF7412F2) // 副总经理深紫色
                                                      :currentLevelResult.substring(0,1) == '3'?
                                                  Color(0xFF9149EC) // 总监浅紫色
                                                      :
                                                  Color(0xFFFF9600) // 商圈经理橘色
                                                      :Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
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
                                              widget.houseItem.leaderName,
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
                                            listResult != null && currentLevelResult != null && currentLevelResult.substring(0,1) == '3'?
                                            '':
                                            listResult != null && currentLevelResult != null && currentLevelResult.substring(0,1) == '2'?
                                            '':
                                            '个人在维护房源数：'+widget.houseItem.leaderHouseCount.toString(),
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
                              currentLevelResult!= null && currentLevelResult.substring(0,1) == '4'?
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamHouseMemberPage(
                                    userName:widget.houseItem.leaderName,
                                    companyId:userData!.companyId,
                                    houseIDs:widget.houseItem.leaderHouseIDs.toString().replaceAll("[", "").replaceAll("]", ""),
                                  )));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                  color: Colors.transparent,
                                  child: Image(image: AssetImage('images/next.png'),),
                                ),
                              )
                                  :Container(width: 1,),
                            ],
                          ),
                        ),
                        // 列表
                        hasMember == true && msgs != [] ?
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
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Text(
                              '点击右上角进入个人中心，添加下级成员吧！',
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
