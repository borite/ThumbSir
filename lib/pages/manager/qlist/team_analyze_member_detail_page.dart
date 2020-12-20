import 'dart:convert';
import 'package:ThumbSir/dao/get_leader_data_dao.dart';
import 'package:ThumbSir/dao/get_next_level_list_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/qlist/team_analyze_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_analyze_group_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_member_analyze_detail_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamAnalyzeMemberDetailPage extends StatefulWidget {
  final leaderArea;
  final leaderName;
  final leaderID;
  final leaderAreaRate;
  TeamAnalyzeMemberDetailPage({this.leaderArea,this.leaderName,this.leaderID,this.leaderAreaRate});
  @override
  _TeamAnalyzeMemberDetailPageState createState() => _TeamAnalyzeMemberDetailPageState();
}

class _TeamAnalyzeMemberDetailPageState extends State<TeamAnalyzeMemberDetailPage> {
  bool _loading = false;
  var leaderResult;
  var listResult;
  var leaderInfo;
  var leaderCount;
  var currentLevelResult;
  bool hasMember = false;
  var dateTime = DateTime.now().toIso8601String().substring(0,10);
  List<Widget> showList = [];

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
    var getLeaderResult = await GetLeaderDataDao.httpGetLeaderData(
        widget.leaderID,
        userData.companyId,
        dateTime
    );
    var getMemberListResult = await GetNextLevelListDao.httpGetNextLevelList(
        widget.leaderID,
        userData.companyId,
        widget.leaderArea,
        dateTime
    );
    if(getMemberListResult != null && getLeaderResult != null ){
      if(getMemberListResult.code == 200 && getLeaderResult.code == 200){
        setState(() {
          hasMember = true;
          _loading =false;
          leaderResult = getMemberListResult.data.zonghe;
          listResult = getMemberListResult.data.list;
          currentLevelResult = getMemberListResult.data.currentLevel;
          leaderInfo = getLeaderResult.data.leaderInfo;
          leaderCount = getLeaderResult.data.leaderCount;
        });
      }else{
        setState(() {
          hasMember = false;
          _loading = false;
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
  Widget teamItem(){
    Widget content;
    if(listResult != null){
      for(var item in listResult) {
        showList.add(
          Container(
            margin: EdgeInsets.only(bottom: 25),
            padding: EdgeInsets.only(right: 5),
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
                          ((item.teamRate==1.0?1:item.teamRate)*100).toString().split(".")[0]+'%',
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
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage(
                            section:item.teamName,
                            companyId:userData.companyId
                        )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 190,
                        child: Text(
                          item.teamName+' （ '+ item.nextLeader.userName +' ）',
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    if(currentLevelResult.substring(0,1) == '4'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeGroupDetailPage(
                          leaderArea : item.teamName,
                          leaderAreaRate : item.teamRate,
                          leaderName : item.nextLeader.userName,
                          leaderID : item.nextLeader.userPid
                      )));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeMemberDetailPage(
                        leaderArea : item.teamName,
                        leaderAreaRate : item.teamRate,
                        leaderName : item.nextLeader.userName,
                        leaderID : item.nextLeader.userPid
                      )));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    color: Colors.transparent,
                    child: Image(image: AssetImage('images/next.png'),),
                  ),
                )
              ],
            ),
          ),
        );
      };
    }
    content =Column(
      children:showList,
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
                                        child: Text('团队分析',style: TextStyle(
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
                                                  ((widget.leaderAreaRate == 1.0 ?1:widget.leaderAreaRate)*100).toString().split(".")[0]+'%',
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
                                              child: Text(
                                                widget.leaderArea,
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
                                                      child:Image(
                                                        image: leaderInfo != null ?
                                                        leaderInfo.headImg != null ?
                                                        NetworkImage(leaderInfo.headImg)
                                                            :
                                                        AssetImage('images/my_big.png'):AssetImage('images/my_big.png'),
                                                      )
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
                                                          color:
                                                          currentLevelResult!=null?
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
                                                      leaderInfo != null?leaderInfo.userName:'',
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
                                                    currentLevelResult!= null && currentLevelResult.substring(0,1) == '4'?
                                                    leaderCount!=null?'个人今日综合完成度：'+((leaderCount.finishRate)*100).toString().split(".")[0]+'%':'个人今日综合完成度：0%'
                                                        :'',
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamMemberAnalyzeDetailPage(
                                            name:widget.leaderName,
                                            id:widget.leaderID,
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
                                hasMember == true ?
                                teamItem()
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
}
