import 'dart:convert';
import 'package:ThumbSir/dao/get_company_level_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:ThumbSir/pages/login/signin_choose_position_page.dart';
import 'package:ThumbSir/pages/mycenter/change_name_page.dart';
import 'package:ThumbSir/pages/mycenter/choose_mini_task_number_page.dart';
import 'package:ThumbSir/pages/mycenter/choose_portrait_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetMyMsgPage extends StatefulWidget {
  @override
  _SetMyMsgPageState createState() => _SetMyMsgPageState();
}

class _SetMyMsgPageState extends State<SetMyMsgPage> {
  final TextEditingController textController = TextEditingController();
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
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            // 内容
            Container(
              color: Color(0xFFF2F2F2),
              child: ListView(
                children: <Widget>[
                  // 头像
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ChoosePortraitPage())).then((p){
                        setState(() {
                          portrait = p;
                        });
                      });
                    },
                    child: Container(
                        color: Colors.white,
                        height: 80,
                        margin: EdgeInsets.only(top: 65),
                        padding: EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // 头像
                            Container(
                              width: 100,
                              child: Text(
                                '头像',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: Color(0xFFF2F2F2), width: 1)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: userData == null && portrait == null?
                                    Image(image: AssetImage('images/my_big.png'),)
                                        :portrait != null && userData != null && userData.headImg != portrait?
                                    Image.file(portrait,fit: BoxFit.fill,)
                                        :userData.headImg != null ?
                                    Image(image:NetworkImage(userData.headImg))
                                        :Image(image: AssetImage('images/my_big.png'),),
                                  ),
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            )
                          ],
                        )

                    ),
                  ),
                  // 姓名
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ChangeNamePage())
                      ).then((dataStr){
                        _getUserInfo();
                      });
                    },
                    child: Container(
                        color: Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding: EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Text(
                                '姓名',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Text(
                                    userData == null ?'':userData.userName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            )
                          ],
                        )

                    ),
                  ),
                  // 公司
                  GestureDetector(
                    onTap: () => _onCompanyAlertPressed(context),
                    child: Container(
                        color: Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding: EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 300,
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: 5),
                                      child: Text(
                                        '公司',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      child: Text(
                                        userData == null ?'':userData.companyName,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                  // 职位区域
                  GestureDetector(
                    onTap: () => _onPositionAlertPressed(context),
                    child: Container(
                        color: Colors.white,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        padding: EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 300,
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: 5),
                                      child: Text(
                                        '职位与区域',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF666666),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      child: Text(
                                        userData == null ?'':userData.province +" - "+ userData.city +" - "+ userData.section +" - "+ userData.userLevel.substring(2,),
//                                        '北京-京中大部-白石桥大区-长河湾北门店-买卖1组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
            // 顶部导航区域
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF5580EB),
                image: DecorationImage(
                  image: AssetImage('images/circle.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Container(
                height: 80,
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Image(image: AssetImage(
                            'images/back_w_arrow.png'),),
                      ),
                    ),
                    Text(
                      '个人信息',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Container(
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onCompanyAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否更换公司？",
      desc: "更换公司后将解除您现在的所有组织关系，请慎重选择！",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage())),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
            color: Color(0xFFCCCCCC),
        )
      ],
    ).show();
  }
  _onPositionAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否更换职位和区域？",
      desc: "更换职位和区域后将解除您现在的所有组织关系，请慎重选择！",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            var companyLevel = await GetCompanyLevelDao.httpGetCompanyLevel(userData.companyId);

            // 把每一项放在levels的数组里
            List<String> levels=[];
            if(companyLevel.data.level1!=null){
              levels.add('1-'+companyLevel.data.level1);
            }
            if(companyLevel.data.level2!=null){
              levels.add('2-'+companyLevel.data.level2);
            }
            if(companyLevel.data.level3!=null){
              levels.add('3-'+companyLevel.data.level3);
            }
            if(companyLevel.data.level4!=null){
              levels.add('4-'+companyLevel.data.level4);
            }
            levels.add('5-'+companyLevel.data.level5);
            levels.add('6-'+companyLevel.data.level6);

            int count = levels.length;

            Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChoosePositionPage(
              levelNames:levels,
              companyId:userData.companyId,
              companyLevelCount:count,
            )));
          },

          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        )
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
