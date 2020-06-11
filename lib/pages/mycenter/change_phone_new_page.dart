import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:ThumbSir/pages/mycenter/change_phone_finish_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/pyzminput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:ThumbSir/dao/sendverifycode_dao.dart';
import 'package:ThumbSir/dao/signin_dao.dart';
import 'package:ThumbSir/model/userreg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneNewPage extends StatefulWidget {
  @override
  _ChangePhoneNewPageState createState() => _ChangePhoneNewPageState();
}

class _ChangePhoneNewPageState extends State<ChangePhoneNewPage> {
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;
  final TextEditingController verifyCodeController=TextEditingController();
  String verifyCode;
  RegExp yzmReg;
  bool verifyCodeBool;

  String WebAPICookie;
  @override
  void initState() {
    phoneReg = telPhoneReg;
    yzmReg = verifyCodeReg;
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
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            child: Text(
                              '修改手机号码',
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(bottom: 30),
                            child: Text(
                              '2.绑定新的手机号码',
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
                      // 电话
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
                          PYZMInput(
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
                        ],
                      ),
                      // 完成
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 100),
                          decoration: phoneBool == true && verifyCodeBool == true?
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePhoneFinishPage()));
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
