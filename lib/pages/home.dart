import 'dart:convert';
import 'package:ThumbSir/dao/get_message_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/major/qlist/major_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/broker/openclient/open_client_page.dart';
import 'package:ThumbSir/pages/broker/openowner/open_owner_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  var msgList;
  List<Widget> msgShowList = [];

  _load() async {
    var msgResult = await GetMessageDao.getMessage('1','1','1','5');
    if (msgResult.code == 200) {
      setState(() {
        msgList = msgResult.data;
      });
    }
  }

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    _load();
    super.initState();
    controller = AnimationController(vsync:this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 200,end:20).animate(
        CurvedAnimation(parent: controller,curve: Curves.easeInOut)
    );
    controller.forward();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  Widget msgItem() {
    Widget content;
    if (msgList != null) {
      for (var item in msgList) {
        msgShowList.add(
          _item('images/tie_big.png',item.sendTime.toIso8601String().substring(0,10),item.msgTitle,item.msgContent),
        );
      }
    }
    content = PageView(
      children: msgShowList,
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF003273),Color(0xFF0E7AE6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        image: DecorationImage(
          image:AssetImage('images/circle.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Column(
              children: <Widget>[
                // 个人中心按钮
                Padding(
                    padding: EdgeInsets.only(left:300),
                    child:RaisedButton(
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
                            decoration: BoxDecoration(color: Colors.white),
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
                    )
                ),

                // 轮播图
                Container(
                    height: 100,
                    width: 335,
                    margin: EdgeInsets.only(bottom: 25),
                    child:Container(
                      child:
                      msgItem(),
//                      PageView(
//                        children: <Widget>[
//                          // 每一条轮播
//                          _item('images/tie_big.png','2020年3月24日','拇指先生正式上线啦！','邀请好友一起用起来吧~'),
//                          _item('images/tie_big.png','2020年3月24日','客户维护相关功能暂未开放','敬请期待！'),
//                        ],
//                      ),
                    )
                ),

                // 入口
                QlistBtn(animation: animation,),
                OpenClientBtn(animation: animation,),
                OpenOwnerBtn(animation: animation,),
                TradedBtn(animation: animation,),
              ])
        ],
      )

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
}

class QlistBtn extends AnimatedWidget{
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  int exT;
  String uinfo;
  var result;
  QlistBtn({Key key,Animation<double> animation}):super(key:key,listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      margin: EdgeInsets.only(top: animation.value),
      child:RaisedButton(
        onPressed: () async {
          //类比获取整个redux
          SharedPreferences prefs = await SharedPreferences.getInstance();
          uinfo= prefs.getString("userInfo");
          if(uinfo!=null){
            result=LoginResultData.fromJson(json.decode(uinfo));
            exT = result.exTokenTime.millisecondsSinceEpoch;
            // token时间转时间戳
            if(exT >= _dateTime){
              if(result.userLevel.substring(0,1)=="6"){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
              }
              if(result.userLevel.substring(0,1)=="4"||result.userLevel.substring(0,1)=="5"){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
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
        color: Colors.transparent,
        elevation: 0,
        disabledElevation: 0,
        highlightColor: Colors.transparent,
        highlightElevation: 0,
        splashColor: Colors.transparent,
        disabledColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child:Image(
              width: 353,
              height:110,
              image: AssetImage('images/list.png'),
              fit:BoxFit.cover
          ),
        ),
      ),
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
}
class OpenClientBtn extends AnimatedWidget{
  OpenClientBtn({Key key,Animation<double> animation}):super(key:key,listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
        margin: EdgeInsets.only(top: animation.value),
        child:RaisedButton(
            onPressed: (){
              _onCloseAlertPressed(context);
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenClientPage()));
            },
            color: Colors.transparent,
            elevation: 0,
            disabledElevation: 0,
            highlightColor: Colors.transparent,
            highlightElevation: 0,
            splashColor: Colors.transparent,
            disabledColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child:Image(
                  width: 353,
                  height:110,
                  image: AssetImage('images/openclient.png'),
                  fit:BoxFit.cover
              ),
            )
        )
    );
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
}

class OpenOwnerBtn extends AnimatedWidget{
  OpenOwnerBtn({Key key,Animation<double> animation}):super(key:key,listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
        margin: EdgeInsets.only(top: animation.value),
        child:RaisedButton(
            onPressed: (){
              _onCloseAlertPressed(context);
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenOwnerPage()));
            },
            color: Colors.transparent,
            elevation: 0,
            disabledElevation: 0,
            highlightColor: Colors.transparent,
            highlightElevation: 0,
            splashColor: Colors.transparent,
            disabledColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child:Image(
                  width: 353,
                  height:110,
                  image: AssetImage('images/openowner.png'),
                  fit:BoxFit.cover
              ),
            )
        )
    );
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
}

class TradedBtn extends AnimatedWidget{
  TradedBtn({Key key,Animation<double> animation}):super(key:key,listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
        margin: EdgeInsets.only(top: animation.value),
        child:RaisedButton(
            onPressed: (){
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenOwnerPage()));
              _onCloseAlertPressed(context);
            },
            color: Colors.transparent,
            elevation: 0,
            disabledElevation: 0,
            highlightColor: Colors.transparent,
            highlightElevation: 0,
            splashColor: Colors.transparent,
            disabledColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child:Image(
                  width: 353,
                  height:110,
                  image: AssetImage('images/traded.png'),
                  fit:BoxFit.cover
              ),
            )
        )
    );
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
}
