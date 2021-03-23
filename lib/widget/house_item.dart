import 'package:ThumbSir/pages/broker/qlist/img_view_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_upload_page.dart';
import 'package:ThumbSir/pages/house/house_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HouseItem extends StatefulWidget {
  @override
  _HouseItemState createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> with SingleTickerProviderStateMixin{
  bool _extend = false;
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;
  List _images=[];
  int page = 0;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync:this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 500,end:25).animate(
        CurvedAnimation(parent: controller,curve: Curves.easeInOut)
            ..addListener(() {
              setState(() {
                animationValue = animation.value;
              });
            })
            ..addStatusListener((AnimationStatus state) {
              setState(() {
                animationStatus = state;
              });
            })
    );
    controller.forward();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseDetailPage()));
      },
      child: Container(
        width: 335,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: animation.value),
        child: Container(
          width: 335,
          // height: 104,
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
          child: Row(
            children: [
              Container(
                width: 80,
                height: 60,
                margin: EdgeInsets.only(left: 10,right: 10),
                color: Colors.amberAccent,
                child: Image(image: AssetImage('images/time.png'),),
              ),

              Column(
                children: <Widget>[
                  // 小区名，报盘时间
                  Container(
                    width: 220,
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              child: Text(
                                '长河湾小区',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF0E7AE6),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.only(left: 4),
                              child: Image(image: AssetImage('images/urgent1.png'),),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4, top: 3),
                          child: Text(
                            '报盘3天',
                            style: TextStyle(
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
                  // 基本信息
                  Container(
                    width: 220,
                    padding: EdgeInsets.only(top: 5, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2-1-1-1',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '88.85平',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '高/6',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '南.北',
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
                  // 房源特色
                  Container(
                    width: 220,
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5,bottom: 5),
                          padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                          color: Color(0xFF93C0FB),
                          child: Text(
                            "满五唯一",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5,bottom: 5),
                          padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                          color: Color(0xFF93C0FB),
                          child: Text(
                            "近地铁",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5,bottom: 5),
                          padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                          color: Color(0xFF93C0FB),
                          child: Text(
                            "随时看房",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5,bottom: 5),
                          padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                          color: Color(0xFF93C0FB),
                          child: Text(
                            "学区房",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 总价、单价
                  Container(
                    width: 220,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              child: Text(
                                '650万',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFF24848),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4, top: 3),
                          child: Text(
                            '73157元/平',
                            style: TextStyle(
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
                ],
              ),
            ],
          )

        ),
      ),
    );
  }
}

