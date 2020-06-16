import 'dart:convert';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:ThumbSir/pages/mycenter/broker_center_group_page.dart';
import 'package:ThumbSir/pages/mycenter/s_center_group_page.dart';
import 'package:ThumbSir/pages/mycenter/service_page.dart';
import 'package:ThumbSir/pages/mycenter/set_page.dart';
import 'package:ThumbSir/pages/mycenter/vip_page.dart';
import 'package:ThumbSir/pages/mycenter/z_center_group_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'choose_portrait_page.dart';
import 'm_center_group_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyCenterPage extends StatefulWidget {
  @override
  _MyCenterPageState createState() => _MyCenterPageState();
}

class _MyCenterPageState extends State<MyCenterPage> {
  var portrait;
  LoginResultData userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  int exT;
  String uinfo;
  var result;
  _getUserInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      exT = result.exTokenTime.millisecondsSinceEpoch; // token时间转时间戳
      if(exT >= _dateTime){
        this.setState(() {
          userData=LoginResultData.fromJson(json.decode(uinfo));
        });
      }else{
        _onLogoutAlertPressed(context);
      }
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          userData != null ?
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPage()));
                            },
                            child: Image(image: AssetImage('images/set.png')),
                          ):Container(width: 2,),
                        ],
                      )
                  ),
                  userData != null ?
                  // 头像按钮
                  Column(
                    children: <Widget>[
                      // 头像
                      GestureDetector(
                        onTap: () {
                          if(userData == null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          }else{
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ChoosePortraitPage())).then((p){
                              setState(() {
                                portrait = p;
                              });
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 8,left: 35),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
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
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: portrait == null ?
                                      Image(image: AssetImage('images/my_big.png'),)
                                          :
                                      Image.file(portrait,fit: BoxFit.fill,),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10,left: 30),
                        child:Row(
                          children: <Widget>[
                            Text(
                              userData.userName,
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            userData.userLevel.substring(0,1)== '6' ?
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF0E7AE6),width: 1), // 经纪人蓝色
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                userData.userLevel.substring(2,),
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0E7AE6), // 经纪人蓝色
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                            :
                            userData.userLevel.substring(0,1) == '5'?
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF24CC8E),width: 1), // 店长绿色
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                userData.userLevel.substring(2,),
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF24CC8E), // 店长绿色
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                                :
                            userData.userLevel.substring(0,1) == '4'?
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFFF9600),width: 1), // 商圈经理橘色
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                userData.userLevel.substring(2,),
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFF9600), // 商圈经理橘色
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                                :
                            userData.userLevel.substring(0,1) == '3'?
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF9149EC),width: 1), // 总监浅紫色
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                userData.userLevel.substring(2,),
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF9149EC), // 总监浅紫色
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                                :
                            userData.userLevel.substring(0,1) == '2'?
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF7412F2),width: 1), // 副总经理深紫色
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                userData.userLevel.substring(2,),
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF7412F2), // 副总经理深紫色
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                                :
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF003273),width: 1), // 总经理深蓝色
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                userData.userLevel.substring(2,),
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF003273), // 总经理深蓝色
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
//                            onTap: (){
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>VipPage()));
//                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 30,bottom: 50),
                              child: Text(
//                                '已付费至2021年3月15日，查看详情',
                                '推广期免费，感谢支持！',
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                  :
                  // 头像按钮
                  Container(
                    alignment: Alignment(-1,-1),
                    margin: EdgeInsets.only(top: 8,left: 25,bottom: 60),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                          child: Container(
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
                                image: AssetImage('images/my_big.png'),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text(
                            '未登录',
                            style:TextStyle(
                              fontSize: 20,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child: Text(
                            '请点击头像登录/注册',
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
                  ),
                  // 详情菜单
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/company.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  userData == null ? "所属公司": userData.companyName,
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/site.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  userData == null ?"所在地区": userData.province+' '+userData.city,
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20,right: 20),
                          child: GestureDetector(
                            onTap: (){
                              if(userData != null){
                                if(userData.userLevel.substring(0,1) == '6'){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BrokerCenterGroupPage())); // 经纪人
                                }else if(userData.userLevel.substring(0,1) == '5'){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MCenterGroupPage())); // 店长
                                }else if(userData.userLevel.substring(0,1) == '4'){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SCenterGroupPage())); // 商圈
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ZCenterGroupPage())); // 总监及以上
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image(image: AssetImage('images/group.png')),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        userData == null ?"所在区域及成员": userData.section+"成员",
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/phone.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  userData == null ?"联系电话": userData.phone,
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 会员中心
                        GestureDetector(
                          onTap: (){
                            if(userData != null){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>VipPage()));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20,right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      child: Image(image: AssetImage('images/vip.png'),fit: BoxFit.fill,),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '会员中心',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),
                        ),
                        // 客服中心
                        GestureDetector(
                          onTap: (){
                            if(userData != null){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ServicePage()));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20,right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image(image: AssetImage('images/service.png')),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        '客服中心',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            )
          ],
        )
    );
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
