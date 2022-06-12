import 'package:ThumbSir/dao/get_care_action_dao.dart';
import 'package:ThumbSir/dao/get_customer_list_dao.dart';
import 'package:ThumbSir/widget/client_check_item.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeamClientMemberPage extends StatefulWidget {
  final userId;
  final userLevel;
  final userName;
  TeamClientMemberPage({this.userId,this.userLevel,this.userName});
  @override
  _TeamClientMemberPageState createState() => _TeamClientMemberPageState();
}

class _TeamClientMemberPageState extends State<TeamClientMemberPage> {
  var pageIndex=0;
  var customersResult;
  ScrollController _scrollController = ScrollController();

  bool _loading = false;
  var ageValue = "所有";
  var monthValue = 0;
  var needValue = "所有";

  final TextEditingController searchController = TextEditingController();
  late String search;
  late RegExp searchReg;
  bool searchBool = false;

  List<DropdownMenuItem> getAgeList(){
    List<DropdownMenuItem> ageLists = [];
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: '所有',);
    ageLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('< 30岁'),value: '< 30岁',);
    ageLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('30~40'),value: '30~40',);
    ageLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('40~50'),value: '40~50',);
    ageLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('> 50岁'),value: '> 50岁',);
    ageLists.add(ageList5);
    return ageLists;
  }

  List<DropdownMenuItem> getMonthList(){
    List<DropdownMenuItem> monthLists = [];
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: 0,);
    monthLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('1月'),value: 1,);
    monthLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('2月'),value: 2,);
    monthLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('3月'),value: 3,);
    monthLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('4月'),value: 4,);
    monthLists.add(ageList5);
    DropdownMenuItem ageList6 = new DropdownMenuItem(child: Text('5月'),value: 5,);
    monthLists.add(ageList6);
    DropdownMenuItem ageList7 = new DropdownMenuItem(child: Text('6月'),value: 6,);
    monthLists.add(ageList7);
    DropdownMenuItem ageList8 = new DropdownMenuItem(child: Text('7月'),value: 7,);
    monthLists.add(ageList8);
    DropdownMenuItem ageList9 = new DropdownMenuItem(child: Text('8月'),value: 8,);
    monthLists.add(ageList9);
    DropdownMenuItem ageList10 = new DropdownMenuItem(child: Text('9月'),value: 9,);
    monthLists.add(ageList10);
    DropdownMenuItem ageList11 = new DropdownMenuItem(child: Text('10月'),value: 10,);
    monthLists.add(ageList11);
    DropdownMenuItem ageList12 = new DropdownMenuItem(child: Text('11月'),value: 11,);
    monthLists.add(ageList12);
    DropdownMenuItem ageList13 = new DropdownMenuItem(child: Text('12月'),value: 12,);
    monthLists.add(ageList13);
    return monthLists;
  }

  List<DropdownMenuItem> getNeedList(){
    List<DropdownMenuItem> needLists = [];
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: '所有',);
    needLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('出售'),value: '出售',);
    needLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('出租'),value: '出租',);
    needLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('购买'),value: '购买',);
    needLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('租赁'),value: '租赁',);
    needLists.add(ageList5);
    DropdownMenuItem ageList6 = new DropdownMenuItem(child: Text('多次'),value: '多次',);
    needLists.add(ageList6);
    DropdownMenuItem ageList7 = new DropdownMenuItem(child: Text('暂无'),value: '暂无',);
    needLists.add(ageList7);
    return needLists;
  }

  List customersList = [];
  List<Widget> customersShowList = [];
  List<Widget> customers=[];

  _load() async {
    _onRefresh();
    pageIndex ++ ;

    if(ageValue == "所有" && monthValue == 0 && needValue == "所有"){
      customersResult = await GetCustomerListDao.getCustomerList(
        '0',
        '0',
        '0',
        widget.userId,
        "0",
        "5",
        pageIndex.toString(),
        '50',
      );
    }else{
      customersResult = await GetCustomerListDao.getCustomerList(
        ageValue == "所有"?"0":ageValue == "< 30岁"?"1":ageValue == "30~40"?"30":ageValue == "40~50"?"40":"50",
        ageValue == "所有"?"0":ageValue == "< 30岁"?"30":ageValue == "30~40"?"40":ageValue == "40~50"?"50":"100",
        monthValue.toString(),
        widget.userId,
        needValue == "所有"?"0":needValue,
        "5",
        pageIndex.toString(),
        '50',
      );
    }

    if (customersResult.code == 200) {
      print(customersResult);
      customersList = customersResult.data;
      if (customersList.length>0) {
        for (var item in customersList) {
          var giftResult = await GetCareActionDao.httpGetCareAction(item.mid.toString(), "1", "10");
          var giftList = giftResult.data;
          customersShowList.add(
            ClientCheckItem(
                name:item.userName,
                star:item.starslevel,
                gender:item.sex,
                age:item.age,
                phone:item.phone,
                birthday:item.birthday.toString().substring(0,10),
                need: item.needs,
                action:item.busAct,
                giftList: giftList,
                item:item
            ),
          );
        }
      }
      setState(() {
        customers=customersShowList;
      });
      _onRefresh();
    } else {
      _onLoadAlert(context);
      _onRefresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
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
    super.dispose();
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
                        padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Image(image: AssetImage('images/back.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.userName+'的客户',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF5580EB),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                  ),),
                                )
                              ],
                            ),
                          ],
                        )
                    ),
                    // 分类
                    Container(
                      width: 335,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // 年龄
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
                                onChanged: (dynamic T){
                                  setState(() {
                                    ageValue = T;
                                    customers = [];
                                    customersResult = null;
                                    customersShowList = [];
                                    pageIndex = 0;
                                  });
                                  _load();
                                },
                              )
                            ],
                          ),
                          // 生日
                          Row(
                            children: <Widget>[
                              Text(
                                "生日：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              DropdownButton(
                                value: monthValue,
                                items: getMonthList(),
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
                                    monthValue = T;
                                    customers = [];
                                    customersResult = null;
                                    customersShowList = [];
                                    pageIndex = 0;
                                  });
                                  _load();
                                },
                              )
                            ],
                          ),
                          // 成交原因
                          Row(
                            children: <Widget>[
                              Text(
                                "需求：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              DropdownButton(
                                value: needValue,
                                items: getNeedList(),
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
                                    needValue = T;
                                    customers = [];
                                    customersShowList = [];
                                    customersResult = null;
                                    pageIndex = 0;
                                  });
                                  _load();
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
                        child:
                        customersList!=[] && customersList.length != 0 && customers != []?
                        ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: customers.length,
                          itemBuilder: (BuildContext context,int index){
                            return customers[index];
                          },
                        )
                            :
                        Container(
                            margin: EdgeInsets.only(top: 25),
                            width: 335,
                            height: 104,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 25,bottom: 8),
                                  child: Text(
                                    '该成员未添加客户',
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
                                  '提醒TA添加吧~',
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
                        ),
                    ),
                  ]
              )
            ],
          )
      ),
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
