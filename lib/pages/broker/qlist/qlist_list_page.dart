import 'package:ThumbSir/pages/mycenter/my_center_notlogin_page.dart';
import 'package:ThumbSir/widget/past_qlist.dart';
import 'package:ThumbSir/widget/today_qlist.dart';
import 'package:ThumbSir/widget/tomorrow_qlist.dart';
import 'package:flutter/cupertino.dart';
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
              children: <Widget>[
                // 今日计划
                TodayQList(),
                // 明日计划
                TomorrowQList(),
                // 往期计划
                PastQList(),
              ],
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
                            height: 300,
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
                                  height: 70,
                                  padding: EdgeInsets.only(top: 30),
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
                                Container(
                                  width: 335,
                                  padding: EdgeInsets.only(left:20),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
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
                                ),
                              ],
                            )
                        ),
                      ),
                    )
                  ]
              ),
            ),
            // 今日任务未排满的提示
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child:Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
                    },
                    child: Container(
                      width: 233,
                      height: 90,
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
            children: <Widget>[
              // 今日计划
              TodayQList(),
              // 明日计划
              TomorrowQList(),
              // 往期计划
              PastQList(),
            ],
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
                          height: 300,
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
                                height: 70,
                                padding: EdgeInsets.only(top: 30),
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
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(left:20),
                                child: Row(
                                  children: <Widget>[
                                    Container(
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
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
                },
                child: Container(
                  width: 233,
                  height: 90,
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
            children: <Widget>[
              // 今日计划
              TodayQList(),
              // 明日计划
              TomorrowQList(),
              // 往期计划
              PastQList(),
            ],
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
                          height: 300,
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
                                height: 70,
                                padding: EdgeInsets.only(top: 30),
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
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(left:20),
                                child: Row(
                                  children: <Widget>[
                                    Container(
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