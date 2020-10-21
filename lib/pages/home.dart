import 'dart:convert';
import 'package:ThumbSir/dao/get_message_dao.dart';
import 'package:ThumbSir/dao/token_check_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/model/get_message_model.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:ThumbSir/pages/major/qlist/major_qlist_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/team_traded_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/s_qlist_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  bool _loading = false;

  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  int exT;

  List<Datum> msgList;
  List<Widget> msgShowList = [];
  List<Widget> msgs=[];

  List<Datum> myMsgList;
  List<Widget> myMsgShowList = [];
  List<Widget> myMsgs=[];

  LoginResultData userData;
  String uinfo;
  var result;
  var token;

  ScrollController _scrollController = ScrollController();

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo = prefs.getString("userInfo");
    if(uinfo!=null){
      result = loginResultDataFromJson(uinfo);
      token = LoginResultData.fromJson(json.decode(uinfo)).token;
      var tokenResult = await TokenCheckDao.tokenCheck(token);
      if (tokenResult.code == 200) {
          String dataStr = json.encode(tokenResult.data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userInfo", dataStr);
          prefs.setString('userID', tokenResult.data.userPid);
          this.setState(() {
            userData = LoginResultData.fromJson(json.decode(uinfo));
            _loadMsg();
          });
        }else{
          prefs.remove("userInfo");
          prefs.remove("userID");
          setState(() {
            _loading = false;
          });
        }
    }else{
      setState(() {
        _loading = false;
      });
    }
  }

  _load() async {
    var msgResult = await GetMessageDao.getMessage('1','1','1','5');
    if (msgResult.code == 200) {
      msgList=msgResult.data;
      if (msgList != null && msgList.length>0) {
        for (var item in msgList) {
          msgShowList.add(
            _item('images/tie_big.png',
                item.sendTime.toIso8601String().substring(0, 10),
                item.msgTitle,
                item.msgContent
            ),
          );
        }
      }
      setState(() {
        msgs=msgShowList;
        _loading = false;
      });
    }else{
      setState(() {
        _loading = false;
      });
    }
  }

  _loadMsg() async {
    var myMsgResult = await GetMessageDao.getMessage(userData.userPid,'2','1','1');
    if (myMsgResult.code == 200) {
      myMsgList=myMsgResult.data;
      if (myMsgList != null && myMsgList.length>0) {
        setState(() {
          _loading = false;
          for (var item in myMsgList) {
            myMsgShowList.add(
              GestureDetector(
                onTap: (){
                  if(uinfo!=null){
                    exT = result.exTokenTime.millisecondsSinceEpoch;
                    // token时间转时间戳
                    if(exT >= _dateTime){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                    }else{
                      _onLoginAlertPressed(context);
                    }
                  }else{
                    _onLoginAlertPressed(context);
                  }
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        item.msgContent,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "更多消息，点击前往消息中心处理",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF93C0FB),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )

            );
          }
        });
      }
      setState(() {
        myMsgs=myMsgShowList;
        _loading = false;
      });
    }else{
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState(){
    setState(() {
      _loading = true;
    });
    _getUserInfo();
    _load();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
          loading: _loading,
          msg:"加载中...",
          child:MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 460),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                if(userData != null){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                }else{
                                  _onLoginAlertPressed(context);
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 27,
                                    height: 27,
                                    margin: EdgeInsets.only(right: 6,left: 40,top: 2),
                                    child: Image(image: AssetImage('images/bell.png'),),
                                  ),
                                  Text('我的消息',style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF5580EB)
                                  ),),
                                ],
                              ),
                            ),
                            Container(
                              child: myMsgs != null && myMsgs.length>0 ?
                              ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.only(top: 20,bottom: 30),
                                shrinkWrap: true,
                                itemCount: myMsgs.length,
                                itemBuilder: (BuildContext context,int index){
                                  return myMsgs[index];
                                },
                              )
                                  :
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text('暂无消息',style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF999999)
                                ),),
                              ),
                            )
                          ],
                        )
                    ),
                    // 顶部导航区域
                    Column(
                        children: <Widget>[
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: ClipPath(
                              clipper: BottomClipper(),
                              child:
                              //  背景
                              Container(
                                  height: 460,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF0E7AE6),Color(0xFF93C0FB)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    image: DecorationImage(
                                      image:AssetImage('images/circle_r.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child:Column(
                                    children: <Widget>[
                                      // 顶部个人中心按钮
                                      GestureDetector(
                                        onTap: () {
                                          userData==null?Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())):
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                                        },
                                        child: Container(
                                          width: 335,
                                          margin: EdgeInsets.only(top: 70),
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                userData == null ?
                                                '你好！点这里登录/注册':'你好！'+userData.userName,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              // 头像按钮
                                              Container(
                                                margin: EdgeInsets.only(right: 20),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: 90,
                                                          height: 90,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(45)),
                                                            color: Colors.white,
                                                            boxShadow: [BoxShadow(
                                                                color: Color(0x99333333),
                                                                offset: Offset(0.0, 3.0),
                                                                blurRadius: 10.0,
                                                                spreadRadius: 2.0
                                                            )],
                                                          ),
                                                          child:ClipRRect(
                                                            borderRadius: BorderRadius.circular(45),
                                                            child: userData == null?
                                                            Image(image: AssetImage('images/my_big.png'),)
                                                                :userData != null && userData.headImg != null ?
                                                            Image(image:NetworkImage(userData.headImg))
                                                                :Image(image: AssetImage('images/my_big.png'),),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // 轮播图
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                              height: 100,
                                              width: 335,
                                              margin: EdgeInsets.only(bottom: 25,top: 10),
                                              child:Container(
                                                  child:
                                                  PageView.builder(
                                                    itemBuilder: (BuildContext buildContext,int index)=>msgs[index],
                                                    itemCount: msgs.length,
                                                  )
                                                //                      PageView(
                                                //                        children: <Widget>[
                                                //                          //每一条轮播
                                                //                          _item('images/tie_big.png','2020年3月24日','拇指先生正式上线啦！','邀请好友一起用起来吧~'),
                                                //                          _item('images/tie_big.png','2020年3月24日','客户维护相关功能暂未开放','敬请期待！'),
                                                //                        ],
                                                //                      ),
                                              )
                                          ),
                                          Positioned(
                                            top: 30,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: (){
                                                if(userData != null){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                                }else{
                                                  _onLoginAlertPressed(context);
                                                }
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 25,
                                                color: Colors.transparent,
                                                margin: EdgeInsets.only(left: 290,top: 5),
                                                child: Image(image: AssetImage('images/bell.png'),),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      // 入口
                                      Container(
                                        width: 335,
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // 量化
                                            Container(
                                              width: 160,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                boxShadow: [BoxShadow(
                                                    color: Color(0x50999999),
                                                    offset: Offset(0.0, 3.0),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 2.0
                                                )],
                                              ),
                                              child:GestureDetector(
                                                onTap: () async {
                                                  if(uinfo!=null){
                                                    exT = result.exTokenTime.millisecondsSinceEpoch;
                                                    // token时间转时间戳
                                                    if(exT >= _dateTime){
                                                      if(result.userLevel.substring(0,1)=="6"){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                                                      }
                                                      if(result.userLevel.substring(0,1)=="5"){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                                                      }
                                                      if(result.userLevel.substring(0,1)=="4"){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                                                      }
                                                      if(result.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                                                      }
                                                    }else{
                                                      _onLoginAlertPressed(context);
                                                    }
                                                  }else{
                                                    _onLoginAlertPressed(context);
                                                  }
                                                },
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                                  child:Image(
                                                      width: 160,
                                                      height: 80,
                                                      image: AssetImage('images/list.png'),
                                                      fit:BoxFit.fitHeight
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // 客户维护
                                            Container(
                                                width: 160,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  boxShadow: [BoxShadow(
                                                      color: Color(0x50999999),
                                                      offset: Offset(0.0, 3.0),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 2.0
                                                  )],
                                                ),
                                                child:GestureDetector(
                                                    onTap: (){
                                                      if(uinfo!=null){
                                                        exT = result.exTokenTime.millisecondsSinceEpoch;
                                                        // token时间转时间戳
                                                        if(exT >= _dateTime){
                                                          if(result.userLevel.substring(0,1)=="6"){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyTradedPage()));
                                                          }
                                                          if(result.userLevel.substring(0,1)=="5"){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MTradedPage()));
                                                          }
                                                          if(result.userLevel.substring(0,1)=="4"){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>STradedPage()));
                                                          }
                                                          if(result.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamTradedPage()));
                                                          }
                                                        }else{
                                                          _onLoginAlertPressed(context);
                                                        }
                                                      }else{
                                                        _onLoginAlertPressed(context);
                                                      }
//                                                  _onCloseAlertPressed(context);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                                      child:Image(
                                                          image: AssetImage('images/traded.png'),
                                                          fit:BoxFit.cover
                                                      ),
                                                    )
                                                )
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          )
                        ]
                    ),
                  ],
                ),
              ],
            ),
          ))
    );
  }

  _item(var image,String date,String content,String tip){
    return Stack(
      children: <Widget>[
        Container(
            height: 100,
            width: 335,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Container(
              height: 80,
              width: 335,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:Container(
                  padding: EdgeInsets.only(left: 100),
                  child:Column(
                    children: <Widget>[
                      Container(
                        width: 220,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          date,
                          style:TextStyle(
                            fontSize: 12,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            height: 2,
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          content,
                          style:TextStyle(
                              fontSize: 14,
                              color: Color(0xFFF67419),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              height: 1.5
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          tip,
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF67419),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    ],
                  )
              ),
            )
        ),
        Positioned(
          top: 5,
          child: Container(
            width: 95,
            height: 95,
            child: Image(
              image:AssetImage(image),
            ),
          ),
        ),
      ],
    );
  }
  _onLoginAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "请先登录",
      buttons: [
        DialogButton(
          child: Text(
            "去登录",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage())),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onCloseAlertPressed(context) {
    Alert(
      context: context,
      title: "暂未开放，敬请期待!",
      content: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Image(image: AssetImage('images/wait.png'),),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "知道啦",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
    if(result != null){
      setState(() {
        _loading = !_loading;
      });
    }
  }
}


// 导航区域下曲线
class BottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height-70.0); //第2个点
    var firstControlPoint = Offset(size.width/2, size.height);
    var firstEdnPoint = Offset(size.width, size.height-70.0);
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEdnPoint.dx,
        firstEdnPoint.dy
    );
    path.lineTo(size.width, size.height-50.0); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
