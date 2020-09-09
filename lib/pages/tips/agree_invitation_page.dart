import 'package:ThumbSir/dao/confirm_add_member_dao.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AgreeInvitationPage extends StatefulWidget {
  final item;
  AgreeInvitationPage({this.item});
  @override
  _AgreeInvitationPageState createState() => _AgreeInvitationPageState();
}

class _AgreeInvitationPageState extends State<AgreeInvitationPage> {
  final TextEditingController phoneNumController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          // 背景
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image:AssetImage('images/blue_circle.png'),
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
                                  Navigator.popAndPushNamed(context, 'tips');
                                },
                                child: Image(image: AssetImage('images/back_white.png'),),
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
                                    '职位邀请',
                                    style:TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
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
                  Container(
                    width: 335,
                    height: 310,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                      )],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20,bottom: 30),
                          child: Text(
                            widget.item.msgContent,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Text(
                          '同意后即可建立上下级关联',
                          style: TextStyle(
                          fontSize: 16,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          '不同意请忽略此消息',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      // 接受邀请
                      GestureDetector(
                        onTap: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var userID= prefs.getString("userID");
                          if(userID != null){
                            if(widget.item.msgContent.substring(widget.item.msgContent.length-2,widget.item.msgContent.length-1) == '上'){
                              var confirmResult = await ConfirmAddMemberDao.confirmMember(userID, widget.item.fromUser);
                              if(confirmResult.code == 200){
                                _onLoadAlert(context);
                              }else{
                                _overLoadAlert(context);
                              }
                            }
                            if(widget.item.msgContent.substring(widget.item.msgContent.length-2,widget.item.msgContent.length-1) == '下'){
                              var confirmResult = await ConfirmAddMemberDao.confirmMember(widget.item.fromUser,userID);
                              if(confirmResult.code == 200){
                                _onLoadAlert(context);
                              }else{
                                _overLoadAlert(context);
                              }
                            }
                          }
                        },
                        child: Container(
                          width: 295,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF5580EB)),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF5580EB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text('接受邀请',style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.center,),
                          )
                        ),
                      )
                  ]
                  )
                )],
              )
        ]),
      ));
  }
  _onLoadAlert(context) {
    Alert(
      type: AlertType.success,
      context: context,
      title: "操作成功",
      desc: "去个人中心查看",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home()), (route) => route == null
            );
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }

  _overLoadAlert(context) {
    Alert(
      type: AlertType.error,
      context: context,
      title: "没有挂载成功",
      desc: "请检查网络情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home()), (route) => route == null
            );
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
