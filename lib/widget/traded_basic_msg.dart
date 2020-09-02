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


class TradedBasicMsg extends StatefulWidget {
  @override
  _TradedBasicMsgState createState()=> _TradedBasicMsgState();
}

class _TradedBasicMsgState extends State<TradedBasicMsg> with SingleTickerProviderStateMixin{
  
  @override
  void initState(){
    super.initState();
  }

  int star=1;


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
                    // 基本信息
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "基本信息：",
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
                    // 星级
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "重要度：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: star == 0 ?
                              Image(image: AssetImage('images/star1_e.png'),
                                fit: BoxFit.fill,) :
                              Image(image: AssetImage('images/star1_big.png'),
                                fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: star == 2 ?
                              Image(image: AssetImage('images/star2_big.png'),
                                fit: BoxFit.fill,)
                                  : star == 3 ?
                              Image(image: AssetImage('images/star2_big.png'),
                                fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star2_e.png'),
                                fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: star == 3 ?
                              Image(image: AssetImage('images/star3_big.png'),
                                fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star3_e.png'),
                                fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                    ),
                    // 电话
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "电话：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "15012242232",
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
                    // 生日
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "生日：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "1993-01-23",
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
                    // 年龄
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "年龄：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "35",
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
                    // 性别
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "性别：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "男",
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
                    // 职业
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "职业：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "建筑工程师",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 年收入
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "年收入：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "500万-1000万",
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
                    // 住址
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "住址：",
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
                    // 个人爱好
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "个人爱好：",
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
                    // 家庭成员
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "家庭成员：",
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
                    // 家庭成员-儿子
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "儿子 — ",
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
                    // 家庭成员-儿子
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "儿子 — ",
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
                    // 描述
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "描述：",
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
                    // 描述详情
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 50),
                      child: Text(
                        "分动器分蘖强化复合防护等级化肥发黑哈哈粉底和废物和飞机返回IQ维护覅金额环境覅",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
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
