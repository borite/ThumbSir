import 'dart:convert';
import 'package:ThumbSir/dao/get_last_level_members_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/qlist/team_analyze_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_member_analyze_detail_page.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class GroupAnalyzePage extends StatefulWidget {
  @override
  _GroupAnalyzePageState createState() => _GroupAnalyzePageState();
}

class _GroupAnalyzePageState extends State<GroupAnalyzePage> {

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
    var getMemberListResult = await GetLastLevelMembersDao.httpGetLastLevelMembers(
        userData.userPid,
        userData.companyId,
        dateTime
    );
    if(getMemberListResult != null){
      if(getMemberListResult.code == 200){
          _loading =false;
          leaderResult = getMemberListResult.data.zonghe;
          listResult = getMemberListResult.data.list;
          if (listResult.length>0) {
            for(var item in listResult) {
              showList.add(
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamMemberAnalyzeDetailPage(
                      name:item.userName,
                      id:item.userPid,
                    )));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                    width: 335,
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
                                  borderRadius: BorderRadius.circular(40),
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
                                    child: Text(item.missionData != null ?
                                    '今日综合完成度：'+((item.missionData.finishRate)*100).toString()+'%':'今日无计划',
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
                          // 首页和标题
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/home.png'),),
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
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamAnalyzeDetailPage(
                        section: userData.section,
                        companyId: userData.companyId,
                      )));
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                                startAngle: 280,
                                angleRange: 360,
                                customWidths: CustomSliderWidths(progressBarWidth: 10),
                                customColors: CustomSliderColors(
                                  progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                                  trackColor: Color(0x20CCCCCC),
                                  dotColor: Colors.transparent,
                                ),
                                infoProperties: InfoProperties(
                                    mainLabelStyle: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF2692FD),
                                    )
                                )
                            ),
                            min: 0,
                            max: 100,
                            initialValue: leaderResult!=null?(leaderResult.finishRate)*100:0,
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
                                    border: Border.all(color: Color(0xFF24CC8E),width: 1),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top:2,left:5,right: 5),
                                  child: Text(
                                    leaderResult != null?
                                    '今日总任务量：'+ leaderResult.planningCount.toString() +' , 已完成：'+leaderResult.finishCount.toString()
                                        :'今日无计划',
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
                        )
                      ],
                    ),
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
