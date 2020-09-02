import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_user_select_mission_dao.dart';
import 'package:ThumbSir/model/get_user_select_mission_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ThumbSir/model/mission_record_model.dart';
import 'package:ThumbSir/dao/get_user_mission_records_dao.dart';


class TradedDealMsg extends StatefulWidget {
  @override
  _TradedDealMsgState createState()=> _TradedDealMsgState();
}

class _TradedDealMsgState extends State<TradedDealMsg> with SingleTickerProviderStateMixin{
  
  @override
  void initState(){
    super.initState();
  }


//  @override
//  void dispose(){
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:120,bottom:50),
                child: Column(
                  children: <Widget>[
                    // 姓名
                    Row(
                      children: <Widget>[
                        Container(
                          width: 20,
                          margin: EdgeInsets.only(left: 20,right: 10),
                          child: Image.asset("images/my_3.png"),
                        ),
                        Text(
                          "赵先生",
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        )
                      ],
                    ),

                    // 第一次交易
                    Column(
                      children: <Widget>[
                        // 基本信息
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "购买住宅",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 20,
                                child: Image.asset("images/editor.png"),
                              )
                            ],
                          ),
                        ),
                        // 时间
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "成交时间：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "2020-03-18",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 成交价
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "成交价：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "1085万",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 面积
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "面积：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "135.45平米",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 地址
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "地址：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "是否Joe何润锋in而好哈哈覅菲尔返回返回日合法人和ifhi加入后if红日河坊街",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    // 第二次交易
                    Column(
                      children: <Widget>[
                        // 基本信息
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "出售住宅",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 20,
                                child: Image.asset("images/editor.png"),
                              )
                            ],
                          ),
                        ),
                        // 成交时间
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "成交时间：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "2020-03-18",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 成交价
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "成交价：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "1085万",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 面积
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "面积：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "135.45平米",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 地址
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "地址：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "是否Joe何润锋in而好哈哈覅菲尔返回返回日合法人和ifhi加入后if红日河坊街",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    // 新增按钮
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 30,bottom: 50),
                        width: 335,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Color(0xFF93C0FB)
                              ),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(
                            "+ 新增成交信息",
                            style: TextStyle(
                                color: Color(0xFF93C0FB),
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ],
          )
      )
    );
  }
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
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
