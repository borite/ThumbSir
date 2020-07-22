import 'dart:convert';
import 'package:ThumbSir/dao/get_next_liang_hua_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/qlist/group_list_detail_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_list_detail_page.dart';
import 'package:ThumbSir/pages/mycenter/choose_mini_task_page.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TeamListPage extends StatefulWidget {
  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  bool _loading = false;
  var leaderResult;
  var listResult;
  var currentLevelResult;
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
    var getMemberListResult = await GetNextLiangHuaDao.httpGetNextLiangHua(
        userData.userPid,
        userData.companyId,
        userData.section,
        dateTime
    );
    if(getMemberListResult != null){
      if(getMemberListResult.code == 200){
          hasMember = true;
          _loading =false;
          leaderResult = getMemberListResult.data.zonghe;
          listResult = getMemberListResult.data.list;
          currentLevelResult = getMemberListResult.data.currentLevel.substring(0,1);
          if (listResult.length>0) {
            for(var item in listResult) {
              showList.add(
                GestureDetector(
                  onTap: (){
                    if(currentLevelResult == '4'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupListDetailPage(
                          leaderArea : item.teamName,
                          leaderAreaRate : item.finishRate,
                          leaderName : item.nextLeader.userName,
                          leaderID : item.nextLeader.userPid
                      )));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamListDetailPage(
                          leaderArea : item.teamName,
                          leaderAreaRate : item.finishRate,
                          leaderName : item.nextLeader.userName,
                          leaderID : item.nextLeader.userPid
                      )));
                    }
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
                                      item.teamName+' （ '+ item.nextLeader.userName +' ）',
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
                                      '今日计划：'+ item.planCount.toString() +'，已完成：'+item.finishCount.toString(),
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
                        Image(image: AssetImage('images/next.png'),),
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
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/home.png'),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('团队量化',style: TextStyle(
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
                  Stack(
                    children: <Widget>[
                      Row(
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
                                      userData!= null ?userData.section:'',
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
                                      '今日总任务量：'+ leaderResult.planCount.toString() +' , 已完成：'+leaderResult.finishCount.toString()
                                          :'数据统计中……',
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
                          )
                        ],
                      )
                    ],
                  ),
                  // 制定任务
                  userData != null ?
                  userData.userLevel.substring(0,1) == '3' || userData.userLevel.substring(0,1) == '4'?
                  Container(
                    width: 335,
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFF5580EB),width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseMiniTaskPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('为下级设置每日最低任务量',style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5580EB),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                          Image(image: AssetImage('images/next.png'),)
                        ],
                      ),
                    ),
                  )
                  :
                  Container(width: 1,):Container(width: 1,),
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
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Text(
                          '去个人中心——区域成员添加下级成员吧！',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
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
