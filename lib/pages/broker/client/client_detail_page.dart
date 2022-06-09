import 'dart:convert';
import 'package:ThumbSir/dao/delete_customer_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/my_client_page.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/client_action_msg.dart';
import 'package:ThumbSir/widget/client_basic_msg.dart';
import 'package:ThumbSir/widget/client_deal_msg.dart';
import 'package:ThumbSir/widget/client_need_msg.dart';
import 'package:ThumbSir/widget/client_work_action_msg.dart';
import 'package:ThumbSir/widget/traded_action_msg.dart';
import 'package:ThumbSir/widget/traded_basic_msg.dart';
import 'package:ThumbSir/widget/traded_deal_msg.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientDetailPage extends StatefulWidget {
  final item;
  final tabIndex;

  ClientDetailPage({Key key,
    this.item,this.tabIndex
  }):super(key:key);
  @override
  _ClientDetailPageState createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> with TickerProviderStateMixin {
  bool _loading = false;

  TabController _controller;
  //0基本信息，1需求描述，2业务动作，3成交信息，4维护动作的Tab Index
  int tabIndex=0;
  var tabs = [];

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
  }

  @override
  void initState() {
    _getUserInfo();
    tabIndex = widget.tabIndex;
    _controller = TabController(length: 5,vsync: this);
    tabs = <Tab>[
      Tab(text: '基本信息',),
      Tab(text: '需求描述',),
      Tab(text: '业务动作',),
      Tab(text: '成交信息',),
      Tab(text: '维护动作',),
    ];
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[
              // 切换页面
              TabBarView(
                controller: _controller,
                children: <Widget>[
                  // 基本信息
                  ClientBasicMsg(
                    item:widget.item
                  ),
                  // 需求信息
                  ClientNeedMsg(
                      item:widget.item
                  ),
                  // 业务动作
                  ClientWorkActionMsg(
                    item:widget.item,
                    result:result,
                  ),
                  // 成交信息
                  ClientDealMsg(
                    item:widget.item,
                  ),
                  // 维护动作
                  ClientActionMsg(
                      item:widget.item
                  ),
                ],
              ),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    // 导航栏
                    Container(
                        padding: EdgeInsets.only(left: 15,top: 20,bottom: 5),
                        margin: EdgeInsets.only(top: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // 首页和标题
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    if (userData.userLevel.substring(0, 1) == "6") {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => MyClientPage()));
                                    }
                                    if (userData.userLevel.substring(0, 1) == "4") {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => STradedPage()));
                                    }
                                    if (userData.userLevel.substring(0, 1) == "5") {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => MTradedPage()));
                                    }
                                  },
                                  child: Container(
                                    width: 28,
                                    padding: EdgeInsets.only(top: 3),
                                    child: Image(image: AssetImage('images/back.png'),),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(widget.item.userName+'的详细信息',style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                _deleteAlertPressed(context);
                              },
                              child: Container(
                                width:50,
                                child: Text(
                                  "删除",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    // 切换标签
                    Container(
                      alignment: Alignment.topCenter,
                      child: TabBar(
                        tabs: tabs,
                        onTap: (i){
                          setState(() {
                            tabIndex=i;
                          });
                        },
                        controller: _controller,
                        isScrollable: true, // 可以左右滑动
                        labelColor: Color(0xFF333333),
                        labelPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: tabIndex == 0? Color(0xFF0E7AE6)
                                :tabIndex == 1? Color(0xFF24CC8E)
                            :tabIndex == 2?Color(0xFFF67818):
                                tabIndex == 3?Color(0xFF7412F2):
                            Color(0xFF003273),
                            width: 3,
                          ),
                          insets: EdgeInsets.only(bottom: 10),
                        ),
                        labelStyle: TextStyle(fontSize: 20),
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )

            ]
        )
    );
  }
  _deleteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否确定删除用户"+widget.item.userName+"?",
      desc: "删除后该用户的信息将无法找回，请谨慎操作",
      buttons: [
        DialogButton(
          child: Text(
            "确定删除",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            var deleteResult = await DeleteCustomerDao.deleteCustomer(
              widget.item.mid.toString()
            );
            if (deleteResult.code == 200) {
              if (userData.userLevel.substring(0, 1) == "6") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyTradedPage()));
              }
              if (userData.userLevel.substring(0, 1) == "4") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => STradedPage()));
              }
              if (userData.userLevel.substring(0, 1) == "5") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MTradedPage()));
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
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
}
