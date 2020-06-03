import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:ThumbSir/pages/mycenter/legal_notice_page.dart';
import 'package:ThumbSir/pages/mycenter/privacy_statement_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:ThumbSir/dao/sendverifycode_dao.dart';
import 'package:ThumbSir/dao/signin_dao.dart';
import 'package:ThumbSir/model/userreg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninNameAndPhonePage extends StatefulWidget {
  @override
  _SigninNameAndPhonePageState createState() => _SigninNameAndPhonePageState();
}

class _SigninNameAndPhonePageState extends State<SigninNameAndPhonePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController verifyCodeController=TextEditingController();
  String WebAPICookie;
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
                                      image: AssetImage('images/my_big.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '用户注册',
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
                          //姓名
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
                              controller: userNameController,
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
                                  hintText: "请输入真实姓名"
                              ),
                            ),
                          ),
                          //密码
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
                              controller: passwordController,
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
                                  hintText: "请输入密码"
                              ),
                            ),
                          ),
                          //手机号码输入框
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
                              controller: phoneNumController,
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
                                hintText: "手机号码"
                              ),
                            ),
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
                                    final String phoneNum=phoneNumController.text;
                                    final SendVerifyCode result=await SendVerifyCodeDao.sendSms(phoneNum);
                                    if(result.code==200) {
                                      WebAPICookie =
                                      result.cookie.split(';')[0];
                                      print(result);
                                      print(WebAPICookie);
                                    }else{
                                      debugPrint("出错了！");
                                    }
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
                          // 同意隐私政策
                          Container(
                            width: 335,
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  activeColor: Color(0xFF93C0FB),
                                ),
                                Text('同意',style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),textAlign: TextAlign.left,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => PrivacyStatementPage()));
                                  },
                                  child: Text('《拇指先生用户隐私政策》',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => LegalNoticePage()));
                                  },
                                  child: Text('《法律声明》',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                                ),
                              ],
                            )

                          ),
                        ],
                      ),
                      // 下一步
                      Container(
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
                            child: GestureDetector(
                              onTap: () async {
                                final String phoneNum=phoneNumController.text;
                                final String userName=userNameController.text;
                                final String password=passwordController.text;
                                final String verifyCode=verifyCodeController.text;
                                final UserReg result=await SigninDao.doUserReg(userName, password, phoneNum, verifyCode, '37ccc461-ab5c-4855-8842-bc45973d7cf0',WebAPICookie);
                                print(result);
                                if(result.code==200) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('userID', result.data);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
                                }else{
                                  print(result.code);
                                  print(result.message);
                                }

                              },
                              child: Text('下一步',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            )
                          )
                      ),
                    ]
                )
              ],
            )
        ),
      );
  }
}
