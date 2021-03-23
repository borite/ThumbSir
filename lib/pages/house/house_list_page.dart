import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_care_action_dao.dart';
import 'package:ThumbSir/dao/get_customer_main_dao.dart';
import 'package:ThumbSir/dao/get_user_by_condition_dao.dart';
import 'package:ThumbSir/model/get_customer_main_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/traded/traded_add_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_search_page.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/house/house_add_page.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:ThumbSir/widget/house_item.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:ThumbSir/widget/traded_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HouseListPage extends StatefulWidget {
  @override
  _HouseListPageState createState() => _HouseListPageState();
}

class _HouseListPageState extends State<HouseListPage> {
  var pageIndex=0;
  var customersResult;
  ScrollController _scrollController = ScrollController();

  bool _loading = false;
  var workValue = "所有";
  var typeValue = 0;
  var sortValue = "时间近";

  final TextEditingController searchController = TextEditingController();
  String search;
  RegExp searchReg;
  bool searchBool;

  List<DropdownMenuItem> getWorkList(){
    List<DropdownMenuItem> workLists = new List();
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: '所有',);
    workLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('出售'),value: '出售',);
    workLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('出租'),value: '出租',);
    workLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('我的'),value: '我的',);
    workLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('下架'),value: '下架',);
    workLists.add(ageList5);
    return workLists;
  }

  List<DropdownMenuItem> getTypeList(){
    List<DropdownMenuItem> typeLists = new List();
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: 0,);
    typeLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('住宅'),value: 1,);
    typeLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('商铺'),value: 2,);
    typeLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('公寓'),value: 3,);
    typeLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('车位'),value: 4,);
    typeLists.add(ageList5);
    return typeLists;
  }

  List<DropdownMenuItem> getSortList(){
    List<DropdownMenuItem> sortLists = new List();
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('时间近'),value: '时间近',);
    sortLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('时间远'),value: '时间远',);
    sortLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('带看量'),value: '带看量',);
    sortLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('价格升'),value: '价格升',);
    sortLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('价格降'),value: '价格降',);
    sortLists.add(ageList5);
    return sortLists;
  }

  List<Datum> customersList = [];
  List<Widget> customersShowList = [];
  List<Widget> customers=[];


  LoginResultData userData;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uinfo));
      });
      // _load();
    }
  }

  // _load() async {
  //   _onRefresh();
  //   if(userData != null ){
  //     pageIndex ++ ;
  //
  //     if(ageValue == "所有" && monthValue == 0 && reasonValue == "所有"){
  //       customersResult = await GetCustomerMainDao.getCustomerMain(
  //         userData.userPid,
  //         "5",
  //         pageIndex.toString(),
  //         '50',
  //       );
  //     }else{
  //       customersResult = await GetUserByConditionDao.getCondition(
  //           ageValue == "所有"?"0":ageValue == "< 30岁"?"1":ageValue == "30~40"?"30":ageValue == "40~50"?"40":"50",
  //           ageValue == "所有"?"0":ageValue == "< 30岁"?"30":ageValue == "30~40"?"40":ageValue == "40~50"?"50":"100",
  //           monthValue.toString(),
  //           reasonValue == "所有"?"0":reasonValue,
  //           userData.userPid,
  //       );
  //     }
  //
  //     if (customersResult.code == 200) {
  //
  //       customersList = customersResult.data;
  //       if (customersList.length>0) {
  //         for (var item in customersList) {
  //           var giftResult = await GetCareActionDao.httpGetCareAction(item.mid.toString(), "1", "10");
  //           var giftList = giftResult.data;
  //           customersShowList.add(
  //             TradedItem(
  //                 name:item.userName,
  //                 star:item.starslevel,
  //                 gender:item.sex,
  //                 age:item.age,
  //                 phone:item.phone,
  //                 birthday:item.birthday.toString().substring(0,10),
  //                 firstDealReason: item.dealList.length > 0 ?item.dealList[0].dealReason:null,
  //                 firstDealTime: item.dealList.length > 0 ? item.dealList[0].finishTime.toIso8601String().substring(0,10):null,
  //                 secondDealReason: item.dealList.length > 1 ?item.dealList[1].dealReason:null,
  //                 ssecondDealTime: item.dealList.length > 1 ?item.dealList[1].finishTime.toIso8601String().substring(0,10):null,
  //                 giftList: giftList,
  //                 item:item
  //             ),
  //           );
  //         };
  //       }
  //       setState(() {
  //         customers=customersShowList;
  //       });
  //       _onRefresh();
  //     } else {
  //       _onLoadAlert(context);
  //       _onRefresh();
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    searchReg = TextReg;
    _getUserInfo();
    _scrollController.addListener(() {
      // 如果滚动位置到了可滚动的最大距离，就加载更多
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print("可以加载了");
        // _load();
      }
    });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseAddPage()));
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
                                        child: Text('房源系统',style: TextStyle(
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
                                      hintText: "输入小区名称或房源编号",
                                      errorTipText: "请输入要查找的小区名称或房源编号",
                                      tipText: "请输入要查找的小区名称或房源编号",
                                      rightText: "请输入要查找的小区名称或房源编号",
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedSearchPage(
                                              keyword:searchController.text,
                                              userID:userData.userPid,
                                            )));
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // 业务
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "业务：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: workValue,
                                      items: getWorkList(),
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
                                          workValue = T;
                                          customers = [];
                                          customersResult = null;
                                          customersShowList = [];
                                          pageIndex = 0;
                                        });
                                        // _load();
                                      },
                                    )
                                  ],
                                ),
                                // 房源类型
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "类型：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: typeValue,
                                      items: getTypeList(),
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
                                          typeValue = T;
                                          customers = [];
                                          customersResult = null;
                                          customersShowList = [];
                                          pageIndex = 0;
                                        });
                                        // _load();
                                      },
                                    )
                                  ],
                                ),
                                // 高级筛选
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "排序：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: sortValue,
                                      items: getSortList(),
                                      hint: Text('时间近'),
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
                                          sortValue = T;
                                          customers = [];
                                          customersShowList = [];
                                          customersResult = null;
                                          pageIndex = 0;
                                        });
                                        // _load();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // 高级搜索
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  "高级筛选：",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Expanded(
                                  child:Wrap(
                                    spacing: 4,
                                    children: [
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('2居室',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('朝南',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('中楼层',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('80-120平米',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('精装修',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                    ],
                                  )

                                ),
                                GestureDetector(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditBasicMsgPage(
                                    //   item: widget.item,
                                    // )));
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 20,
                                    color: Colors.transparent,
                                    child: Image.asset("images/editor.png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // 列表
                          Column(
                            children: [
                              HouseItem()
                            ],
                          )
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

  _onLoadAlert(context) {
    Alert(
      context: context,
      title: "加载失败",
      desc: "请检查网络连接情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
