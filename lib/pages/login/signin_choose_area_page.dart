import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/dao/set_section_dao.dart';
import 'package:ThumbSir/dao/finish_reg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninChooseAreaPage extends StatefulWidget {
  String selValue;
  SigninChooseAreaPage({this.selValue});
  @override
  _SigninChooseAreaPageState createState() => _SigninChooseAreaPageState(selValue);
}

class _SigninChooseAreaPageState extends State<SigninChooseAreaPage> {
  final TextEditingController _controller = TextEditingController();

  final TextEditingController levelOneController = TextEditingController();
  final TextEditingController levelTwoController = TextEditingController();
  final TextEditingController levelThreeController = TextEditingController();
  final TextEditingController levelFourController = TextEditingController();
  final TextEditingController levelFiveController = TextEditingController();
  //final TextEditingController levelFourController = TextEditingController();
  //final TextEditingController levelFiveController = TextEditingController();
  //final TextEditingController levelSixController = TextEditingController();

  String selValue;
  _SigninChooseAreaPageState(this.selValue);


  //根据选择的职级，返回掌管的区域
  String manageSection(String sval){
     String sl=sval.split('-')[0];
     String section="-1";
     switch(sl){
       case "1":
         section=levelOneController.text;
         break;
       case "2":
         section=levelTwoController.text;
         break;
       case "3":
         section=levelThreeController.text;
         break;
       case "4":
         section=levelFourController.text;
         break;
       case "5":
         section=levelFiveController.text;
         break;
       default:
         break;
     }
     return section;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(selValue);
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
                                      image: AssetImage('images/tie.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 30),
                                  child: Text(
                                    '设置区域',
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
                      // 填写区域1
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
                              child: Text('第一级：总经理管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Input(
                            hintText: '例如：北京市',
                            controller: levelOneController,
                          ),
                          // 选择公司
                          Container(
                              width: 335,
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
                              ),
                              child:Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('北京市',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('上海市',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('太原市',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      // 填写区域2
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
                              child: Text('第二级：副总经理管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Input(
                            controller: levelTwoController,
                            hintText: '例如：京中事业部',
                          ),
                          // 选择公司
                          Container(
                              width: 335,
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
                              ),
                              child:Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('京中事业部',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('京南事业部',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('京西北事业部',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      // 填写区域3
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
                              child: Text('第三级：总监管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Input(
                            controller: levelThreeController,
                            hintText: '例如：学院大区',
                          ),
                          // 选择公司
                          Container(
                              width: 335,
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
                              ),
                              child:Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('学院大区',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('西直门大区',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('双井大区',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      // 填写区域4
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
                              child: Text('第四级：商圈经理管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Input(
                            controller: levelFourController,
                            hintText: '例如：长河湾北门店',
                          ),
                          // 选择公司
                          Container(
                              width: 335,
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
                              ),
                              child:Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('长河湾北门店',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('交大嘉园店',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('交大东路店',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      // 填写区域5
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
                              child: Text('第五级：店经理管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Input(
                            controller: levelFiveController,
                            hintText: '例如：买卖1组',
                          ),
                          // 选择公司
                          Container(
                              width: 335,
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFCCCCCC)))
                              ),
                              child:Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('买卖1组',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('买卖2组',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(image: AssetImage('images/choose.png'),),
                                        ),
                                        Text('租赁1组',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),textAlign: TextAlign.left,),
                                      ],
                                    ),
                                  ),
                                ],
                              )
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
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                var companyID= prefs.getString("companyID");
                                var userID=prefs.getString("userID");
                                CommonResult r= await setSecionDao.httpPostSection(companyID, levelOneController.text, levelTwoController.text, levelThreeController.text, levelFourController.text, levelFiveController.text,'');
                                CommonResult fr=await finishRegDao.httpPostFinishReg(userID, companyID, selValue, manageSection(selValue) );
                                print('更新公司区域结果');
                                print(r.code);
                                print(r.message);
                                print(r.data);
                                print('更新用户信息结果');
                                print(fr.code);
                                print(fr.message);
                                print(fr.data);
                                Navigator.of(context).pushAndRemoveUntil(
                                    new MaterialPageRoute(builder: (context) => new LoginPage()
                                    ), (route) => route == null);
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
