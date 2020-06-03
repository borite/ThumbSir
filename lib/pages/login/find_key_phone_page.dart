import 'package:ThumbSir/pages/login/find_key_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FindKeyPhonePage extends StatefulWidget {
  @override
  _FindKeyPhonePageState createState() => _FindKeyPhonePageState();
}

class _FindKeyPhonePageState extends State<FindKeyPhonePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController verifyCodeController = TextEditingController();
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
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
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/back.png'),),
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
                                      image: AssetImage('images/key.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '找回密码',
                                    style:TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF333333),
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
                      // 姓名、电话、密码、忘记密码
                      Column(
                        children: <Widget>[
                          Input(
                            hintText: '电话号码',
                          ),
                          //验证码
                          Stack(
                            children: <Widget>[
                              Container(
                                width: 335,
                                height: 40,
                                margin: EdgeInsets.only(top: 25),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF2692FD)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: verifyCodeController,
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 14),
                                    hintText: "请输入验证码",
                                  ),
                                ),
                              ),
                              //验证码发送按钮
                              Positioned(
                                left: 230,
                                child: GestureDetector(
                                  onTap: () async {
//                                    final String phoneNum=phoneNumController.text;
//                                    final SendVerifyCode result=await SendVerifyCodeDao.sendSms(phoneNum);
//                                    if(result.code==200) {
//                                      WebAPICookie =
//                                      result.cookie.split(';')[0];
//                                      print(result);
//                                      print(WebAPICookie);
//                                    }else{
//                                      debugPrint("出错了！");
//                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    margin: EdgeInsets.only(top: 30),
                                    padding: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        border: Border(left: BorderSide(width: 1,color: Color(0xFF5580EB)))
                                    ),
                                    child: Text('发送验证码',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5580EB),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 335,
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () => _onAppealAlertPressed(context),
                              child: Text('无法收到验证码？发起账号申诉！',style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.right,),
                            ),
                          ),
                        ],
                      ),
                      // 登录
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FindKeyPage()));
                        },
                        child: Container(
                            width: 335,
                            height: 40,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(bottom: 50,top: 100),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF93C0FB)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text('下一步',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            )
                        ),
                      ),
                    ]
                )
              ],
            )
        ),
      );
  }
  _onAppealAlertPressed(context) {
    Alert(
      context: context,
      title: "是否发起账号申诉？",
      desc: "如果您的手机号码无法收到验证码，可进行账号申诉，点击确定后会给拇指先生后台发送信息，3个工作日内会有拇指先生客服联系您。",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
}
