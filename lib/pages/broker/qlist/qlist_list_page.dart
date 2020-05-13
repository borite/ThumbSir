import 'dart:typed_data';

import 'package:ThumbSir/pages/broker/mycenter/my_center_notlogin_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_upload_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/tips/qlist_tips_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_add_page.dart';

class QListListPage extends StatefulWidget {
  @override
  _QListListPageState createState() => _QListListPageState();
}

class _QListListPageState extends State<QListListPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  var tabs = [];
  int _pageIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 3,vsync: this);
    tabs = <Tab>[
      Tab(text: '今日计划',),
      Tab(text: '明日计划',),
      Tab(text: '往期计划',),
    ];

    super.initState();
  }

  // 防止页面销毁时内存泄漏造成性能问题
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _pageIndex == 0 ?
    // 上午
    Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            TabBarView(
            controller: _controller,
            children: tabs.map((tab)=>ListView(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child:Padding(
                          padding: EdgeInsets.only(top:295,bottom:25),
                          child: Column(
                            children: <Widget>[
                              // 每一条量化
                              _continueItem('带看','3套','10:00-11:00',65),
                              _finishItem('带看','3套','10:00-11:00'),
                              _extendItem('带看','3套','10:00-11:00',77),
                              _continueItem('带看','3套','10:00-11:00',30),
                              _continueItem('带看','3套','10:00-11:00',65),
                            ],
                          ),
                        )),
                      ])
                  ).toList()
                ),
            // 顶部导航区域
            Positioned(
              child: Column(
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ClipPath(
                        clipper: BottomClipper(),
                        child:
                        //  背景
                        Container(
                            height: 335,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF0E7AE6),Color(0xFF93C0FB)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              image: DecorationImage(
                                image:AssetImage('images/circle_s.png'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            child:Column(
                              children: <Widget>[
                                // 顶部信息与消息、个人中心按钮
                                Container(
                                  height: 100,
                                  padding: EdgeInsets.only(top:30),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(left: 15,top: 3),
                                              child: Image(image: AssetImage('images/back_white.png'),),
                                            ),
                                          ),
                                          Container(
                                            margin:EdgeInsets.only(top: 3,left:10),
                                            child: Text(
                                              '共10个计划',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF93C0FB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:EdgeInsets.only(left:3,right: 3),
                                            child: Text(
                                              '|',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF93C0FB),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:EdgeInsets.only(top: 3),
                                            child: Text(
                                              '已完成9个',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF93C0FB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
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
                                                    decoration: BoxDecoration(color: Colors.white),
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
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterNotLoginPage()));
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
                                                    decoration: BoxDecoration(color: Colors.white),
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
                                  ),
                                ),
                                // 计划导航
                                Container(
                                  padding: EdgeInsets.only(left: 0,right: 100),
                                  child: TabBar(
                                    tabs: tabs,
                                    controller: _controller,
                                    isScrollable: true, // 可以左右滑动
                                    labelColor: Colors.white,
                                    labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 5),
                                    indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                        color: Color(0xFF0E7AE6),
                                        width: 3,
                                      ),
                                      insets: EdgeInsets.only(bottom: 10),
                                    ),
                                    labelStyle: TextStyle(fontSize: 20),
                                    unselectedLabelStyle: TextStyle(fontSize: 14),
                                  ),
                                ),
                                // 上午、下午、晚上导航
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left:90),
                                      child: Image(image:AssetImage('images/morning.png')),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:20,right:30,top:50),
                                      child:GestureDetector(
                                        child: Text(
                                            '上午',
                                            style: TextStyle(
                                              fontSize: 20,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,
                                            ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            _pageIndex = 0;
                                          });
                                        },
                                    )
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right:30,top:58),
                                      child:GestureDetector(
                                        child: Text(
                                          '下午',
                                          style: TextStyle(fontSize: 14,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            _pageIndex = 1;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top:58),
                                      child: GestureDetector(
                                        child: Text(
                                          '晚上',
                                          style: TextStyle(
                                            fontSize: 14,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onTap: (){
                                          setState((){
                                            _pageIndex = 2;
                                          });
                                          print('$_pageIndex');
                                        },
                                      )
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),
                      ),
                    )
                  ]
              ),
            ),
            // 任务未排满的提示
            Positioned(
                bottom:20,
                left:90,
                width: 233,
                height: 90,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:AssetImage('images/warnbox.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width:20,
                          padding: EdgeInsets.only(top: 15,bottom: 8),
                          child: Image(image: AssetImage('images/warn.png'),),
                        ),
                        Text('您的今日任务时间不连贯，点我安排',style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFF24848)
                        ),),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
    )
    :_pageIndex == 1 ?
    // 下午
    Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: <Widget>[
          TabBarView(
              controller: _controller,
              children: tabs.map((tab)=>ListView(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child:Padding(
                          padding: EdgeInsets.only(top:295,bottom:25),
                          child: Column(
                            children: <Widget>[
                              // 每一条量化
                              _continueItem('带看','3套','10:00-11:00',65),
                              _finishItem('带看','3套','10:00-11:00'),
                              _extendItem('带看','3套','10:00-11:00',77),
                              _continueItem('带看','3套','10:00-11:00',30),
                              _continueItem('带看','3套','10:00-11:00',65),
                            ],
                          ),
                        )),
                  ])
              ).toList()
          ),
          // 顶部导航区域
          Positioned(
            child: Column(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ClipPath(
                      clipper: BottomClipper(),
                      child:
                      //  背景
                      Container(
                          height: 335,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFF67818),Color(0xFFFCD654)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image:AssetImage('images/circle_s.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          child:Column(
                            children: <Widget>[
                              // 顶部信息与消息、个人中心按钮
                              Container(
                                height: 100,
                                padding: EdgeInsets.only(top:30),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 15,top: 3),
                                            child: Image(image: AssetImage('images/back_white.png'),),
                                          ),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 3,left:10),
                                          child: Text(
                                            '共10个计划',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFF67818),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(left:3,right: 3),
                                          child: Text(
                                            '|',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFFF67818),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 3),
                                          child: Text(
                                            '已完成9个',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFF67818),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                        ),
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
                                                  decoration: BoxDecoration(color: Colors.white),
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterNotLoginPage()));
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
                                                  decoration: BoxDecoration(color: Colors.white),
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
                                ),
                              ),
                              // 计划导航
                              Container(
                                padding: EdgeInsets.only(left: 0,right: 100),
                                child: TabBar(
                                  tabs: tabs,
                                  controller: _controller,
                                  isScrollable: true, // 可以左右滑动
                                  labelColor: Colors.white,
                                  labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 5),
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF67818),
                                      width: 3,
                                    ),
                                    insets: EdgeInsets.only(bottom: 10),
                                  ),
                                  labelStyle: TextStyle(fontSize: 20),
                                  unselectedLabelStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                              // 上午、下午、晚上导航
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left:90),
                                    child: Image(image:AssetImage('images/noon.png')),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left:20,right:30,top:58),
                                      child: GestureDetector(
                                        child: Text(
                                          '上午',
                                          style: TextStyle(
                                            fontSize: 14,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onTap: (){
                                          setState((){
                                            _pageIndex = 0;
                                          });
                                          print('$_pageIndex');
                                        },
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(right:30,top:50),
                                      child:GestureDetector(
                                        child: Text(
                                          '下午',
                                          style: TextStyle(
                                            fontSize: 20,color: Color(0xFFF24848),decoration: TextDecoration.none,fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            _pageIndex = 1;
                                          });
                                        },
                                      )
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top:58),
                                    child:GestureDetector(
                                      child: Text(
                                        '晚上',
                                        style: TextStyle(fontSize: 14,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _pageIndex = 2;
                                        });
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                  )
                ]
            ),
          ),
          // 明日任务没安排满的提示
          Positioned(
            bottom:20,
            left:90,
            width: 233,
            height: 90,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage('images/warnbox.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width:20,
                      padding: EdgeInsets.only(top: 15,bottom: 8),
                      child: Image(image: AssetImage('images/bell_yellow.png'),),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
                      },
                      child: Text('您的明日任务没有安排满，点我安排',style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF9600)
                      ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
    :
    // 晚上
    Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: <Widget>[
          TabBarView(
              controller: _controller,
              children: tabs.map((tab)=>ListView(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child:Padding(
                          padding: EdgeInsets.only(top:295,bottom:25),
                          child: Column(
                            children: <Widget>[
                              // 每一条量化
                              _continueItem('带看','3套','10:00-11:00',65),
                              _finishItem('带看','3套','10:00-11:00'),
                              _extendItem('带看','3套','10:00-11:00',77),
                              _continueItem('带看','3套','10:00-11:00',30),
                              _continueItem('带看','3套','10:00-11:00',65),
                            ],
                          ),
                        )),
                  ])
              ).toList()
          ),
          // 顶部导航区域
          Positioned(
            child: Column(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ClipPath(
                      clipper: BottomClipper(),
                      child:
                      //  背景
                      Container(
                          height: 335,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF000747),Color(0xFF003273)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                              image:AssetImage('images/circle_s.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          child:Column(
                            children: <Widget>[
                              // 顶部信息与消息、个人中心按钮
                              Container(
                                height: 100,
                                padding: EdgeInsets.only(top:30),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 15,top: 3),
                                            child: Image(image: AssetImage('images/back_white.png'),),
                                          ),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 3,left:10),
                                          child: Text(
                                            '共10个计划',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF7412F2),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(left:3,right: 3),
                                          child: Text(
                                            '|',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF7412F2),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:EdgeInsets.only(top: 3),
                                          child: Text(
                                            '已完成9个',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF7412F2),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                        ),
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
                                                  decoration: BoxDecoration(color: Colors.white),
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterNotLoginPage()));
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
                                                  decoration: BoxDecoration(color: Colors.white),
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
                                ),
                              ),
                              // 计划导航
                              Container(
                                padding: EdgeInsets.only(left: 0,right: 100),
                                child: TabBar(
                                  tabs: tabs,
                                  controller: _controller,
                                  isScrollable: true, // 可以左右滑动
                                  labelColor: Colors.white,
                                  labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 5),
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      color: Color(0xFF003273),
                                      width: 3,
                                    ),
                                    insets: EdgeInsets.only(bottom: 10),
                                  ),
                                  labelStyle: TextStyle(fontSize: 20),
                                  unselectedLabelStyle: TextStyle(fontSize: 14),
                                ),
                              ),
                              // 上午、下午、晚上导航
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left:90),
                                    child: Image(image:AssetImage('images/evening.png')),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left:20,right:30,top:58),
                                    child:GestureDetector(
                                      child: Text(
                                        '上午',
                                        style: TextStyle(fontSize: 14,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _pageIndex = 0;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(right:30,top:58),
                                      child: GestureDetector(
                                        child: Text(
                                          '下午',
                                          style: TextStyle(
                                            fontSize: 14,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onTap: (){
                                          setState((){
                                            _pageIndex = 1;
                                          });
                                          print('$_pageIndex');
                                        },
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top:50),
                                      child:GestureDetector(
                                        child: Text(
                                          '晚上',
                                          style: TextStyle(
                                            fontSize: 20,color: Color(0xFF9149EC),decoration: TextDecoration.none,fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            _pageIndex = 2;
                                          });
                                        },
                                      )
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                  )
                ]
            ),
          ),
        ],
      ),
    );

  }
  // 未完成的item
  _continueItem(String name,String number,String time,double percent){
    return Stack(
      children: <Widget>[
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 300,
                height: 104,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    // 项目和数量
                    Container(
                      width: 270,
                      padding: EdgeInsets.only(top:12),
                      child: Row(
                        children: <Widget>[
                          Image(image: AssetImage('images/time.png'),),
                          Padding(
                            padding:EdgeInsets.only(left:4),
                            child: Text(
                              name,
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF0E7AE6),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:4,top:3),
                            child: Text(
                              number,
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                      width:270,
                      padding:EdgeInsets.only(top:5,bottom: 8),
                      child: Text(
                        '时间 '+time,
                        style:TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:270,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star1.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star2.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star3.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star4.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star5.png'),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        // 圆形进度条
        Positioned(
          left: 260,
          top:14,
          child: Container(
            width: 74,
            height: 74,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(37),
              boxShadow: [BoxShadow(
                  color: Color(0xFFcccccc),
                  offset: Offset(2, 2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              )],
            ),
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                startAngle: 280,
                angleRange: 360,
                customWidths: CustomSliderWidths(progressBarWidth: 7),
                customColors: CustomSliderColors(
                  progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                  trackColor: Color(0x20CCCCCC),
                  dotColor: Colors.transparent,
                ),
                infoProperties: InfoProperties(
                  mainLabelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2692FD),
                  )
                )
              ),
              min: 0,
              max: 100,
              initialValue: percent,
            ),
          ),
        )
      ],
    );
  }

  // 已完成的item
  _finishItem(String name,String number,String time){
    return Stack(
      children: <Widget>[
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
              color: Colors.transparent
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 300,
                height: 104,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                        color: Color(0xFFcccccc),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0
                    )],
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    // 项目和数量
                    Container(
                      width: 270,
                      padding: EdgeInsets.only(top:12),
                      child: Row(
                        children: <Widget>[
                            Text(
                              '恭喜你!完成 '+name,
                              style:TextStyle(
                                fontSize: 20,
                                color: Color(0xFF24CC8E),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:4,top:3),
                            child: Text(
                              number,
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF24CC8E),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                      width:270,
                      padding:EdgeInsets.only(top:5,bottom: 8),
                      child: Text(
                        '时间 '+time,
                        style:TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:270,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star1.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star2.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star3.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star4.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:3),
                            child: Image(image: AssetImage('images/star5.png'),),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),

        // 已完成圆形进度条
        Positioned(
          left: 260,
          top:14,
          child: Container(
            width: 74,
            height: 74,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(37),
              boxShadow: [BoxShadow(
                  color: Color(0xFFcccccc),
                  offset: Offset(2, 2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              )],
            ),
            child: Image(image:AssetImage('images/finish.png')),
          ),
        )
      ],
    );
  }

  // 展开的item
  _extendItem(String name,String number,String time,double percent){
    return Stack(
      children: <Widget>[
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 25),
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
                    )],
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    // 项目和数量
                    Container(
                      width: 335,
                      padding: EdgeInsets.only(top:12,left:15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                name,
                                style:TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF24CC8E),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:4,top:3),
                                child: Text(
                                  number,
                                  style:TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF24CC8E),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>QListUploadPage()));
                            },
                            child: Container(
                              width: 24,
                              child: Image(image: AssetImage('images/upload.png')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 完成度
                    Container(
                      padding: EdgeInsets.only(top:80,left:20),
                      width: 335,
                      child: Text(
                        '完成度',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:335,
                      padding: EdgeInsets.only(top:20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left:20,right: 42),
                            child: Text(
                              '重要性',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star1.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star2.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star3.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star4.png'),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right:3),
                                  child: Image(image: AssetImage('images/star5.png'),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                      width:335,
                      padding:EdgeInsets.only(bottom: 20),
                      child:Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20,right: 83),
                            child: Text(
                              '时间',
                              style:TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Text(
                            time,
                            style:TextStyle(
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
                        width:335,
                        child:
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '任务描述',
                                style:TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                    ),
                    // 任务描述详情
                    Container(
                        width:335,
                        child:
                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                          child: Text(
                            '共带看3套房，客户对第二套比较满意,共带看3套房，客户对第二套比较满意,共带看3套房，客户对第二套比较满意',
                            style:TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                    ),
                    // 定位
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          // 每一条定位
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage('images/site_small.png'),),
                                ),
                                Text(
                                  '新华大街新华地铁口惠明小区',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage('images/site_small.png'),),
                                ),
                                Text(
                                  '新华大街新华地铁口惠明小区',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage('images/site_small.png'),),
                                ),
                                Text(
                                  '新华大街新华地铁口惠明小区',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 图片上传
                    Container(
                        width:335,
                        child:
                        Padding(
                          padding: EdgeInsets.only(left: 20,top: 10,bottom: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '图片上传',
                                style:TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                        )
                    ),
                    // 图片
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    // 收起按钮
                    Container(
                      width: 33,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Image(
                        image: AssetImage('images/upbtn.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        // 圆形进度条
        Positioned(
          top:35,
          left: 115,
          child: Container(
            width: 110,
            height: 110,
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                  startAngle: 280,
                  angleRange: 360,
                  customWidths: CustomSliderWidths(progressBarWidth: 12),
                  customColors: CustomSliderColors(
                    progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                    trackColor: Color(0x20CCCCCC),
                    dotColor: Colors.transparent,
                  ),
                  infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF2692FD),
                      )
                  )
              ),
              min: 0,
              max: 100,
              initialValue: percent,
            ),
          ),
        )
      ],
    );
  }
}

// 导航区域下曲线
class BottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height-70.0); //第2个点
    var firstControlPoint = Offset(size.width/2, size.height);
    var firstEdnPoint = Offset(size.width, size.height-70.0);
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEdnPoint.dx,
        firstEdnPoint.dy
    );
    path.lineTo(size.width, size.height-50.0); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
