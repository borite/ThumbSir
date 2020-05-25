import 'package:ThumbSir/pages/login/signin_choose_company_page.dart';
import 'package:ThumbSir/pages/login/signin_choose_position_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:city_picker/city_picker.dart';
import 'package:ThumbSir/dao/create_company_dao.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/dao/set_company_level.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninBuildCompanyPage extends StatefulWidget {
  @override
  _SigninBuildCompanyPageState createState() => _SigninBuildCompanyPageState();
}

class _SigninBuildCompanyPageState extends State<SigninBuildCompanyPage> {

  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  Future<String> _companyID;

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController creditCodeController = TextEditingController();
  final TextEditingController levelOneController = TextEditingController();
  final TextEditingController levelTwoController = TextEditingController();
  final TextEditingController levelThreeController = TextEditingController();
  final TextEditingController levelFourController = TextEditingController();
  final TextEditingController levelFiveController = TextEditingController();
  final TextEditingController levelSixController = TextEditingController();

  String text;
  String p1;
  String p2;
  String lcount="6";
  void _incrementCounter() async {
    CityResult result = await showCityPicker(context,
        initCity: CityResult()
          ..province = p1
          ..city = p2);

    if (result == null) {
      return;
    }

    p1 = result?.province;
    p2 = result?.city;

    setState(() {
      text = "${result?.province} - ${result?.city}";
    });
  }

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
                                      image: AssetImage('images/company_big.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '创建公司',
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
                      // 公司名称、信用代码、城市、职级
                      Column(
                        children: <Widget>[
                          // 公司名称
                          Input(
                            hintText: "公司名称",
                            controller: companyNameController,
                          ),
                          // 社会统一信用代码
                          Input(
                            hintText: "社会统一信用代码",
                            controller: creditCodeController,
                          ),
                          // 选择省市
                          Container(
                            width: 335,
                            height: 40,
                            margin: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF2692FD)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Text(
                                    text ?? "选择省市",
                                    style:TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: _incrementCounter,
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                ),
                              ],
                            ),
                          ),// This trailing comma makes auto-formatting nicer for build methods.
                          // 创建职级
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Image(image: AssetImage('images/tie_blue.png'),),
                                ),
                                Text('创建职级',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB)
                                ),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Text('注：请合理按照公司组织架构，选择您的公司运营团队在本城市分几层职级',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333)
                                ),
                            ),
                          ),
                          // 选择职级
                          Container(
                            width: 100,
                            height: 120,
                            child: WheelChooser(
                              onValueChanged: (s) => lcount=s,
                              datas: ["6", "5", "4", "3", "2"],
                              selectTextStyle: TextStyle(
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                              ),
                              unSelectTextStyle: TextStyle(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                              ),
                            ),
                          ),
                          // 职级名称
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Image(image: AssetImage('images/tie_blue.png'),),
                                ),
                                Text('职位名称',style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5580EB)
                                ),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Text('注：请合理按照公司组织架构，填写您的公司运营团队在本城市的各层职级的职位名称',style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333)
                            ),
                            ),
                          ),
                          // 填写职级1
                          Padding(
                            padding: EdgeInsets.only(top:20,left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF93C0FB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('第一级职位名称',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Input(
                            hintText: '例如：总经理',
                            controller: levelOneController,
                          ),
                          // 填写职级2
                          Padding(
                            padding: EdgeInsets.only(top:30,left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF93C0FB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('第二级职位名称',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Input(
                            hintText: '例如：副总经理',
                            controller: levelTwoController,
                          ),
                          // 填写职级3
                          Padding(
                            padding: EdgeInsets.only(top:30,left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF93C0FB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('第三级职位名称',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Input(
                            hintText: '例如：总监',
                            controller: levelThreeController,
                          ),
                          // 填写职级4
                          Padding(
                            padding: EdgeInsets.only(top:30,left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF93C0FB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('第四级职位名称',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Input(
                            hintText: '例如：商圈经理',
                            controller: levelFourController,
                          ),
                          // 填写职级5
                          Padding(
                            padding: EdgeInsets.only(top:30,left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF93C0FB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '5',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('第五级职位名称',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Input(
                            hintText: '例如：店经理',
                            controller: levelFiveController,
                          ),
                          // 填写职级6
                          Padding(
                            padding: EdgeInsets.only(top:30,left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF93C0FB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '6',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('第六级职位名称',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          Input(
                            hintText: '例如：经纪人',
                            controller: levelSixController,
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
                              color: Color(0xFF93C0FB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: () async{
//                                final SharedPreferences prefs=await _prefs;
//                                final String companyName=companyNameController.text;
//                                final String companyCode=creditCodeController.text;
//                                final String province=p1;
//                                final String city=p2;
//                                final CommonResult result=await CreateCompanyDao.httpPostCreateCompany(companyName, companyCode, lcount , province, city);
//                                //print(result);
//                                if(result.code==200) {
//                                  final companyID=result.data;
//                                  await prefs.setString("companyID", companyID);
//                                  //print(prefs.getString("companyID"));
//                                  CommonResult r=null;
//                                  for(int i=1;i<=int.parse(lcount);i++){
//                                     String levelName="";
//                                     int realLevelNum=7-i;
//                                     switch(realLevelNum){
//                                       case 1:
//                                         levelName=levelOneController.text;
//                                         break;
//                                       case 2:
//                                         levelName=levelTwoController.text;
//                                         break;
//                                       case 3:
//                                         levelName=levelThreeController.text;
//                                         break;
//                                       case 4:
//                                         levelName=levelFourController.text;
//                                         break;
//                                       case 5:
//                                         levelName=levelFiveController.text;
//                                         break;
//                                       case 6:
//                                         levelName=levelSixController.text;
//                                         break;
//                                       default:
//                                         break;
//                                     }
//                                     r=await SetCompanyLevelDao.httpSetCompanyLevel(companyID, realLevelNum.toString(),levelName);
//                                     //print(r);
//                                  }
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChoosePositionPage()));
//                                }else{
//                                  print(result.code);
//                                  print(result.message);
//                                }

                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
                              },
                              child: Text('完成',style: TextStyle(
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
