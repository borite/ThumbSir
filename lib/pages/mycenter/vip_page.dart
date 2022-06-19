import 'dart:convert';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/mycenter/invitation_code_page.dart';
import 'package:ThumbSir/pages/mycenter/vip_privilege_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VipPage extends StatefulWidget {
  @override
  _VipPageState createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  final TextEditingController phoneNumController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  int viptap = 2;

  LoginResultData? userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  late int exT;
  late String uInfo;
  dynamic result;

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
    _getUserInfo();
    super.initState();
  }

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
                              Navigator.pop(context);
                            },
                            child:Row(
                              children: <Widget>[
                                Image(image: AssetImage('images/back_w_arrow.png'),),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('会员中心',style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                )
                              ],
                            ),

                          ),
                        ],
                      )
                    ),
                    // 头像
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
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: userData == null?
                                      Image(image: AssetImage('images/my_big.png'),)
                                          :userData != null && userData!.headImg != null ?
                                      Image(image:NetworkImage(userData!.headImg))
                                          :Image(image: AssetImage('images/my_big.png'),),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20,bottom: 10),
                                  child: Text(
                                    userData != null ? userData!.userName :'',
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
                    // 到期时间
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 335,
                      child: Text(
//                        '会员到期时间2020年9月1日',
                        '推广期免费，感谢支持！',
                        style:TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // 付费板
//                    Container(
//                      width: 335,
//                      height: 230,
//                      margin: EdgeInsets.only(top: 10),
//                      padding: EdgeInsets.all(20),
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                          image:AssetImage('images/vipbg.png'),
//                        ),
//                      ),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Container(
//                                width: 22,
//                                padding: EdgeInsets.only(right: 5),
//                                child: Image(image: AssetImage('images/vip_yellow.png'),),
//                              ),
//                              Text(
//                                '续费会员',
//                                style: TextStyle(
//                                  fontSize: 14,
//                                  color: Color(0xFFFF9600),
//                                  fontWeight: FontWeight.normal,
//                                  decoration: TextDecoration.none,
//                                ),
//                              ),
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              GestureDetector(
//                                onTap: (){
//                                  setState(() {
//                                    viptap = 0;
//                                  });
//                                },
//                                child: Container(
//                                  width: 95,
//                                  height: 100,
//                                  margin: EdgeInsets.only(top: 10),
//                                  decoration: viptap == 0?
//                                  BoxDecoration(
//                                    border: Border.all(color: Color(0xFFFF9600),width: 1),
//                                    borderRadius: BorderRadius.circular(8)
//                                  )
//                                  :viptap == 1?
//                                  BoxDecoration(
//                                    border: Border.all(color: Colors.white,width: 1),
//                                  )
//                                  :
//                                  BoxDecoration(
//                                    border: Border(right:BorderSide(color: Color(0xFFCCCCCC),width: 1),top:BorderSide(color: Colors.white,width: 1),left:BorderSide(color: Colors.white,width: 1)),
//                                  ),
//                                  child: Column(
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: EdgeInsets.only(top: 12,bottom: 5),
//                                        child: Text('3个月',style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xFFFF9600),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),),
//                                      ),
//                                      Text(
////                                      '￥299',
//                                        '￥0',
//                                        style: TextStyle(
//                                          fontSize: 20,
//                                          color: Color(0xFFFF9600),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                              GestureDetector(
//                                onTap: (){
//                                  setState(() {
//                                    viptap = 1;
//                                  });
//                                },
//                                child: Container(
//                                  width: 95,
//                                  height: 100,
//                                  margin: EdgeInsets.only(top: 10,left: 5,right: 5),
//                                  decoration: viptap == 1?
//                                  BoxDecoration(
//                                      border: Border.all(color: Color(0xFFFF9600),width: 1),
//                                      borderRadius: BorderRadius.circular(8)
//                                  )
//                                  :viptap == 2? BoxDecoration(
//                                    border: Border.all(color: Colors.white,width: 1),
//                                  )
//                                  :
//                                  BoxDecoration(
//                                    border: Border(right:BorderSide(color: Color(0xFFCCCCCC),width: 1),top:BorderSide(color: Colors.white,width: 1),left:BorderSide(color: Colors.white,width: 1)),
//                                  ),
//                                  child: Column(
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: EdgeInsets.only(top: 12,bottom: 5),
//                                        child: Text('6个月',style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xFFFF9600),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),),
//                                      ),
//                                      Text(
////                                      '￥549',
//                                        '￥0',
//                                        style: TextStyle(
//                                          fontSize: 20,
//                                          color: Color(0xFFFF9600),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),),
//                                      // 6个月原价
////                                    Padding(
////                                      padding: EdgeInsets.only(top: 5),
////                                      child: Text(
////                                        '￥599',
////                                        style: TextStyle(
////                                          fontSize: 14,
////                                          color: Color(0xFF999999),
////                                          fontWeight: FontWeight.normal,
////                                          decoration: TextDecoration.lineThrough,
////                                      ),),
////                                    ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                              GestureDetector(
//                                onTap: (){
//                                  setState(() {
//                                    viptap = 2;
//                                  });
//                                },
//                                child: Container(
//                                  width: 95,
//                                  height: 100,
//                                  margin: EdgeInsets.only(top: 10),
//                                  decoration: viptap == 2?
//                                  BoxDecoration(
//                                      border: Border.all(color: Color(0xFFFF9600),width: 1),
//                                      borderRadius: BorderRadius.circular(8)
//                                  )
//                                      :
//                                  BoxDecoration(
//                                    border: Border.all(color: Colors.white,width: 1),
//                                  ),
//                                  child: Column(
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: EdgeInsets.only(top: 12,bottom: 5),
//                                        child: Text('1年',style: TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xFFFF9600),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),),
//                                      ),
//                                      Text(
////                                      '￥999',
//                                        '￥0',
//                                        style: TextStyle(
//                                          fontSize: 20,
//                                          color: Color(0xFFFF9600),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),),
//                                      // 1年原价
////                                    Padding(
////                                      padding: EdgeInsets.only(top: 5),
////                                      child: Text('￥1199',style: TextStyle(
////                                        fontSize: 14,
////                                        color: Color(0xFF999999),
////                                        fontWeight: FontWeight.normal,
////                                        decoration: TextDecoration.lineThrough,
////                                      ),),
////                                    ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              GestureDetector(
//                                onTap: () => _onFreeAlertPressed(context),
//                                child: Container(
//                                  width: 148,
//                                  margin: EdgeInsets.only(top: 32),
//                                  decoration: BoxDecoration(
//                                    border: Border(right:BorderSide(color: Color(0xFFCCCCCC),width: 1)),
//                                  ),
//                                  child: Row(
//                                    children: <Widget>[
//                                      Container(
//                                        width: 20,
//                                        margin: EdgeInsets.only(left: 25,right: 10),
//                                        child: Image(image: AssetImage('images/wx.png'),),
//                                      ),
//                                      Text(
//                                        '微信支付',
//                                        style:TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xFF999999),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),
//                                        textAlign: TextAlign.left,
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                              GestureDetector(
//                                onTap: () => _onFreeAlertPressed(context),
//                                child: Container(
//                                  width: 140,
//                                  margin: EdgeInsets.only(top: 32),
//                                  child: Row(
//                                    children: <Widget>[
//                                      Container(
//                                        width: 20,
//                                        margin: EdgeInsets.only(left: 30,right: 10),
//                                        child: Image(image: AssetImage('images/zfb.png'),),
//                                      ),
//                                      Text(
//                                        '支付宝支付',
//                                        style:TextStyle(
//                                          fontSize: 14,
//                                          color: Color(0xFF999999),
//                                          fontWeight: FontWeight.normal,
//                                          decoration: TextDecoration.none,
//                                        ),
//                                        textAlign: TextAlign.left,
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ],
//                          )
//                        ]
//                    )
//                  ),
                    // 协议
//                    Container(
//                      width: 335,
//                      height:60,
//                      margin: EdgeInsets.only(top: 20,bottom: 20),
//                      decoration: BoxDecoration(
//                        border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 1))
//                      ),
//                      child: Row(
//                        children: <Widget>[
//                          GestureDetector(
//                            onTap: () {
//                              Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => ServiceAgreementPage()));
//                            },
//                            child: Container(
//                              width: 167.4,
//                              decoration: BoxDecoration(
//                                  border: Border(right: BorderSide(color: Color(0xFFCCCCCC),width: 1))
//                              ),
//                              child: Row(
//                                children: <Widget>[
//                                  Padding(
//                                    padding: EdgeInsets.only(left: 25,right: 10),
//                                    child: Text('会员服务协议',style: TextStyle(
//                                        fontSize: 14,
//                                        color: Color(0xFF666666)
//                                    ),),
//                                  ),
//                                  Image(image: AssetImage('images/next.png'),)
//                                ],
//                              ),
//                            ),
//                          ),
//                          GestureDetector(
//                            onTap: () {
//                              Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => PrivacyStatementPage()));
//                            },
//                            child: Container(
//                              width: 167.4,
//                              child: Row(
//                                children: <Widget>[
//                                  Padding(
//                                    padding: EdgeInsets.only(left: 35,right: 10),
//                                    child: Text('会员隐私协议',style: TextStyle(
//                                        fontSize: 14,
//                                        color: Color(0xFF666666)
//                                    ),),
//                                  ),
//                                  Image(image: AssetImage('images/next.png'),)
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
                    // 会员特权
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => VipPrivilegePage()));
                      },
                      child: Container(
                        width: 335,
                        height:40,
                        margin: EdgeInsets.only(top: 100),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 1))
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 22,
                              child: Image(image: AssetImage('images/vip_blue.png'),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('会员特权',style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666)
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 我的邀请
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>InvitationCodePage()));
                      },
                      child: Container(
                        width: 335,
                        height:40,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2),width: 1))
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 22,
                              child: Image(image: AssetImage('images/invitation.png'),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('我的邀请',style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666)
                              ),),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
              )
        ]),
      ));

  }
  _onFreeAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "推广期免费",
      desc: "感谢您的支持！",
      buttons: [
        DialogButton(
          child: Text(
            "知道啦",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
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
