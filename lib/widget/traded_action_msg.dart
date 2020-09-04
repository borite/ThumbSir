import 'dart:convert';
import 'package:ThumbSir/widget/gift_item.dart';
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


class TradedActionMsg extends StatefulWidget {
  final item;

  TradedActionMsg({Key key,
    this.item
  }):super(key:key);
  @override
  _TradedActionMsgState createState()=> _TradedActionMsgState();
}

class _TradedActionMsgState extends State<TradedActionMsg> with SingleTickerProviderStateMixin{
  
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
                width: 335,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:117,bottom:50),
                child: Column(
                  children: <Widget>[
                    // 姓名
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              margin: EdgeInsets.only(left: 20,right: 10,bottom: 10),
                              child: Image.asset("images/my_3.png"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.item.userName,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )

                          ],
                        ),
                        // 新增按钮
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                            margin: EdgeInsets.only(right: 20,top: 2,bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xFF93C0FB)
                                ),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text(
                              "+ 新增维护动作",
                              style: TextStyle(
                                  color: Color(0xFF93C0FB),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    GiftItem(
                      date:"2020-01-23",
                      giftMsg:"故宫礼盒套装",
                      price:"288",
                      dec:"邮寄",
                      type:"业务礼",
                    ),
                    GiftItem(
                      date:"2020-01-23",
                      giftMsg:"故宫礼盒套装",
                      price:"288",
                      dec:"邮寄",
                      type:"生日礼",
                    ),
                    GiftItem(
                      date:"2020-01-23",
                      giftMsg:"故宫礼盒套装",
                      price:"288",
                      dec:"邮寄",
                      type:"成交礼",
                    ),
                    GiftItem(
                      date:"2020-01-23",
                      giftMsg:"故宫礼盒套装",
                      price:"288",
                      dec:"邮寄",
                      type:"节日礼",
                    ),
                  ],
                ),
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
