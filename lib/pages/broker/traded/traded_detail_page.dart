import 'package:ThumbSir/widget/loading.dart';
import 'package:ThumbSir/widget/traded_action_msg.dart';
import 'package:ThumbSir/widget/traded_basic_msg.dart';
import 'package:ThumbSir/widget/traded_deal_msg.dart';
import 'package:flutter/material.dart';

class TradedDetailPage extends StatefulWidget {
  @override
  _TradedDetailPageState createState() => _TradedDetailPageState();
}

class _TradedDetailPageState extends State<TradedDetailPage> with TickerProviderStateMixin {
  bool _loading = false;

  TabController _controller;
  //0基本信息，1成交信息，2维护动作的Tab Index
  int tabIndex=0;
  var tabs = [];

  @override
  void initState() {
    _controller = TabController(length: 3,vsync: this);
    tabs = <Tab>[
      Tab(text: '基本信息',),
      Tab(text: '成交信息',),
      Tab(text: '维护动作',),
    ];
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
            child:Stack(
                children: <Widget>[
                  // 切换页面
                  TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      // 基本信息
                      TradedBasicMsg(),
                      // 成交信息
                      TradedDealMsg(),
                      // 维护动作
                      TradedActionMsg(),
                    ],
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        // 导航栏
                        Container(
                            padding: EdgeInsets.only(left: 15,top: 15,bottom: 5),
                            margin: EdgeInsets.only(top: 15),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // 首页和标题
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 28,
                                        padding: EdgeInsets.only(top: 3),
                                        child: Image(image: AssetImage('images/back.png'),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('赵先生的详细信息',style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF5580EB),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),),
                                    )
                                  ],
                                ),
                                Container(
                                  width:50,
                                  child: Text(
                                    "删除",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF5580EB),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                        // 切换标签
                        Container(
                          alignment: Alignment.topCenter,
                          child: TabBar(
                            tabs: tabs,
                            onTap: (i){
                              setState(() {
                                tabIndex=i;
                              });
                            },
                            controller: _controller,
                            isScrollable: true, // 可以左右滑动
                            labelColor: Color(0xFF333333),
                            labelPadding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                color: tabIndex == 0? Color(0xFF0E7AE6)
                                    :tabIndex == 1?Color(0xFFF67818):
                                Color(0xFF003273),
                                width: 3,
                              ),
                              insets: EdgeInsets.only(bottom: 10),
                            ),
                            labelStyle: TextStyle(fontSize: 20),
                            unselectedLabelStyle: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )

                ]
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
