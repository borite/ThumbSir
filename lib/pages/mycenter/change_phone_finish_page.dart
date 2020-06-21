import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/sendverifycode_model.dart';
import 'package:ThumbSir/dao/send_verify_code_dao.dart';
import 'package:ThumbSir/dao/signin_dao.dart';
import 'package:ThumbSir/model/userreg_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneFinishPage extends StatefulWidget {
  @override
  _ChangePhoneFinishPageState createState() => _ChangePhoneFinishPageState();
}

class _ChangePhoneFinishPageState extends State<ChangePhoneFinishPage> {
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
                      // 标题
                      Column(
                        children: <Widget>[
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 60),
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
                          Image(image: AssetImage("images/finish_big.png"),),
                          Padding(
                            padding: EdgeInsets.only(top: 20,bottom: 15),
                            child: Text(
                              '手机号码修改成功',
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF24CC8E),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '请重新登录账号',
                            style:TextStyle(
                              fontSize: 16,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      // 完成
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 100),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFF5580EB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              },
                              child: Text('重新登录',style: TextStyle(
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
