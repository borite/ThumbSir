import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/traded/traded_search_page.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/tips/qlist_tips_page.dart';
import 'package:ThumbSir/widget/house_item.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../dao/get_house_list_dao.dart';
import 'house_add_page.dart';

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
  late String search;
  late RegExp searchReg;
  bool searchBool = false;

  List<DropdownMenuItem> getWorkList(){
    List<DropdownMenuItem> workLists = [];
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
    List<DropdownMenuItem> typeLists = [];
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
    List<DropdownMenuItem> sortLists = [];
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

  var houseList = [];
  List<Widget> houseShowList = [];
  List<Widget> houses=[];


  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
      _load();
  }

  _load() async {
    _onRefresh();
    if(userData != null ){
      pageIndex ++ ;
      var getHouseListResult = await GetHouseListDao.httpGetHouseList(
        userData!.companyId,
        pageIndex.toString(),
        '30',
      );

      if (getHouseListResult.code == 200) {

        houseList = getHouseListResult.data!;
        if (houseList.length>0) {
          for (var item in houseList) {
            houseShowList.add(
              HouseItem(
                  houseItem:item
              ),
            );
          }
        }
        setState(() {
          houses=houseShowList;
        });
        _onRefresh();
      } else {
        _onLoadAlert(context);
        _onRefresh();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    searchReg = TextReg;
    _getUserInfo();
    _scrollController.addListener(() {
      // 如果滚动位置到了可滚动的最大距离，就加载更多
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print("可以加载了");
        _load();
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
                                          width: 26,
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
                                        width: 28,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>QListTipsPage()));
                                          },
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
                                        margin: EdgeInsets.only(right: 20,left: 25),
                                        width: 28,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                                          },
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
                                      password: false,
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
                                              userID:userData!.userPid,
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
                                      onChanged: (dynamic T){
                                        setState(() {
                                          workValue = T;
                                          houses = [];
                                          customersResult = null;
                                          houseShowList = [];
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
                                      onChanged: (dynamic T){
                                        setState(() {
                                          typeValue = T;
                                          houses = [];
                                          customersResult = null;
                                          houseShowList = [];
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
                                      onChanged: (dynamic T){
                                        setState(() {
                                          sortValue = T;
                                          houses = [];
                                          houseShowList = [];
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
                          houseList.length>0 && houses !=[]?
                          Column(
                            children: houses,
                          ):
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 20),
                              width: 335,
                              height: 104,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 25,bottom: 8),
                                    child: Text(
                                      '没有相关房源',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 20,
                                        color: Color(0xFFCCCCCC),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    '点击下方"新增房源"按钮去添加任务吧~',
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      color: Color(0xFFCCCCCC),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
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
