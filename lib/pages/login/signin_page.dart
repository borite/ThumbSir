import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:ThumbSir/pages/mycenter/legal_notice_page.dart';
import 'package:ThumbSir/pages/mycenter/privacy_statement_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/yzminput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/dao/signin_dao.dart';
import 'package:ThumbSir/model/userreg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SigninNameAndPhonePage extends StatefulWidget {
  @override
  _SigninNameAndPhonePageState createState() => _SigninNameAndPhonePageState();
}

class _SigninNameAndPhonePageState extends State<SigninNameAndPhonePage> {

  final TextEditingController userNameController = TextEditingController();
  String userName;
  RegExp nameReg;
  bool userNameBool;
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;
  final TextEditingController passwordController=TextEditingController();
  String password;
  RegExp psdReg;
  bool psdBool;
  final TextEditingController verifyCodeController=TextEditingController();
  String verifyCode;
  RegExp yzmReg;
  bool verifyCodeBool;
  final TextEditingController invitationCodeController = TextEditingController();
  String invitationCode;
  RegExp invitationReg;
  bool invitationCodeBool;

  bool check = false; // 复选框是否被选中
  int checkBox = 0; // 提交时复选框是否被选中，0为选中

  String WebAPICookie;

  @override
  void initState() {
    nameReg = userNameReg;
    phoneReg = telPhoneReg;
    psdReg = passwordReg;
    yzmReg = verifyCodeReg;
    invitationReg = invitationCodeReg;
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
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
                            Input(
                              hintText: "姓名",
                              errorTipText: "建议输入真实姓名",
                              tipText: "建议输入真实姓名",
                              rightText: "姓名格式正确",
                              controller: userNameController,
                              inputType: TextInputType.text,
                              reg: nameReg,
                              onChanged: (text){
                                setState(() {
                                  userName = text;
                                  userNameBool = nameReg.hasMatch(userName);
                                });
                              },
                            ),
                            //密码输入框
                            Input(
                              hintText: "密码",
                              errorTipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                              tipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                              rightText: "密码格式正确",
                              controller: passwordController,
                              inputType: TextInputType.text,
                              reg: psdReg,
                              onChanged: (text){
                                setState(() {
                                  password = text;
                                  psdBool = psdReg.hasMatch(password);
                                });
                              },
                            ),
                            //手机号码
                            Input(
                              hintText: "手机号码",
                              tipText: "请输入手机号码",
                              errorTipText: "请输入格式正确的手机号码",
                              rightText: "手机号码格式正确",
                              controller: phoneNumController,
                              inputType: TextInputType.phone,
                              reg: phoneReg,
                              onChanged: (text){
                                setState(() {
                                  phoneNum = text;
                                  phoneBool = phoneReg.hasMatch(phoneNum);
                                });
                              },
                            ),
                            // 验证码
                            YZMInput(
                              hintText: "验证码",
                              tipText: "请输入验证码",
                              errorTipText: "请输入格式正确的验证码",
                              rightText: "验证码格式正确",
                              yzmcontroller: verifyCodeController,
                              controller: phoneNumController,
                              inputType: TextInputType.number,
                              reg: yzmReg,
                              onChanged: (text){
                                setState(() {
                                  verifyCode = text;
                                  verifyCodeBool = yzmReg.hasMatch(verifyCode);
                                });
                              },
                              editParentText: (editText) => _editParentText(editText),
                            ),
                            // 邀请码
                            Input(
                              hintText: "请输入邀请码",
                              tipText: "邀请码为选填项,非必填",
                              controller: invitationCodeController,
                              inputType: TextInputType.number,
                              errorTipText: "请输入格式正确的验证码",
                              rightText: "邀请码格式正确",
                              reg: invitationReg,
                              onChanged: (text){
                                setState(() {
                                  invitationCode = text;
                                  invitationCodeBool = invitationReg.hasMatch(invitationCode);
                                });
                              },
                            ),
                            // 同意隐私政策
                            Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 2),
                                      child: Checkbox(
                                        value: check,
                                        activeColor: Color(0xFF5580EB),
                                        onChanged: (bool val) {
                                          // val 是布尔值
                                          this.setState(() {
                                            check = !check;
                                          });
                                          if(check == true){
                                            setState(() {
                                              checkBox = 0;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    Text('同意',style: TextStyle(
                                      fontSize: 14,
                                      color: checkBox == 0 ? Color(0xFF5580EB) : Color(0xFFF24848),
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
                                        color: checkBox == 0 ? Color(0xFF5580EB) : Color(0xFFF24848),
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
                                        color: checkBox == 0 ? Color(0xFF5580EB) : Color(0xFFF24848),
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
                            decoration: phoneBool == true &&
                                psdBool == true &&
                                userNameBool == true &&
                                verifyCodeBool == true &&
                                check == true?
                            BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF5580EB)
                            )
                                :
                            BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF93C0FB)
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: GestureDetector(
                                  onTap: () async {
                                    if(phoneBool == true &&
                                        psdBool == true &&
                                        userNameBool == true &&
                                        verifyCodeBool == true &&
                                        check == true){
                                      final UserReg result=await SigninDao.doUserReg(userName, password, phoneNum, verifyCode,WebAPICookie);
                                      print(WebAPICookie);
                                      if(result.code==200) {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString('userID', result.data);
                                        Navigator.of(context).pushAndRemoveUntil(
                                            new MaterialPageRoute(builder: (context) => new SigninChooseCompanyPage()
                                            ), (route) => route == null);
                                      }else if(result.code == 403){
                                        _on403AlertPressed(context);
                                      }
                                      else if(result.code == 410){_on410AlertPressed(context);}
                                      else if(result.code == 420){_on420AlertPressed(context);}
                                      else{_on404AlertPressed(context);}
                                    }else if(check == false){
                                      setState(() {
                                        checkBox = 1;
                                      });
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
        )
      );
  }
  _editParentText(editText) {
    setState(() {
      WebAPICookie = editText;
    });
  }
  _on404AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "未发送验证码",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _on403AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "验证码不正确",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _on410AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "验证码过期了",
      desc: "请再次点击发送验证码",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
  _on420AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "手机号码已注册",
      buttons: [
        DialogButton(
          child: Text(
            "去登录",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "再试试",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ).show();
  }
}
