import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/retruve_user_pwd_dao.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FindKeyPage extends StatefulWidget {
  final userName;
  final userID;
  const FindKeyPage({Key key,this.userID,this.userName}) : super(key :key);
  @override
  _FindKeyPageState createState() => _FindKeyPageState();
}

class _FindKeyPageState extends State<FindKeyPage> {
  final TextEditingController passwordController=TextEditingController();
  String password;
  RegExp psdReg;
  bool psdBool;

  @override
  void initState() {
    psdReg = passwordReg;
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
          child:Container(
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
                      // 密码
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
                      // 下一步
                      GestureDetector(
                        onTap: () async {
                          if(psdBool == true){
                            final CommonResult findKeyResult=await RetruveUserPwdDao.findPwd(passwordController.text,this.widget.userID);
                            if(findKeyResult != null){
                              if(findKeyResult.code == 200 ){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              }else{_onCodeAlertPressed(context);}
                            }else{_onCodeAlertPressed(context);}
                          }else{}
                        },
                        child: Container(
                            width: 335,
                            height: 40,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(bottom: 50,top: 100),
                            decoration: psdBool == true ?
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
                              child: Text('完成',style: TextStyle(
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
        )
      );
  }
  _onCodeAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "修改密码失败",
      desc: "请重试",
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
}
