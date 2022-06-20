import 'package:ThumbSir/dao/get_house_list_by_team_dao.dart';
import 'package:ThumbSir/widget/house_item.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/get_house_list_model.dart';

class TeamHouseMemberPage extends StatefulWidget {
  final userName;
  final companyId;
  final houseIDs;
  TeamHouseMemberPage({this.userName,this.companyId,this.houseIDs});
  @override
  _TeamHouseMemberPageState createState() => _TeamHouseMemberPageState();
}

class _TeamHouseMemberPageState extends State<TeamHouseMemberPage> {
  var pageIndex=0;
  dynamic housesResult;
  ScrollController _scrollController = ScrollController();

  bool _loading = false;
  List<Datum> housesList = [];
  List<Widget> housesShowList = [];
  List<Widget> houses=[];

  _load() async {
    _onRefresh();
    pageIndex ++ ;
    housesResult = await GetHouseListByTeamDao.httpGetHouseListByTeam(
      widget.companyId,
      widget.houseIDs
    );

    if (housesResult.code == 200) {
      housesList = housesResult.data;
      if (housesList.length>0) {
        for (var item in housesList) {
          housesShowList.add(
            HouseItem(
                houseItem:item
            ),
          );
        }
      }
      setState(() {
        houses=housesShowList;
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
                        padding: EdgeInsets.only(left: 15,top: 15,bottom: 5),
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
                                    widget.userName+'的在维护房源',
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
                    // 列表
                    Container(
                        margin: EdgeInsets.only(bottom: 60),
                        child:
                        housesList!=[] && housesList.length != 0 && houses != []?
                        ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: houses.length,
                          itemBuilder: (BuildContext context,int index){
                            return houses[index];
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
                                    '该成员暂无在维护房源',
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
                                  '督促他努力吧~',
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
