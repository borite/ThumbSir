import 'dart:convert';

import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_invited_user_dao.dart';
import 'package:ThumbSir/dao/get_inviter_dao.dart';
import 'package:ThumbSir/dao/update_invite_code_dao.dart';
import 'package:ThumbSir/model/get_inviter_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitationCodePage extends StatefulWidget {
  @override
  _InvitationCodePageState createState() => _InvitationCodePageState();
}

class _InvitationCodePageState extends State<InvitationCodePage> {
  final TextEditingController inviterController=TextEditingController();

  int code = 1; // 是否已输入过邀请码
  int friend = 1; // 是否有用户输入过自己的邀请码
  var inviter;
  var inviteFriendMsg;

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
      if(userData != null){
        _load();
      }
    }
  }

  _load()async{
    var inviterResult = await GetInviterDao.getInviter(userData.userPid);
    if(inviterResult.code == 200){
      setState(() {
        code = 1;
        inviter = inviterResult.data;
      });
    }
    if(inviterResult.code == 404){
      setState(() {
        code = 0;
      });
    }

    var inviteFriendResult = await GetInvitedUserDao.getInvitedUser(userData.inviteCode,1,20);
    if(inviteFriendResult.code == 200){
      setState(() {
        inviteFriendMsg = inviteFriendResult.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            // 内容
            Container(
              child: ListView(
                children: <Widget>[
                  // 标题
                  Container(
                    margin:EdgeInsets.only(top: 80,bottom: 20),
                    width: 335,
                    child: Text('我的邀请码：',style:TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5580EB),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
                  ),
                  // 邀请码
                  Container(
                    width: 335,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          userData != null && userData.inviteCode != null ? userData.inviteCode:'',
                          style:TextStyle(
                            fontSize: 28,
                            color: Color(0xFF5580EB),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                        ),textAlign: TextAlign.center,),
                        Container(
                          width: 40,
                          height: 20,
                          padding: EdgeInsets.only(top: 2),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF5580EB),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Clipboard.setData(ClipboardData(text: '963123'));
                              _onPasteAlertPressed(context);
                            },
                            child: Text("复制",style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.center,),
                          ),
                        )
                      ],
                    )
                  ),
                  // 邀请好友个数和增加vip天数
                  Container(
                    height: 100,
                    margin: EdgeInsets.fromLTRB(30, 30, 30, 50),
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap:(){
//                            _onFriendAlertPressed(context);
                          },
                          child: Container(
                            width: 160,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  inviteFriendMsg != null ? inviteFriendMsg.tcount.toString():'',
                                  style:TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(
                                    '邀请好友',
                                    style:TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Color(0xFFCCCCCC),
                        ),
                        Container(
                          width: 160,
                          child: Column(
                            children: <Widget>[
                              Text(
                                inviteFriendMsg != null ? ((inviteFriendMsg.tcount)*3).toString():'',
                                style:TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  '增加会员天数',
                                  style:TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 邀请奖励说明title
                  Container(
                    width: 335,
                    child: Text('邀请奖励说明',style:TextStyle(
                      fontSize: 20,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
                  ),
                  // 邀请奖励说明详情
                  Container(
                    width: 335,
                    margin: EdgeInsets.only(top: 20,left: 30,right: 30),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '1.您可将您的邀请码分享给好友，您的好友注册登录拇指先生APP后，进入个人中心-会员中心-我的邀请页面，点击右上方"输入邀请码"，输入您的邀请码，成功后您可免费获得3天会员期。',
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '2.每邀请一位好友，您均可免费增加3天会员期限，此活动无上限。',
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '3.每一位受邀请人在下次付费前只能输入一次邀请码，如果输入邀请码失败请联系客服。',
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
            // 顶部导航区域
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF5580EB),
                image: DecorationImage(
                  image:AssetImage('images/circle.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child:Container(
                height: 80,
                padding: EdgeInsets.only(top: 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 90,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15),
                        child: Image(image: AssetImage('images/back_w_arrow.png'),),
                      ),
                    ),
                    Text(
                      '我的邀请',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onCodeAlertPressed(context),
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          '输入邀请码',
                          style:TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 输入邀请码的弹窗
  _onCodeAlertPressed(context) {
    code == 0 ?
    Alert(
      context: context,
      title: "输入邀请码",
      content: Column(
        children: <Widget>[
          TextField(
            controller: inviterController,
            keyboardType: TextInputType.number,
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            var inputResult = await UpdateInviteCodeDao.updateInviteCode(inviterController.text, userData.userPid);
            if(inputResult.code == 200){
              setState(() {
                code = 1;
              });
              Navigator.pop(context);
            }else if(userData.inviteCode == inviterController.text){
              _myInviteCode();
            }
            else{
              _wrongInviteCode();
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show()
    :
    Alert(
      context: context,
      title: "您已输入过邀请码",
      content: Column(
        children: <Widget>[
          Text(
            inviter != null ? inviter.userName+"已经邀请过您啦~":'',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF999999)
          ),),
          Text("下次续费后可以再次输入邀请码",style: TextStyle(
              fontSize: 14,
              color: Color(0xFF999999)
          ),)
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show()
    ;
  }
  // 邀请码错误
  _wrongInviteCode(){
    Alert(
      context: context,
      title: "邀请码不存在",
      desc: "请重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show();
  }
  // 邀请码错误
  _myInviteCode(){
    Alert(
      context: context,
      title: "不能输入自己的邀请码",
      desc: "请重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show();
  }
  // 复制邀请码成功的弹窗
  _onPasteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "邀请码复制成功",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  // 邀请好友的弹窗
  _onFriendAlertPressed(context) {
    friend == 0 ?
    Alert(
      context: context,
      type: AlertType.warning,
      title: "很遗憾",
      desc: "您的邀请码未被输入过",
      content: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            Text("邀请好友得三天免费VIP",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999)
            ),),
            Text("快去邀请好友吧~",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999)
            ),)
          ],
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show()
        :
    Alert(
      context: context,
      type: AlertType.success,
      title: "恭喜您",
      desc: "已成功邀请3位好友",
      content: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            Text("张三丰 15012345678",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999)
            ),),
            Text("王结 18635467354",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999)
            ),),
            Text("迪丽热巴 18643316784",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999)
            ),)
          ],
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show()
    ;
  }
}
