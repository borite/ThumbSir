import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dao/get_next_level_users_dao.dart';
import '../model/login_result_data_model.dart';
import '../pages/mycenter/change_member_page.dart';
import '../pages/mycenter/s_center_group_detail_page.dart';
import '../pages/mycenter/z_center_group_detail_page.dart';

class TeamsMemberList extends StatefulWidget {
  final myMsg;
  const TeamsMemberList({Key? key, this.myMsg}) : super(key: key);
  @override
  _TeamsMemberListState createState() => _TeamsMemberListState();
}

class _TeamsMemberListState extends State<TeamsMemberList> {
  dynamic getNextLevelUsersResult;
  bool hasMember = false;
  dynamic membersResult;
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
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _load();
  }

  // 下级成员列表
  Widget memberItem(){
    Widget content;
    if(membersResult != null && getNextLevelUsersResult.data != []){
      for(var item in membersResult) {
        members.add(
          GestureDetector(
            onTap: (){
              widget.myMsg.userLevel.substring(0,1) == '4'?
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SCenterGroupDetailPage(
                myMsg : item,
              )))
                  :
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ZCenterGroupDetailPage(
                myMsg : item,
              )));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.only(right: 15),
              width: 335,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(
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
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          color: const Color(0xFF93C0FB),
                          border: Border.all(color: const Color(0xFFCCCCCC),width: 1),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            (members.length+1).toString(),
                            style:const TextStyle(
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
                        margin: const EdgeInsets.only(left: 20),
                        width: 200,
                        child: Text(
                          getNextLevelUsersResult.data == null || item.section == null || item.userName == null?'':item.section+'（ '+item.userName+' ）',
                          style:const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF666666),
                      size: 16
                  )
                ],
              ),
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
      margin: const EdgeInsets.only(left: 8,right: 8),
      child: Column(
        children: <Widget>[
          // 组名
          Container(
            margin: const EdgeInsets.only(bottom: 40,top: 5),
            width: 335,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color:const Color(0xFF6E85D3),width: 2),
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Color(0xFF6E85D3),
                      ),
                      child:const Padding(
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
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.myMsg.section,
                        style:const TextStyle(
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
          // 负责人
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(45)),
                              color: Colors.white,
                              border: widget.myMsg.userLevel.substring(0,1) == '2'?
                              Border.all(color: const Color(0xFF7412F2),width: 1) // 副总经理深紫色
                              :widget.myMsg.userLevel.substring(0,1) == '3'?
                              Border.all(color: const Color(0xFF9149EC),width: 1) // 总监浅紫色
                                  :
                              Border.all(color: const Color(0xFFFF9600),width: 1), // 商圈经理橘色
                          ),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: widget.myMsg.headImg == null?
                            const Image(
                            image: AssetImage('images/my_big.png'),
                          ):
                            Image(image: NetworkImage(widget.myMsg.headImg)),
                          )
                        ),
                        Positioned(
                          top: 60,
                          left: 10,
                          child: Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                                border: widget.myMsg.userLevel.substring(0,1) == '2'?
                                Border.all(color: const Color(0xFF7412F2),width: 1) // 副总经理深紫色
                                    :widget.myMsg.userLevel.substring(0,1) == '3'?
                                Border.all(color: const Color(0xFF9149EC),width: 1) // 总监浅紫色
                                    :
                                Border.all(color: const Color(0xFFFF9600),width: 1), // 商圈经理橘色
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(5))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:2,left:5,right: 5),
                              child: Text(
                                widget.myMsg.userLevel.substring(2,),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: widget.myMsg.userLevel.substring(0,1) == '2'?
                                  const Color(0xFF7412F2) // 副总经理深紫色
                                    :widget.myMsg.userLevel.substring(0,1) == '3'?
                                  const Color(0xFF9149EC) // 总监浅紫色
                                  :
                                  const Color(0xFFFF9600), // 商圈经理橘色
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
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 150,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                widget.myMsg.userName,
                                style:const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              widget.myMsg.isVip == true?
                              Container(
                                margin: const EdgeInsets.only(left: 6),
                                width: 14,
                                height: 14,
                                child: const Image(image: AssetImage('images/vip_yellow.png'),),
                              ):Container(width: 1,)
                            ],
                          ),
                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              widget.myMsg.phone,
                              style:const TextStyle(
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
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("更换",style:TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6E85D3),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                ),
              ],
            ),
          ),
          // 列表
          hasMember != false?
          memberItem()
          :
          Container(
              margin: const EdgeInsets.only(top: 50),
              width: 335,
              height: 104,
              child: Column(
                children: const <Widget>[
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
            child: const Text(
              "知道了",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){Navigator.pop(context);},
            color: const Color(0xFF5580EB)
        ),
      ],
    ).show();
  }
}


