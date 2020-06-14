import 'package:ThumbSir/pages/login/signin_choose_area_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ThumbSir/model/company_level_list_model.dart';
import 'package:ThumbSir/dao/get_company_level_dao.dart';
class SigninChoosePositionPage extends StatefulWidget {
  List levelNames;
  String companyId;
  SigninChoosePositionPage({this.levelNames,this.companyId});
  @override
  _SigninChoosePositionPageState createState() => _SigninChoosePositionPageState(levelNames);
}

class _SigninChoosePositionPageState extends State<SigninChoosePositionPage> {
  List levelNames;
  _SigninChoosePositionPageState(this.levelNames);

  String selValue="";

  @override
  void initState() {
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
                                    child:Image(
                                      image: AssetImage('images/tie.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '选择职位',
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
                      // 选择职位
                      Container(
                        width: 200,
                        height: 220,
                        child: WheelChooser(
                          onValueChanged: (s){
                             selValue=s.toString();
                          },
                          datas: levelNames,
                          selectTextStyle: TextStyle(
                            color: Color(0xFF0E7AE6),
                            fontWeight: FontWeight.normal,
                            fontSize: 14
                          ),
                          unSelectTextStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              fontSize: 14
                          ),
                        ),
                      ),
                      // 下一步
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 100),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFF5580EB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseAreaPage(
                                    selValue:selValue,
                                    companyId:widget.companyId
                                )));
                              },
                              child: Text('下一步',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            ),
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

