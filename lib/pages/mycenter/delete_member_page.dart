import 'dart:convert';
import 'package:ThumbSir/dao/un_bind_member_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DeleteMemberPage extends StatefulWidget {
  final item;
  DeleteMemberPage({this.item});
  @override
  _DeleteMemberPageState createState() => _DeleteMemberPageState();
}

class _DeleteMemberPageState extends State<DeleteMemberPage> {
  LoginResultData? userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  late int exT;
  late String uInfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    result =loginResultDataFromJson(uInfo);
    exT = result.exTokenTime.millisecondsSinceEpoch; // token时间转时间戳
    if(exT >= _dateTime){
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uInfo));
      });
    }else{
      _onLogoutAlertPressed(context);
    }
  }
  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle_middle.png'),
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
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('移出成员',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                  ),
                  // 头像
                  Container(
                    margin: EdgeInsets.only(top: 43),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFF93C0FB),width: 1)
                      ),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: widget.item.headImg != null ?
                        Image(image:NetworkImage(widget.item.headImg))
                            :Image(image: AssetImage('images/my_big.png'),),
                      ),
                    ),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 30,bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF93C0FB)))
                    ),
                    child: Text(
                      widget.item != null ? widget.item.userName:'',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5580EB),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                    ),),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 30,bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF93C0FB)))
                    ),
                    child: Text(
                      widget.item != null ? widget.item.phone:'',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5580EB),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                    ),),
                  ),
                  // 备注
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text('温馨提示',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text('移出成员功能可以将下级移出您所属的区域，确认移出后将解除该成员的所有上下级连接，且该成员须重新填写区域，请慎重操作。移出成员后如果想再次与该成员组成上下级连接，须由该成员的直属上级在个人中心的小组成员中添加该成员。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 确认移出
                  GestureDetector(
                    onTap: () => _onDeleteAlertPressed(context),
                    child: Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 80),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF5580EB)
                      ),
                      child: Text('确认移出',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),textAlign: TextAlign.center,),
                    ),
                  ),
                ]
            )
          ],
        )
    );
  }
  _onDeleteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否移出成员？",
      desc: "移出成员后该成员将被解除所有组织关系，请慎重选择！",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            if(userData!= null){
              var deleteMemberResult = await UnBindMemberDao.unbind(widget.item.userPid, widget.item.userLevel.substring(0,1), userData!.companyId);
              if(deleteMemberResult.code == 200){
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(builder: (context) => new Home()
                    ), (route) => route == null
                );
              }
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        )
      ],
    ).show();
  }
  _onLogoutAlertPressed(context) {
    Alert(
      context: context,
      title: "需要重新登录",
      desc: "长时间未进行登录操作，需要重新登录验证",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("userInfo");
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home()
                ), (route) => route == null
            );
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
}
