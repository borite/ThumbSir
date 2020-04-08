import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/mycenter/my_center_page.dart';
import 'package:ThumbSir/pages/broker/openclient/open_client_page.dart';
import 'package:ThumbSir/pages/broker/openowner/open_owner_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF003273),Color(0xFF0E7AE6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        image: DecorationImage(
          image:AssetImage('images/circle.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        children: <Widget>[
          // 个人中心按钮
          Padding(
            padding: EdgeInsets.only(top: 40,left:320),
            child:RaisedButton(
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
            )
          ),

          // 轮播图
          Container(
            height: 100,
            width: 335,
            margin: EdgeInsets.only(bottom: 25),
            child:Container(
                child: PageView(
                  children: <Widget>[
                    // 每一条轮播
                    _item('images/cake.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!'),
                    _item('images/cake.png','2020年3月24日','今天是徐姐的生日','记得送祝福!'),
                  ],
                ),
            )
          ),

          // 入口
          Container(
            margin: EdgeInsets.only(top: 20),
            child:RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
              },
              color: Colors.transparent,
              elevation: 0,
              disabledElevation: 0,
              highlightColor: Colors.transparent,
              highlightElevation: 0,
              splashColor: Colors.transparent,
              disabledColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child:Image(
                    width: 353,
                    height:110,
                    image: AssetImage('images/list.png'),
                    fit:BoxFit.cover
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child:RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenClientPage()));
                },
                color: Colors.transparent,
                elevation: 0,
                  disabledElevation: 0,
                  highlightColor: Colors.transparent,
                  highlightElevation: 0,
                  splashColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child:Image(
                      width: 353,
                      height:110,
                      image: AssetImage('images/openclient.png'),
                      fit:BoxFit.cover
                  ),
                )
              )
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child:RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenOwnerPage()));
                },
                color: Colors.transparent,
                elevation: 0,
                  disabledElevation: 0,
                  highlightColor: Colors.transparent,
                  highlightElevation: 0,
                  splashColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                    child:Image(
                      width: 353,
                      height:110,
                      image: AssetImage('images/openowner.png'),
                      fit:BoxFit.cover
                    ),
                )
              )
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child:RaisedButton(
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedPage()));
                },
                color: Colors.transparent,
                elevation: 0,
                  disabledElevation: 0,
                  highlightColor: Colors.transparent,
                  highlightElevation: 0,
                  splashColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child:Image(
                    width: 353,
                    height:110,
                    image: AssetImage('images/traded.png'),
                    fit:BoxFit.cover
                  ),
                )
              )
          ),
    ]));
  }

  _item(var image,String date,String content,String tip){
    return Stack(
      children: <Widget>[
        Container(
            height: 100,
            width: 335,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Container(
              height: 80,
              width: 335,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child:Container(
                  padding: EdgeInsets.only(left: 100),
                  child:Column(
                    children: <Widget>[
                      Container(
                        width: 220,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          date,
                          style:TextStyle(
                            fontSize: 12,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            height: 2,
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          content,
                          style:TextStyle(
                              fontSize: 14,
                              color: Color(0xFFF67419),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              height: 1.5
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          tip,
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF67419),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      )
                    ],
                  )
              ),
            )
        ),
        Positioned(
          top: 12,
          left: -2,
          child: Image(
              image:AssetImage(image)
          ),
        ),
      ],
    );
  }
}
