import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_customer_info_dao.dart';
import 'package:ThumbSir/dao/search_customer_dao.dart';
import 'package:ThumbSir/pages/broker/traded/traded_detail_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TradedSearchPage extends StatefulWidget {
  final keyword;
  final userID;
  TradedSearchPage({this.keyword,this.userID});
  @override
  _TradedSearchPageState createState() => _TradedSearchPageState();
}

class _TradedSearchPageState extends State<TradedSearchPage> {
  var searchResult;
  var searchResultData;
  var searchShowState = 0;

  final TextEditingController searchController=TextEditingController();
  String search;
  RegExp searchReg;
  bool searchBool;

  ScrollController _scrollController = ScrollController();

  String searchMsg;
  _load()async{
    searchResult = await SearchCustomerDao.searchCustomer(widget.keyword, widget.userID);
    if(searchResult != null){
      if(searchResult.code == 200 && searchResult.data.length > 0 ){
        setState(() {
          searchResultData = searchResult.data;
          searchShowState = 1;
        });
        _list();
      }else{
        setState(() {
          searchShowState = 0;
        });
      }
    }
  }

  var msgList;
  List<Widget> msgShowList = [];
  List<Widget> msgs=[];
  _list() async {
    if(searchShowState == 1){
      msgList=searchResult.data;
      if (msgList.length>0) {
        setState(() {
          for (var item in msgList) {
            msgs.add(
              GestureDetector(
                onTap: ()async{
                  var getItem = await GetCustomerInfoDao.getCustomerInfo(item.mid.toString());
                  if(getItem.code == 200){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedDetailPage(
                      item:getItem.data[0],
                      tabIndex: 1,
                    )));
                  }else {
                    _onOverLoadPressed(context);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 240,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      item.userName,
                                      style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 240,
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    item.phone,
                                    style:TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF999999),
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
                      Row(
                        children: <Widget>[
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: item.starslevel == 0 ?
                              Image(image: AssetImage('images/star1_e.png'),
                                fit: BoxFit.fill,) :
                              Image(image: AssetImage('images/star1_big.png'),
                                fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: item.starslevel == 2 ?
                              Image(image: AssetImage('images/star2_big.png'),
                                fit: BoxFit.fill,)
                                  : item.starslevel == 3 ?
                              Image(image: AssetImage('images/star2_big.png'),
                                fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star2_e.png'),
                                fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: item.starslevel == 3 ?
                              Image(image: AssetImage('images/star3_big.png'),
                                fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star3_e.png'),
                                fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    searchReg = TextReg;
    search = widget.keyword;
    searchMsg = widget.keyword;
    searchController.text = widget.keyword;
    _load();
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
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '查找客户',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5580EB),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                              ),),
                            )
                          ],
                        )
                    ),
                    Container(
                      width: 350,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          Input(
                            hintText: "请输入客户姓名或手机号",
                            tipText: "请输入要查找的客户姓名或手机号",
                            errorTipText: "请输入要查找的客户姓名或手机号",
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
                                  setState(() {
                                    searchMsg = searchController.text;
                                  });
                                  if(searchBool == true){
                                    searchResult = await SearchCustomerDao.searchCustomer(searchController.text, widget.userID);
                                    if(searchResult != null){
                                      if(searchResult.code == 200 && searchResult.data.length > 0){
                                        setState(() {
                                          msgs = [];
                                          searchResultData = searchResult.data;
                                          searchShowState = 1;
                                        });
                                        _list();
                                      }else{
                                        setState(() {
                                          searchShowState = 2;
                                        });
                                      }
                                    }
                                  }else{}
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image(image: AssetImage('images/search.png'),),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    // 搜索结果
                    searchShowState == 1 ?
                    Container(
                      width: 335,
                      padding: EdgeInsets.fromLTRB(10,0,15,0),
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.only(bottom: 30),
                        shrinkWrap: true,
                        itemCount: msgs.length,
                        itemBuilder: (BuildContext context,int index){
                          return msgs[index];
                        },
                      )
                    )
                    :
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                      width: 335,
                      child: Text(
                        '未查询到姓名或手机号为'+searchMsg+'的用户',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]
              )
            ],
          )
      ),
    );
  }

  _onOverLoadPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "请检查网络后重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }
}
