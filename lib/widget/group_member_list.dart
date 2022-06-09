import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_next_level_users_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/mycenter/change_member_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupMemberList extends StatefulWidget {
  final myMsg;
  GroupMemberList({this.myMsg});
  @override
  _GroupMemberListState createState() => _GroupMemberListState();
}

class _GroupMemberListState extends State<GroupMemberList> {
  var getNextLevelUsersResult;
  bool hasMember = false;
  var membersResult;
  List<Widget> members = [];

  _load()async{
    getNextLevelUsersResult = await GetNextLevelUsersDao.getNextLevelUsers(widget.myMsg.userPid);
    if(getNextLevelUsersResult != null){
      if(getNextLevelUsersResult.code == 200 && getNextLevelUsersResult.data.length != 0){
        setState(() {
          hasMember = true;
          membersResult = getNextLevelUsersResult.data;
        });
      }else{
        setState(() {
          hasMember = false;
        });
      }
    }else{
      setState(() {
        hasMember = false;
      });
    }
  }

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    this.setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
    _getUserInfo();
  }

  // 下级成员列表
  Widget brokersItem(){
    Widget content;
    if(membersResult != null && getNextLevelUsersResult.data != []){
      for(var item in membersResult) {
        members.add(
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
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
                        borderRadius: BorderRadius.circular(45),
                        child: item.headImg == null?
                        Image(
                          image: AssetImage('images/my_big.png')
                        ):Image(image: NetworkImage(item.headImg),),
                      )
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
                              item.isVip == true?
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Image(image: AssetImage('images/vip_yellow.png'),),
                              ):Container(width: 1,)
                            ],
                          ),
                          Container(
                            width: 150,
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              item.phone,
                              style:TextStyle(
                                fontSize: 10,
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
              ],
            ),
          ),
        );
      }
    }
    content =Column(
      children: members,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      margin: EdgeInsets.only(left: 8,right: 8),
      child: Column(
        children: <Widget>[
          // 组名
          Container(
            margin: EdgeInsets.only(bottom: 25,top: 5),
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
                        padding: EdgeInsets.only(top: 16,left: 10),
                        child: Text(
                          '区域',
                          style:TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        widget.myMsg.section,
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
          // 店长
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
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
                                border: Border.all(color: Color(0xFF24CC8E),width: 1)
                            ),
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: widget.myMsg.headImg == null?
                              Image(
                                image: AssetImage('images/my_big.png')
                              ):Image(image: NetworkImage(widget.myMsg.headImg),),
                            )
                          ),
                          Positioned(
                            top: 60,
                            left: 10,
                            child: Container(
                              width: 60,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF24CC8E),width: 1),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top:2,left:5,right: 5),
                                child: Text(
                                  widget.myMsg.userLevel.substring(2,),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF24CC8E),
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
                                widget.myMsg.userName,
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              widget.myMsg.isVip == true?
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Image(image: AssetImage('images/vip_yellow.png'),),
                              ):Container(width: 1,)
                            ],
                          ),
                          Container(
                            width: 150,
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              widget.myMsg.phone,
                              style:TextStyle(
                                fontSize: 10,
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
                GestureDetector(
                  onTap: () async {
                    if((int.parse(userData!.userLevel.substring(0,1))+1) == int.parse(widget.myMsg.userLevel.substring(0,1))){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeMemberPage(
                        msg:widget.myMsg,
                      )));
                    }else{
                      _onOtherMemberAlertPressed(context);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("更换",style:TextStyle(
                      fontSize: 14,
                      color: Color(0xFF93C0FB),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                ),
              ],
            ),
          ),
          // 成员列表
          hasMember != false?
          brokersItem()
              :
          Container(
              margin: EdgeInsets.only(top: 50),
              width: 335,
              height: 104,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(
                      color: Color(0xFFcccccc),
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
                  )
                  ],
                  color: Colors.white
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25,bottom: 8),
                    child: Text(
                      '还没有下级成员',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        color: Color(0xFFCCCCCC),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    '成员与直属上下级建立联接后才能显示哦',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      color: Color(0xFFCCCCCC),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
  _onOtherMemberAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "抱歉，无法更换该成员",
      desc: "您仅能更换比您低一层级的直属下级",
      buttons: [
        DialogButton(
            child: Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.pop(context);},
            color: Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
}


