import 'package:ThumbSir/pages/mycenter/change_code_finish_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/yzminput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/common/reg.dart';

class ChangeCodePage extends StatefulWidget {
  @override
  _ChangeCodePageState createState() => _ChangeCodePageState();
}

class _ChangeCodePageState extends State<ChangeCodePage> {
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
  final TextEditingController newPasswordController=TextEditingController();
  String newPassword;
  bool newPsdBool;
  final TextEditingController sNewPasswordController=TextEditingController();
  String sNewPassword;
  bool sNewPsdBool;
  @override
  void initState() {
    phoneReg = telPhoneReg;
    psdReg = passwordReg;
    yzmReg = verifyCodeReg;
    super.initState();
  }

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
                      // 标题
                      Column(
                        children: <Widget>[
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 30),
                            child: Text(
                              '修改登录密码',
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      // 姓名、电话、密码、忘记密码
                      Column(
                        children: <Widget>[
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
                          ),
                          //密码输入框
                          Input(
                            hintText: "旧密码",
                            errorTipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                            tipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                            rightText: "旧密码格式正确",
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
                          //密码输入框
                          Input(
                            hintText: "新密码",
                            errorTipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                            tipText: "6-18位数字、字母组合，字母包含大小写，禁止使用符号",
                            rightText: "新密码格式正确",
                            controller: newPasswordController,
                            inputType: TextInputType.text,
                            reg: psdReg,
                            onChanged: (text){
                              setState(() {
                                newPassword = text;
                                newPsdBool = psdReg.hasMatch(newPassword);
                              });
                            },
                          ),
                          //密码输入框
                          Input(
                            hintText: "确认新密码",
                            errorTipText: "再次输入新密码",
                            tipText: "再次输入新密码",
                            rightText: "确认密码格式正确",
                            controller: sNewPasswordController,
                            inputType: TextInputType.text,
                            reg: psdReg,
                            onChanged: (text){
                              setState(() {
                                sNewPassword = text;
                                sNewPsdBool = psdReg.hasMatch(sNewPassword);
                              });
                            },
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
                              newPsdBool == true &&
                              verifyCodeBool == true &&
                              sNewPsdBool == true?
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
//                                final String phoneNum=phoneNumController.text;
//                                final String password=passwordController.text;
//                                final String verifyCode=verifyCodeController.text;
//                                final UserReg result=await SigninDao.doUserReg(password, phoneNum, verifyCode, '37ccc461-ab5c-4855-8842-bc45973d7cf0',WebAPICookie);
//                                print(result);
//                                if(result.code==200) {
//                                  SharedPreferences prefs = await SharedPreferences.getInstance();
//                                  prefs.setString('userID', result.data);
//                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
//                                }else{
//                                  print(result.code);
//                                  print(result.message);
//                                }
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeCodeFinishPage()));
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
