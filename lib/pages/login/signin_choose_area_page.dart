import 'dart:convert';
import 'package:ThumbSir/dao/add_leader_dao.dart';
import 'package:ThumbSir/dao/get_leader_dao.dart';
import 'package:ThumbSir/dao/get_section_list_dao.dart';
import 'package:ThumbSir/dao/send_message_dao.dart';
import 'package:ThumbSir/dao/un_bind_member_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/dao/set_section_dao.dart';
import 'package:ThumbSir/dao/finish_reg_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SigninChooseAreaPage extends StatefulWidget {
  String selValue;
  String companyId;
  int companyLevelCount;
  SigninChooseAreaPage({this.selValue,this.companyId,this.companyLevelCount});
  @override
  _SigninChooseAreaPageState createState() => _SigninChooseAreaPageState(selValue,companyId,companyLevelCount);
}

class _SigninChooseAreaPageState extends State<SigninChooseAreaPage> {
  final TextEditingController levelOneController = TextEditingController();
  final TextEditingController levelTwoController = TextEditingController();

  String companyID; // 原来的公司id

  String selValue;
  String companyId;
  int companyLevelCount;
  _SigninChooseAreaPageState(this.selValue,this.companyId,this.companyLevelCount);

  int previousLevelCount;
  var previousLevel;
  int currentLevelCount;
  var currentLevel;

  String previousSelectedItem;
  String currentSelectedItem;

  var userId;
  var leaderId;
  var leaderName;

  bool autovalidate = false;

  List<String> currentSections;
  List<String> previousSections;
  final list = <String>[];



  _load() async {
    previousLevelCount = int.parse(selValue.substring(0,1))-1;
    previousLevel = previousLevelCount.toString();
    currentLevelCount = int.parse(selValue.substring(0,1));
    currentLevel = currentLevelCount.toString();
    // 获取本级区域列表
    var current = await GetSectionListDao.httpGetSectionList(companyId,currentLevel);
    // 获取上一级区域列表
    var previous = await GetSectionListDao.httpGetSectionList(companyId,previousLevel);
    currentSections = current.data;
    previousSections = previous.data;
  }

  LoginResultData userData;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    userId=prefs.getString("userID");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uinfo));
      });
    }
  }

  @override
  void initState() {
    _load();
    _getUserInfo();
    super.initState();
  }


  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
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
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                            ],
                          )
                      ),
                      // 头像按钮
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment(-1,-1),
                            margin: EdgeInsets.only(top: 8,left: 37),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(45)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                          color: Color(0xFFcccccc),
                                          offset: Offset(0.0, 3.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0
                                      )],
                                    ),
                                    child:Image(
                                      image: AssetImage('images/tie.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '设置区域',
                                    style:TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF333333),
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
                      7-widget.companyLevelCount != currentLevelCount?
                      // 填写区域1
                      Padding(
                        padding: EdgeInsets.only(top:20,left: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color(0xFF93C0FB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: currentLevel == '6'?Color(0xFF93C0FB):Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('上一级的管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ):Text(''),
                      7-widget.companyLevelCount != currentLevelCount?
                      // 输入上一级区域
                      Container(
                        width: 335,
                        height: 150,
                        margin: EdgeInsets.only(top: 10),
                        child: Form(
                          autovalidate: autovalidate,
                          child: Column(children: <Widget>[
                            SimpleAutocompleteFormField<String>(
                              controller: levelOneController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                border: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: currentLevel == '2'? "例如：北京市"
                                    :currentLevel == '3'? "例如：京中事业部"
                                    :currentLevel == '4'? "例如：王府井大区"
                                    :currentLevel == '5'? "例如：王府井店"
                                    :currentLevel == '6'? "例如：买卖1组"
                                    :''
                              ),
//                            suggestionsHeight: 200.0,
                              maxSuggestions: 2,
                              itemBuilder: (context, listItem) => Padding(
                                padding: EdgeInsets.only(top: 5,left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Image(image: AssetImage("images/choose.png"),),
                                            ),
                                            Text(
                                              listItem,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF5580EB)
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              onSearch: (search) async => previousSections.where((person) => person.toLowerCase()
                                  .contains(search.toLowerCase())).toList(),
                              itemFromString: (string) => previousSections.singleWhere(
                                      (listItem) => listItem.toLowerCase() == string.toLowerCase(),
                                  orElse: () => null),
                              onChanged: (value) {
                                setState(() {
                                  previousSelectedItem = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  previousSelectedItem = value;
                                });
                              },
                              validator: (listItem) => listItem == null ? '请输入上一级管辖区域' : null,
                            ),
                          ]),
                        ),
                      ):Text(''),
                      // 填写上级区域
                      currentLevelCount != 6?
                      Padding(
                        padding: EdgeInsets.only(top:20,left: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color(0xFF93C0FB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: currentLevel == '1'?Color(0xFF93C0FB):Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('您的管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ):Text(''),
                      // 输入本级区域
                      currentLevelCount != 6?
                      Container(
                        width: 335,
                        height: 150,
                        margin: EdgeInsets.only(top: 10),
                        child: Form(
                          autovalidate: autovalidate,
                          child: Column(children: <Widget>[
                            SimpleAutocompleteFormField<String>(
                              controller: levelTwoController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                border: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: currentLevel == '1'? "例如：北京市"
                                    :currentLevel == '2'? "例如：京中事业部"
                                    :currentLevel == '3'? "例如：王府井大区"
                                    :currentLevel == '4'? "例如：王府井店"
                                    :currentLevel == '5'? "例如：买卖1组"
                                    :'',
                              ),
//                            suggestionsHeight: 200.0,
                              maxSuggestions: 2,
                              itemBuilder: (context, listItem) => Padding(
                                padding: EdgeInsets.only(top: 5,left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Image(image: AssetImage("images/choose.png"),),
                                            ),
                                            Text(
                                              listItem,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF5580EB)
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              onSearch: (search) async => currentSections.where((person) => person.toLowerCase()
                                  .contains(search.toLowerCase())).toList(),
                              itemFromString: (string) => currentSections.singleWhere(
                                      (listItem) => listItem.toLowerCase() == string.toLowerCase(),
                                  orElse: () => null),
                              onChanged: (value) {
                                setState(() {
                                  currentSelectedItem = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  currentSelectedItem = value;
                                });
                              },
                              validator: (listItem) => listItem == null ? '请输入您的管辖区域' : null,
                            ),
                          ]),
                        ),
                      ):Text(''),
                      // 完成
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 60),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFF5580EB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: () async {
                                // 如果是最高级
                                if(7-companyLevelCount == currentLevelCount){
                                  // 自己的管辖区域没填
                                  if( levelTwoController.text == ''){
                                    _onCurrentEmptyAlertPressed(context);
                                  }else{
                                    if(userData != null && userData.companyId != null && userData.userLevel != null){
                                      await UnBindMemberDao.unbind(userId, userData.userLevel.substring(0,1), userData.companyId);
                                    }
                                    var regResult = await finishRegDao.httpPostFinishReg(userId, widget.companyId, selValue, levelTwoController.text );
                                    if(regResult.code == 410){
                                      _onReg410AlertPressed(context);
                                    }
                                    if(regResult.code == 200){
                                      Navigator.of(context).pushAndRemoveUntil(
                                          new MaterialPageRoute(builder: (context) => new Home( )
                                          ), (route) => route == null);
                                    }
                                  }
                                }

                                // 如果是最低级
                                if(currentLevelCount == 6){
                                  // 上级区域没填
                                  if(levelOneController.text == ''){
                                    _onPreviousEmptyAlertPressed(context);
                                  }else{
                                    if(userData != null && userData.companyId != null && userData.userLevel != null){
                                      await UnBindMemberDao.unbind(userId, userData.userLevel.substring(0,1), userData.companyId);
                                    }
                                    await setSecionDao.httpPostSection(companyId, previousLevel, levelOneController.text);
                                    var regResult = await finishRegDao.httpPostFinishReg(userId, widget.companyId, selValue, levelOneController.text );
                                    if(regResult.code == 410){
                                      _onReg410AlertPressed(context);
                                    }
                                    if(regResult.code == 200){
                                      var leader = await GetLeaderDao.httpGetLeader(companyId, levelOneController.text, previousLevel);
                                      if(leader != null){
                                        // 如果有上级，且上级存在，弹窗，申请挂载
                                        if(leader.code == 200){
                                          setState(() {
                                            leaderId = leader.data.userPid;
                                            leaderName = leader.data.userName;
                                          });
                                          _onChooseLeaderAlertPressed(context);
                                        }
                                        // 如果有上级，且上级不存在，存储上级区域并跳转
                                        else{
                                          await setSecionDao.httpPostSection(companyId, previousLevel, levelOneController.text);
                                          Navigator.of(context).pushAndRemoveUntil(
                                              new MaterialPageRoute(builder: (context) => new Home( )
                                              ), (route) => route == null);
                                        }
                                      }
                                      // 如果有上级，且上级不存在，存储上级区域并跳转
                                      else{
                                        await setSecionDao.httpPostSection(companyId, previousLevel, levelOneController.text);
                                        Navigator.of(context).pushAndRemoveUntil(
                                            new MaterialPageRoute(builder: (context) => new Home( )
                                            ), (route) => route == null);
                                      }
                                    }
                                  }
                                }

                                // 如果不是最高级和最低级
                                else if(7-companyLevelCount != currentLevelCount && currentLevelCount != 6){
                                  if(levelOneController.text == ''){
                                    _onPreviousEmptyAlertPressed(context);

                                  } else if(levelTwoController.text == ''){
                                    _onCurrentEmptyAlertPressed(context);
                                  }
                                  if(levelTwoController.text != '' && levelOneController.text != ''){
                                    if(userData != null && userData.companyId != null && userData.userLevel != null){
                                      await UnBindMemberDao.unbind(userId, userData.userLevel.substring(0,1), userData.companyId);
                                    }
                                    var regResult= await finishRegDao.httpPostFinishReg(userId, widget.companyId, selValue, levelTwoController.text );
                                    if(regResult.code == 410){
                                      _onReg410AlertPressed(context);
                                    }
                                    if(regResult.code == 200 ){
                                      await setSecionDao.httpPostSection(companyId, currentLevel, levelTwoController.text);
                                      var leader = await GetLeaderDao.httpGetLeader(companyId, levelOneController.text, previousLevel);
                                      if(leader != null){
                                        // 如果有上级，且上级存在，弹窗，申请挂载
                                        if(leader.code == 200){
                                          setState(() {
                                            leaderId = leader.data.userPid;
                                            leaderName = leader.data.userName;

                                          });
                                          _onChooseLeaderAlertPressed(context);
                                        }
                                        // 如果有上级，且上级不存在，存储上级区域并跳转
                                        else{
                                          await setSecionDao.httpPostSection(companyId, previousLevel, levelOneController.text);
                                          Navigator.of(context).pushAndRemoveUntil(
                                              new MaterialPageRoute(builder: (context) => new Home( )
                                              ), (route) => route == null);
                                        }
                                      }
                                      // 如果有上级，且上级不存在，存储上级区域并跳转
                                      else{
                                        await setSecionDao.httpPostSection(companyId, previousLevel, levelOneController.text);
                                        Navigator.of(context).pushAndRemoveUntil(
                                            new MaterialPageRoute(builder: (context) => new Home( )
                                            ), (route) => route == null);
                                      }
                                    }
                                  }
                                }
                              },
                              child: Text('完成',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            ),
                          )
                      ),
                    ]
                )
              ],
            )
        ),
      );
  }
  _onPreviousEmptyAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "请填写上级管辖区域",
      buttons: [
        DialogButton(
          child: Text(
            "去填写",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){Navigator.pop(context);},
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _onCurrentEmptyAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "请填写您的管辖区域",
      buttons: [
        DialogButton(
          child: Text(
            "去填写",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){Navigator.pop(context);},
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _onChooseLeaderAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: leaderName+"可能是您的上级",
      desc: "是否申请成为他的下级，来建立上下级关系？",
      buttons: [
        DialogButton(
          child: Text(
            "申请",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            // 申请挂载上级
            if(userData != null){
              var leaderResult = await AddLeaderDao.addLeaderPost(userId, leaderId);
              if(leaderResult.code == 200){
                var sendMessageResult = await SendMessageDao.sendMessage(userData.userPid, leaderId, '上下级职位联接邀请', userData.userName+'申请成为你的下级', '2');
                if(sendMessageResult.code == 200){
                  _onLeaderResult200AlertPressed(context);
                }else{
                  _onLeaderResult400AlertPressed(context);
                }
              }else if(leaderResult.code == 410){
                _onResult410AlertPressed(context);
              }else{
                _onLeaderResult400AlertPressed(context);
              }
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "不申请",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _onReg410AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "您填写的区域名称已被使用",
      desc: "请使用其他区域名称或使用上级区域名称+本级区域名称的形式，例如xxx店xxx组。",
      content: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          "如果因为降级造成此结果，请先使用其他区域名称，修改成功后在个人中心寻找和匹配上级或让上级对您发出职位联接邀请，即可根据上级区域自动变更区域名称。",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){Navigator.pop(context);},
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }

  _onLeaderResult200AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "挂载求情已发送",
      desc: "对方的消息中心会收到您的申请，请提醒对方查看，待对方同意后即可建立联接",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }

  _onLeaderResult400AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "联接邀请发送失败",
      desc: "请检查网络连接情况，稍后重试",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
  _onResult410AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "联接邀请发送失败",
      desc: "您已给对方发送过上下级联接请求，请提醒对方查看消息中心。",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home( )
                ), (route) => route == null);
            },
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
}
