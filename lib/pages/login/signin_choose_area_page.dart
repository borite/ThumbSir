import 'package:ThumbSir/dao/get_section_list_dao.dart';
import 'package:ThumbSir/model/section_list_model.dart';
import 'package:ThumbSir/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/dao/set_section_dao.dart';
import 'package:ThumbSir/dao/finish_reg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

class SigninChooseAreaPage extends StatefulWidget {
  String selValue;
  String companyId;
  SigninChooseAreaPage({this.selValue,this.companyId});
  @override
  _SigninChooseAreaPageState createState() => _SigninChooseAreaPageState(selValue);
}

class _SigninChooseAreaPageState extends State<SigninChooseAreaPage> {
  final TextEditingController levelOneController = TextEditingController();
  final TextEditingController levelTwoController = TextEditingController();
  var previousLevel;
  var currentLevel;

  String selValue;
  _SigninChooseAreaPageState(this.selValue);

  String selectedItem;

  final previousKey = GlobalKey<FormState>();
  final currentKey = GlobalKey<FormState>();
  bool autovalidate = false;

  List<String> currentSections;
  List<String> previousSections;
  final list = <String>[];

  _load() async {
    previousLevel = (int.parse(selValue.substring(0,1))-1).toString();
    currentLevel = selValue.substring(0,1);
    var current = await GetSectionListDao.httpGetSectionList(widget.companyId,currentLevel);
    var previous = await GetSectionListDao.httpGetSectionList(widget.companyId,previousLevel);
    currentSections = current.data;
    previousSections = previous.data;
  }


  @override
  void initState() {
    _load();
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
                      currentLevel != '1'?
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
                                  color: currentLevel == '6'?Color(0xFF93C0FB):Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('上一级的管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ):Text(''),
                      currentLevel != '1'?
                      // 输入上一级区域
                      Container(
                        width: 335,
                        height: 150,
                        margin: EdgeInsets.only(top: 10),
                        child: Form(
                          key: previousKey,
                          autovalidate: autovalidate,
                          child: Column(children: <Widget>[
                            SimpleAutocompleteFormField<String>(
                              controller: levelOneController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                border: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: currentLevel == '2'? "例如：北京市"
                                    :currentLevel == '3'? "例如：京中事业部"
                                    :currentLevel == '4'? "例如：王府井大区"
                                    :currentLevel == '5'? "例如：王府井店"
                                    :currentLevel == '6'? "例如：买卖1组"
                                    :''
                              ),
//                            suggestionsHeight: 200.0,
                              maxSuggestions: 2,
                              itemBuilder: (context, listItem) => Padding(
                                padding: EdgeInsets.only(top: 5,left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Image(image: AssetImage("images/choose.png"),),
                                            ),
                                            Text(
                                              listItem,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF5580EB)
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              onSearch: (search) async => previousSections.where((person) => person.toLowerCase()
                                  .contains(search.toLowerCase())).toList(),
                              itemFromString: (string) => previousSections.singleWhere(
                                      (listItem) => listItem.toLowerCase() == string.toLowerCase(),
                                  orElse: () => null),
                              onChanged: (value) {setState(() => selectedItem = value);},
                              onSaved: (value) {setState(() => selectedItem = value);},
                              validator: (listItem) => listItem == null ? '请输入上一级管辖区域' : null,
                            ),
                          ]),
                        ),
                      ):Text(''),
                      // 填写区域2
                      currentLevel != '6'?
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
                                  color: currentLevel == '1'?Color(0xFF93C0FB):Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('您的管辖区域',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                          ],
                        ),
                      ):Text(''),
                      // 输入本级区域
                      currentLevel != '6'?
                      Container(
                        width: 335,
                        height: 150,
                        margin: EdgeInsets.only(top: 10),
                        child: Form(
                          key: currentKey,
                          autovalidate: autovalidate,
                          child: Column(children: <Widget>[
                            SimpleAutocompleteFormField<String>(
                              controller: levelTwoController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                                border: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  /*边角*/
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                  borderSide: BorderSide(color: Color(0xFF2692FD), width: 1,),
                                ),
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: currentLevel == '1'? "例如：北京市"
                                    :currentLevel == '2'? "例如：京中事业部"
                                    :currentLevel == '3'? "例如：王府井大区"
                                    :currentLevel == '4'? "例如：王府井店"
                                    :currentLevel == '5'? "例如：买卖1组"
                                    :'',
                              ),
//                            suggestionsHeight: 200.0,
                              maxSuggestions: 2,
                              itemBuilder: (context, listItem) => Padding(
                                padding: EdgeInsets.only(top: 5,left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Image(image: AssetImage("images/choose.png"),),
                                            ),
                                            Text(
                                              listItem,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF5580EB)
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              onSearch: (search) async => currentSections.where((person) => person.toLowerCase()
                                  .contains(search.toLowerCase())).toList(),
                              itemFromString: (string) => currentSections.singleWhere(
                                      (listItem) => listItem.toLowerCase() == string.toLowerCase(),
                                  orElse: () => null),
                              onChanged: (value) {setState(() => selectedItem = value);},
                              onSaved: (value) {setState(() => selectedItem = value);},
                              validator: (listItem) => listItem == null ? '请输入您的管辖区域' : null,
                            ),
                          ]),
                        ),
                      ):Text(''),
                      // 完成
                      Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 60),
                          decoration: currentLevel != 1
                              && currentLevel != 6
                              && levelOneController.text != null
                              && levelTwoController.text != null ?
                          BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFF5580EB)
                          )
                          : currentLevel == 1 && levelTwoController.text != null?
                          BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFF5580EB)
                          )
                          : currentLevel == 6 && levelOneController.text != null?
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

                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                var userID=prefs.getString("userID");
                                await setSecionDao.httpPostSection(widget.companyId, previousLevel, levelOneController.text);
                                await setSecionDao.httpPostSection(widget.companyId, currentLevel, levelTwoController.text);
                                await finishRegDao.httpPostFinishReg(userID, widget.companyId, currentLevel, levelTwoController.text );
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
