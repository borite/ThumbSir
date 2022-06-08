import 'package:ThumbSir/dao/get_company_level_dao.dart';
import 'package:ThumbSir/pages/login/signin_build_company_page.dart';
import 'package:ThumbSir/pages/login/signin_choose_position_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/company_list_model.dart';
import 'package:ThumbSir/dao/get_company_list_dao.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SigninChooseCompanyPage extends StatefulWidget {
  @override
  _SigninChooseCompanyPageState createState() => _SigninChooseCompanyPageState();
}

class _SigninChooseCompanyPageState extends State<SigninChooseCompanyPage> {
  Datum selectedItem;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

  @override
  void initState() {
    _load();
    super.initState();
  }

  List<Datum> companies;
  final list = <Datum>[];

  _load() async {
    var r = await GetCompanyListDao.httpGetCompanyList();
    companies = r.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
          // 背景
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('images/circle.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Column(children: <Widget>[
                // 导航栏
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image(
                            image: AssetImage('images/back.png'),
                          ),
                        ),
                      ],
                    )),
                // 头像按钮
                Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, -1),
                      margin: EdgeInsets.only(top: 8, left: 37),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFcccccc),
                                      offset: Offset(0.0, 3.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: Image(
                                image: AssetImage('images/tie.png'),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 30),
                            child: Text(
                              '设置公司',
                              style: TextStyle(
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
                // 输入公司
                Container(
                  width: 335,
                  height: 300,
                  margin: EdgeInsets.only(top: 10),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(children: <Widget>[
//                      Text('Selected listItem: "$selectedItem"'),
                      SimpleAutocompleteFormField<Datum>(
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
                          hintText: "请输入公司名称",
                        ),
//                        suggestionsHeight: 200.0,
                        maxSuggestions: 5,
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
                                        listItem.companyName,
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
                        onSearch: (search) async => companies.where((person) => person.companyName.toLowerCase()
                                .contains(search.toLowerCase())).toList(),
                        itemFromString: (string) => companies.singleWhere(
                            (listItem) => listItem.companyName.toLowerCase() == string.toLowerCase(),
                            orElse: () => null),
                        onChanged: (value) {setState(() => selectedItem = value);},
                        onSaved: (value) {setState(() => selectedItem = value);},
                        validator: (listItem) => listItem == null ? '输入后在下方选择公司，若没有请点击下方下一步创建公司' : null,
                      ),
                    ]),
                  ),
                ),
                // 下一步
                Container(
                    width: 335,
                    height: 40,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(bottom: 50, top: 50),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color(0xFF5580EB)),
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF5580EB)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: GestureDetector(
                        onTap: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            var companyLevel = await GetCompanyLevelDao.httpGetCompanyLevel(selectedItem.companyId);

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

                            Navigator.push(context, MaterialPageRoute(builder: (context) => SigninChoosePositionPage(
                                levelNames:levels,
                                companyId:selectedItem.companyId,
                                companyLevelCount:selectedItem.levelCount,
                            )));
                          } else {
                            _on402AlertPressed(context);
                            setState(() => autovalidate = true);
                          }
                        },
                        child: Text(
                          '下一步',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ])
            ],
          )),
    );
  }
  _on402AlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "没有该公司?",
      desc: "去创建公司吧",
      buttons: [
        DialogButton(
          child: Text(
            "去创建",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SigninBuildCompanyPage()));
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "再试试",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
}
