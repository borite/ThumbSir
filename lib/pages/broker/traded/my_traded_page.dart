import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/pages/broker/traded/traded_add_page.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:ThumbSir/widget/traded_item.dart';
import 'package:flutter/material.dart';

class MyTradedPage extends StatefulWidget {
  @override
  _MyTradedPageState createState() => _MyTradedPageState();
}

class _MyTradedPageState extends State<MyTradedPage> {
  bool _loading = false;
  var ageValue;
  var reasonValue;

  final TextEditingController searchController = TextEditingController();
  String search;
  RegExp searchReg;
  bool searchBool;

  List<DropdownMenuItem> getAgeList(){
    List<DropdownMenuItem> ageLists = new List();
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: 1,);
    ageLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('30岁以下'),value: 2,);
    ageLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('30~40岁'),value: 3,);
    ageLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('40~50岁'),value: 4,);
    ageLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('50岁以上'),value: 5,);
    ageLists.add(ageList5);
    return ageLists;
  }

  List<DropdownMenuItem> getReasonList(){
    List<DropdownMenuItem> reasonLists = new List();
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: 1,);
    reasonLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('出售'),value: 2,);
    reasonLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('出租'),value: 3,);
    reasonLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('购买'),value: 4,);
    reasonLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('租赁'),value: 5,);
    reasonLists.add(ageList5);
    DropdownMenuItem ageList6 = new DropdownMenuItem(child: Text('多次交易'),value: 6,);
    reasonLists.add(ageList6);
    return reasonLists;
  }

  @override
  void initState() {
    super.initState();
    searchReg = TextReg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedAddPage()));
          },
          child: Image(image:AssetImage('images/add.png'),),
        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
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
                              padding: EdgeInsets.only(left: 15,top: 5,bottom: 10),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // 首页和标题
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pushAndRemoveUntil(
                                              new MaterialPageRoute(builder: (context) => new Home( )
                                              ), (route) => route == null);
                                        },
                                        child: Container(
                                          width: 28,
                                          padding: EdgeInsets.only(top: 3),
                                          child: Image(image: AssetImage('images/home.png'),),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('我的老客户',style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),),
                                      )
                                    ],
                                  ),
                                  // 消息提醒和个人中心按钮
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        child: RaisedButton(
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                          },
                                          color: Colors.transparent,
                                          elevation: 0,
                                          disabledElevation: 0,
                                          highlightColor: Colors.transparent,
                                          highlightElevation: 0,
                                          splashColor: Colors.transparent,
                                          disabledColor: Colors.transparent,
                                          child: ClipOval(
                                            child: Container(
                                                width: 26,
                                                decoration: BoxDecoration(
                                                  border:Border.all(color: Color(0xFF0E7AE6),width: 1),
                                                  borderRadius: BorderRadius.circular(13),
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  child:Image(
                                                    width: 26,
                                                    height:26,
                                                    image: AssetImage('images/bell.png'),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 60,
                                        child: RaisedButton(
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                                          },
                                          color: Colors.transparent,
                                          elevation: 0,
                                          disabledElevation: 0,
                                          highlightColor: Colors.transparent,
                                          highlightElevation: 0,
                                          splashColor: Colors.transparent,
                                          disabledColor: Colors.transparent,
                                          child: ClipOval(
                                            child: Container(
                                                width: 26,
                                                decoration: BoxDecoration(
                                                  border:Border.all(color: Color(0xFF0E7AE6),width: 1),
                                                  borderRadius: BorderRadius.circular(13),
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  child:Image(
                                                    width: 26,
                                                    height:26,
                                                    image: AssetImage('images/my.png'),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                          // 搜索框
                          Container(
                              width: 350,
                              height: 80,
                              child: Stack(
                                  children: <Widget>[
                                    Input(
                                      hintText: "输入客户姓名或手机号",
                                      errorTipText: "请输入要查找的客户姓名或手机号",
                                      tipText: "请输入要查找的客户姓名或手机号",
                                      rightText: "请输入要查找的客户姓名或手机号",
                                      controller: searchController,
                                      inputType: TextInputType.text,
                                      reg: searchReg,
                                      onChanged: (text){
                                        setState(() {
                                          search = text;
                                          searchBool = searchReg.hasMatch(search);
                                        });
                                      },
                                    ),
                                    Positioned(
                                        left: 300,
                                        top: 18,
                                        child: GestureDetector(
                                          onTap: ()async{

                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            child: Image(image: AssetImage('images/search.png'),),
                                          ),
                                        )
                                    )
                                  ]
                              )
                          ),
                          // 分类
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 20,right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "年龄：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: ageValue,
                                      items: getAgeList(),
                                      hint: Text('所有'),
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 22,
                                      elevation: 24,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      onChanged: (T){
                                        setState(() {
                                          ageValue = T;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "原因：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: reasonValue,
                                      items: getReasonList(),
                                      hint: Text('所有'),
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 22,
                                      elevation: 24,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      onChanged: (T){
                                        setState(() {
                                          reasonValue = T;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // 列表
                          Container(
                            margin: EdgeInsets.only(bottom: 60),
                            child: Column(
                              children: <Widget>[
                                TradedItem(
                                name:"赵先生",
                                star:3,
                                gender:"男",
                                age:35,
                                phone:"15011111111",
                                birthday:"2020-08-30",
                                ),
                                TradedItem(
                                  name:"赵女士",
                                  star:2,
                                  gender:"女",
                                  age:42,
                                  phone:"15011111111",
                                  birthday:"2020-08-30",
                                ),
                                TradedItem(
                                  name:"赵先生",
                                  star:3,
                                  gender:"男",
                                  age:35,
                                  phone:"15011111111",
                                  birthday:"2020-08-30",
                                ),
                                TradedItem(
                                  name:"赵先生",
                                  star:3,
                                  gender:"男",
                                  age:35,
                                  phone:"15011111111",
                                  birthday:"2020-08-30",
                                ),
                                TradedItem(
                                  name:"赵先生",
                                  star:3,
                                  gender:"男",
                                  age:35,
                                  phone:"15011111111",
                                  birthday:"2020-08-30",
                                ),
                                TradedItem(
                                  name:"赵先生",
                                  star:3,
                                  gender:"男",
                                  age:35,
                                  phone:"15011111111",
                                  birthday:"2020-08-30",
                                ),
                              ],
                            ),
                          ),
                        ]
                    )
                  ],
                )
            )
        )
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}
