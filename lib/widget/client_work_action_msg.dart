import 'package:ThumbSir/common/alert.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/major/qlist/major_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/s_qlist_page.dart';
import 'package:flutter/material.dart';


class ClientWorkActionMsg extends StatefulWidget {
  final item;
  final result;

  ClientWorkActionMsg({Key? key,
    this.item,this.result
  }):super(key:key);
  @override
  _ClientWorkActionMsgState createState()=> _ClientWorkActionMsgState();
}

class _ClientWorkActionMsgState extends State<ClientWorkActionMsg> with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  var pageIndex=0;
  var msgList;
  List<Widget> msgShowList = [];
  List<Widget> msgs=[];
  late List action;
  bool _loading = false;

  @override
  void initState(){
    super.initState();
    // _load();
    _scrollController.addListener(() {
      // 如果滚动位置到了可滚动的最大距离，就加载更多
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // _load();
      }
    });
    setState(() {
      action = widget.item.busAct.act;
      if (action.length>0) {
        for (var item in action) {
          msgs.add(
              Container(
                width: 335,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 340,
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                          color: Colors.transparent
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 335,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(
                                    color: Color(0xFFcccccc),
                                    offset: Offset(0.0, 3.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0
                                )
                                ],
                                color: Colors.white
                            ),
                            child: Column(
                              children: <Widget>[
                                // 项目和数量
                                Container(
                                  width: 335,
                                  padding: EdgeInsets.only(top: 12, left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(right: 4),
                                              child: Container(
                                                width:20,
                                                padding: EdgeInsets.only(top: 2),
                                                child: Image(image: AssetImage('images/time.png'),),
                                              ),
                                            ),
                                            Text(
                                              item.actionName??"未知任务",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF0E7AE6),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   child: Container(
                                      //     width: 24,
                                      //     child: Image(
                                      //         image: AssetImage('images/editor.png')),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                // 时间
                                Container(
                                    width: 335,
                                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            '时间：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // item.actionTime.toString().substring(0,16)??"-",
                                          item.actionTime.toString().substring(0,16),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF666666),
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                // 任务描述
                                Container(
                                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "任务描述：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          item.actionDesc??"无",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF999999),
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // 计划地点
                                Container(
                                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '计划地点：',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 22,
                                              padding: EdgeInsets.only(right: 5,top: 2),
                                              child: Image(image: AssetImage(
                                                  'images/site_small.png'),),
                                            ),
                                            Container(
                                              child: Expanded(
                                                child: Text(
                                                  item.actionPlace??"无",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF0E7AE6),
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // 上传凭证地点
                                Container(
                                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '关联房源：',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 22,
                                              padding: EdgeInsets.only(right: 5,top: 2),
                                              child: Image(image: AssetImage(
                                                  'images/site_small.png'),),
                                            ),
                                            Container(
                                              child: Expanded(
                                                child: Text(
                                                  '未关联',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF0E7AE6),
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

              )

          );
        }
      } else {
        onLoadAlert(context);
        _onRefresh();
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
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:100,bottom:40),
                child: Column(
                  children: <Widget>[
                    // 姓名
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              margin: EdgeInsets.only(left: 20,right: 10,bottom: 10),
                              child: Image.asset("images/my_3.png"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.item.userName,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )

                          ],
                        ),
                        // 跳转按钮
                        GestureDetector(
                          onTap: (){
                            if(widget.result.userLevel.substring(0,1)=="6"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                            }
                            if(widget.result.userLevel.substring(0,1)=="5"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                            }
                            if(widget.result.userLevel.substring(0,1)=="4"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                            }
                            if(widget.result.userLevel.substring(0,1)=="1"||widget.result.userLevel.substring(0,1)=="2"||widget.result.userLevel.substring(0,1)=="3"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                            margin: EdgeInsets.only(right: 20,top: 2,bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xFF93C0FB)
                                ),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text(
                              "前往业务量化模块",
                              style: TextStyle(
                                  color: Color(0xFF93C0FB),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 维护记录列表
                    Container(
                        child: msgs.length>0 ?
                        ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(bottom: 30),
                          shrinkWrap: true,
                          itemCount: msgs.length,
                          itemBuilder: (BuildContext context,int index){
                            return msgs[index];
                          },
                        )
                            :
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            '暂无业务动作记录',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF999999)
                            ),
                          ),
                        )
                    ),
                ]),
              )
            ],
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
