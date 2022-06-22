import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/search_house_dao.dart';
import 'package:ThumbSir/widget/house_item.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/qlist_choose_house_item.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QlistHouseSearchPage extends StatefulWidget {
  QlistHouseSearchPage();
  @override
  _QlistHouseSearchPageState createState() => _QlistHouseSearchPageState();
}

class _QlistHouseSearchPageState extends State<QlistHouseSearchPage> {
  dynamic searchResult;
  dynamic searchResultData;
  var searchShowState = 1;
  final TextEditingController searchController=TextEditingController();
  late String search;
  late String searchMsg;
  late RegExp searchReg;
  bool searchBool = false;
  ScrollController _scrollController = ScrollController();

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
              QlistChooseHouseItem(houseItem:item)
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
  }

  @override
  void dispose(){
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取上一页传来的companyID
    dynamic companyID = ModalRoute.of(context)!.settings.arguments;
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
                                '查找房源',
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
                            hintText: "请输入小区名称或房源编号",
                            tipText: "请输入要查找的小区名称或房源编号",
                            errorTipText: "请输入要查找的小区名称或房源编号",
                            rightText: "请输入要查找的小区名称或房源编号",
                            controller: searchController,
                            inputType: TextInputType.text,
                            reg: searchReg,
                            onChanged: (text){
                              setState(() {
                                search = text;
                                searchBool = searchReg.hasMatch(search);
                              });
                            }, password: false,
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
                                    dynamic companyID1 = companyID.toString().split(" ")[1].toString().split("}")[0].toString();
                                    print(companyID1);
                                    searchResult = await SearchHouseDao.httpSearchHouse(searchController.text,companyID1);
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
                        '未查询到小区名称或编号为'+searchMsg+'的房源',
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
