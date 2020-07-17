import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/modify_user_name_dao.dart';
import 'package:ThumbSir/dao/token_check_dao.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final TextEditingController userNameController = TextEditingController();
  String userName;
  RegExp nameReg;
  bool userNameBool;

  LoginResultData userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  int exT;
  String uinfo;
  var result;

  bool _loading = false;

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
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    nameReg = userNameReg;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressDialog(
        loading: _loading,
        msg:"加载中...",
        child:Container(
          // 背景
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image:AssetImage('images/circle_middle.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: ListView(
              children: <Widget>[
                Column(
                    children: <Widget>[
                      // 导航栏
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Image(image: AssetImage('images/back.png'),),
                            ),
                            Text('设置姓名',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                            Container(width: 20,)
                          ],
                        ),
                      ),
                      // 姓名
                      Input(
                        hintText: userData == null ? "姓名":userData.userName,
                        errorTipText: "为了方便同事找到您，建议输入真实姓名",
                        tipText: "为了方便同事找到您，建议输入真实姓名",
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
                      // 相册中选取
                      GestureDetector(
                        onTap: ()async{
                          if(userNameBool == true){
                            _onRefresh();
                            final result=await ModifyUserNameDao.modifyName(userData.userPid,userName);
                            if(result.code == 200){
                              final tokenResult = await TokenCheckDao.tokenCheck(userData.token);
                              if(tokenResult.code==200){
                                String dataStr=json.encode(tokenResult.data);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("userInfo", dataStr);
                                Navigator.of(context).pop(dataStr);
                              }
                            }else if(result.code == 430){_on430AlertPressed(context);}else{}
                          }else{}
                        },
                        child: Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(7),
                          margin: EdgeInsets.fromLTRB(0, 60, 0, 80),
                          decoration:
                          userNameBool == true ?
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
                          child: Text('确认更换',style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),textAlign: TextAlign.center,),
                        ),
                      ),
                    ]
                )
              ],
            )
        )
      ),
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
    if(uinfo != null){
      setState(() {
        _loading = !_loading;
      });
    }
//    await Future.delayed(Duration(milliseconds: 500), () {
//      setState(() {
//        _loading = !_loading;
//      });
//    });
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
  _on430AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "您的姓名已被使用",
      desc: "建议为姓名加特殊标识，如张三001",
      buttons: [
        DialogButton(
          child: Text(
            "去修改",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
}
