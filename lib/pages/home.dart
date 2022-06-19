import 'dart:convert';
import 'package:ThumbSir/dao/get_message_dao.dart';
import 'package:ThumbSir/dao/token_check_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/model/get_message_model.dart';
import 'package:ThumbSir/pages/broker/client/my_client_page.dart';
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
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'broker/house/house_list_page.dart';
import 'manager/client/m_client_page.dart';
import 'manager/client/s_client_page.dart';
import 'manager/client/team_client_page.dart';
import 'manager/house/m_house_page.dart';
import 'manager/house/s_house_page.dart';
import 'manager/house/team_house_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  bool _loading = false;

  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  late int exT;

  late List<Datum> msgList;
  List<Widget> msgShowList = [];
  List<Widget> msgs=[];

  late List<Datum> myMsgList;
  List<Widget> myMsgShowList = [];
  List<Widget> myMsgs=[];

  LoginResultData? userData;
  dynamic uInfo;
  dynamic result;

  ScrollController _scrollController = ScrollController();

   var _serviceVersionApp;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo = prefs.getString("userInfo")!;
    if(uInfo!=null){
      result = loginResultDataFromJson(uInfo);
      dynamic token = LoginResultData.fromJson(json.decode(uInfo)).token;
      var tokenResult = await TokenCheckDao.tokenCheck(token);
      if (tokenResult.code == 200) {
          String dataStr = json.encode(tokenResult.data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userInfo", dataStr);
          prefs.setString('userID', tokenResult.data!.userPid);
          this.setState(() {
            userData = LoginResultData.fromJson(json.decode(uInfo));
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

  var versionMsg;

  // PackageInfo _packageInfo = PackageInfo(
  //   appName: 'Unknown',
  //   packageName: 'Unknown',
  //   version: 'Unknown',
  //   buildNumber: 'Unknown',
  // );


  // Future<AppUpgradeInfo>_loadVersion() async {
  //   var currentAppInfo=await FlutterUpgrade.appInfo;
  //   print(currentAppInfo);
  //   var versionResult = await CheckLatestVersionDao.checkVersion();
  //   if (versionResult.code == 200) {
  //     setState(() {
  //       versionMsg = versionResult.data;
  //       _loading = false;
  //     });
  //     if( currentAppInfo.versionName!= versionMsg.version){
  //       return AppUpgradeInfo(title: '新版本:'+versionMsg.version, contents: versionMsg.versionDes.split('<br>'),force: false);
  //     }
  //   }
  //
  //   return null;
  //   //   setState(() {
  //   //     versionMsg = versionResult.data;
  //   //     _loading = false;
  //   //   });
  //   //   // print(_packageInfo.version);
  //   //   // print(versionMsg.version);
  //   //   if(versionMsg != null && _packageInfo != null && _packageInfo.version != versionMsg.version){
  //   //     //_onUploadPressed(context);
  //   //     return AppUpgradeInfo(title: '新版本:'+versionMsg.version, contents: [versionMsg.versionDes],force: false);
  //   //
  //   //   }else{
  //   //
  //   //   }
  //   // } else {
  //   //   _onLoadAlert(context);
  //   // }
  // }

  // Future<void> _initPackageInfo() async {
  //   final PackageInfo info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _packageInfo = info;
  //   });
  // }

  _load() async {
    dynamic msgResult = await GetMessageDao.getMessage('1','1','1','5');
    if (msgResult.code == 200) {
      msgList=msgResult.data;
      if (msgList.length>0) {
        for (var item in msgList) {
          msgShowList.add(
            _item('images/tie_big.png',
                item.sendTime!.toIso8601String().substring(0, 10),
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
    dynamic myMsgResult = await GetMessageDao.getMessage(userData!.userPid,'2','1','1');
    if (myMsgResult.code == 200) {
      myMsgList=myMsgResult.data;
      if (myMsgList.length>0) {
        setState(() {
          _loading = false;
          for (var item in myMsgList) {
            myMsgShowList.add(
              GestureDetector(
                onTap: (){
                  if(uInfo!=null){
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

    //获取用户信息
    _getUserInfo();
    //加载最新消息
    _load();

    //获取当前版本信息
    //_initPackageInfo();
    // AppUpgrade.appUpgrade(context,_loadVersion(),iosAppId:'1528859048' );
    //升级提示弹窗
    //_loadVersion();
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
                        margin: EdgeInsets.only(top: 580),
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
                              child: myMsgs.length>0 ?
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
                                  // height: 460,
                                height: 580,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors:[Color(0xFF0E7AE6),Color(0xFF93C0FB)],
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
                                                '你好！点这里登录/注册':'你好！'+userData!.userName,
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
                                                                :userData != null && userData!.headImg != null ?
                                                            Image(image:NetworkImage(userData!.headImg))
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
                                      // 4个入口
                                      Container(
                                        width: 335,
                                        margin: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            Row(
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
                                                      if(uInfo!=null && userData != null){
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
                                                // 老客户维护
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
                                                          if(uInfo!=null && userData != null){
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
                                            Container(
                                              margin: EdgeInsets.only(top: 30),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  // 房源系统
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
                                                        if(uInfo!=null && userData != null){
                                                          exT = result.exTokenTime.millisecondsSinceEpoch;
                                                          // token时间转时间戳
                                                          if(exT >= _dateTime){
                                                            if(result.userLevel.substring(0,1)=="6"){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseListPage()));
                                                            }
                                                            if(result.userLevel.substring(0,1)=="5"){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MHousePage()));
                                                            }
                                                            if(result.userLevel.substring(0,1)=="4"){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SHousePage()));
                                                            }
                                                            if(result.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamHousePage()));
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
                                                            image: AssetImage('images/house.png'),
                                                            fit:BoxFit.fitHeight
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // 未成交客户
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
                                                            if(uInfo!=null && userData != null){
                                                              exT = result.exTokenTime.millisecondsSinceEpoch;
                                                              // token时间转时间戳
                                                              if(exT >= _dateTime){
                                                                if(result.userLevel.substring(0,1)=="6"){
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyClientPage()));
                                                                }
                                                                if(result.userLevel.substring(0,1)=="5"){
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MClientPage()));
                                                                }
                                                                if(result.userLevel.substring(0,1)=="4"){
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SClientPage()));
                                                                }
                                                                if(result.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamClientPage()));
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
                                                                image: AssetImage('images/client.png'),
                                                                fit:BoxFit.cover
                                                            ),
                                                          )
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )

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

  // _onUploadPressed(context) {
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "发现新版本"+versionMsg.version,
  //     desc: "请前往应用商店进行更新",
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "去更新",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: (){
  //
  //           // 跳转到应用商店
  //           if(Theme.of(context).platform == TargetPlatform.android){
  //             // 安卓手机
  //             print('android');
  //           }else{
  //             // 苹果手机
  //             print('ios');
  //             _serviceVersionApp="http://itunes.apple.com/cn/lookup?id=com.bigxia.thumbsir";
  //             launch(_serviceVersionApp);
  //           }
  //
  //           _getUserInfo();
  //           _load();
  //           Navigator.pop(context);
  //         },
  //         color: Color(0xFF5580EB),
  //       ),
  //       DialogButton(
  //         child: Text(
  //           "再等等",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: (){
  //           _getUserInfo();
  //           _load();
  //           Navigator.pop(context);
  //         },
  //         color: Color(0xFFCCCCCC),
  //       ),
  //     ],
  //   ).show();
  // }

  _onLoadAlert(context) {
    Alert(
      context: context,
      title: "加载任务失败",
      desc: "请检查网络连接情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _loading = false;
            });
          },
          color: Color(0xFF5580EB),
        )
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
