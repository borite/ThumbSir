import 'package:ThumbSir/pages/broker/qlist/img_view_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_upload_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TradedItem extends StatefulWidget {
  final String name;
  final int star;
  final String gender;
  final int age;
  final String phone;
  final birthday;

  TradedItem({Key key,
    this.name,this.star,this.gender,this.age,this.phone,this.birthday
  }):super(key:key);
  @override
  _TradedItemState createState() => _TradedItemState();
}

class _TradedItemState extends State<TradedItem> with SingleTickerProviderStateMixin{
  bool _extend = false;
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;


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
    return _extend == false ?
    GestureDetector(
      onTap: () {
        setState(() {
          _extend = true;
        });
      },
      child: Container(
        width: 335,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: animation.value),
        child: Stack(
          children: <Widget>[
            Container(
              width: 335,
              decoration: BoxDecoration(
                  color: Colors.transparent
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 335,
                    height: 104,
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
                        // 姓名和年龄
                        Container(
                          width: 300,
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                this.widget.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF333333),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 3),
                                child: Text(
                                  widget.age.toString()+'岁',
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
                        // 重要度星星
                        Container(
                          width: 300,
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "星级：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                  width: 20,
                                  height: 16,
                                  padding: EdgeInsets.only(right: 3),
                                  child: widget.star == 0 ?
                                  Image(image: AssetImage('images/star1_e.png'),
                                    fit: BoxFit.fill,) :
                                  Image(image: AssetImage('images/star1_big.png'),
                                    fit: BoxFit.fill,)
                              ),
                              Container(
                                  width: 20,
                                  height: 16,
                                  padding: EdgeInsets.only(right: 3),
                                  child: widget.star == 2 ?
                                  Image(image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : widget.star == 3 ?
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
                                  child: widget.star == 3 ?
                                  Image(image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      :
                                  Image(image: AssetImage('images/star3_e.png'),
                                    fit: BoxFit.fill,)
                              ),
                            ],
                          ),
                        ),
                        // 生日和电话
                        Container(
                          width: 300,
                          padding: EdgeInsets.only(top: 7, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                                decoration: BoxDecoration(
                                  color:Color(0xFF5580EB),
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Text(
                                  '15023452345',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                                decoration: BoxDecoration(
                                  color:Color(0xFF5580EB),
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Text(
                                  '1993-07-29',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.only(right: 7,top: 1),
//                transform: Matrix4.rotationZ(1/8),
                decoration: BoxDecoration(
                  color: widget.gender== "男"?Color(0xFFFF9600):Color(0xFFF24848),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12))
                ),
                child: Text(
                  widget.gender== "男"?"♂":"♀",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 45.3,
                height: 45.3,
                transform: Matrix4.rotationZ(1/1.3),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    )
        :
    Container(
      width: 335,
      alignment: Alignment.center,
      child: Stack(
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
                                setState(() {
                                  _extend = false;
                                });
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
                                    this.widget.name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF0E7AE6),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4, top: 3),
                                    child: Text(
                                      "1",
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
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                width: 24,
                                child: Image(
                                    image: AssetImage('images/editor.png')),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 完成度
                      Container(
                        padding: EdgeInsets.only(top: 80, left: 20),
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
                        width: 335,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 45),
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
                            Row(
                              children: <Widget>[
                                Container(
                                    width: 20,
                                    height: 16,
                                    padding: EdgeInsets.only(right: 3),
                                    child: widget.star == 0 ?
                                    Image(
                                      image: AssetImage('images/star1_e.png'),
                                      fit: BoxFit.fill,) :
                                    Image(
                                      image: AssetImage('images/star1_big.png'),
                                      fit: BoxFit.fill,)
                                ),
                                Container(
                                    width: 20,
                                    height: 16,
                                    padding: EdgeInsets.only(right: 3),
                                    child: widget.star == 2 ?
                                    Image(
                                      image: AssetImage('images/star2_big.png'),
                                      fit: BoxFit.fill,)
                                        : widget.star == 3 ?
                                    Image(
                                      image: AssetImage('images/star2_big.png'),
                                      fit: BoxFit.fill,)
                                        : widget.star == 4 ?
                                    Image(
                                      image: AssetImage('images/star2_big.png'),
                                      fit: BoxFit.fill,)
                                        : widget.star == 5 ?
                                    Image(
                                      image: AssetImage('images/star2_big.png'),
                                      fit: BoxFit.fill,)
                                        :
                                    Image(
                                      image: AssetImage('images/star2_e.png'),
                                      fit: BoxFit.fill,)
                                ),
                                Container(
                                    width: 20,
                                    height: 16,
                                    padding: EdgeInsets.only(right: 3),
                                    child: widget.star == 3 ?
                                    Image(
                                      image: AssetImage('images/star3_big.png'),
                                      fit: BoxFit.fill,)
                                        : widget.star == 4 ?
                                    Image(
                                      image: AssetImage('images/star3_big.png'),
                                      fit: BoxFit.fill,)
                                        : widget.star == 5 ?
                                    Image(
                                      image: AssetImage('images/star3_big.png'),
                                      fit: BoxFit.fill,)
                                        :
                                    Image(
                                      image: AssetImage('images/star3_e.png'),
                                      fit: BoxFit.fill,)
                                ),
                                Container(
                                    width: 20,
                                    height: 16,
                                    padding: EdgeInsets.only(right: 3),
                                    child: widget.star == 4 ?
                                    Image(
                                      image: AssetImage('images/star4_big.png'),
                                      fit: BoxFit.fill,)
                                        : widget.star == 5 ?
                                    Image(
                                      image: AssetImage('images/star4_big.png'),
                                      fit: BoxFit.fill,)
                                        :
                                    Image(
                                      image: AssetImage('images/star4_e.png'),
                                      fit: BoxFit.fill,)
                                ),
                                Container(
                                    width: 20,
                                    height: 16,
                                    padding: EdgeInsets.only(right: 3),
                                    child: widget.star == 5 ?
                                    Image(
                                      image: AssetImage('images/star5_big.png'),
                                      fit: BoxFit.fill,)
                                        :
                                    Image(
                                      image: AssetImage('images/star5_e.png'),
                                      fit: BoxFit.fill,)
                                ),
                              ],
                            ),
                            Container(
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                      // 时间
                      Container(
                          width: 335,
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 83),
                                child: Text(
                                  '时间',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Text(
                                this.widget.birthday,
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
                          width: 335,
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              '任务描述',
                              style: TextStyle(
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
                        width: 335,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 10),
                        child: Container(
                          child: Text(
                            "miaoshu",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),

                      ),
                      // 定位
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            // 每一条定位
                            Container(
                                width: 335,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text(
                                    '计划地点',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
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
                                        "dizhi",
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
                            ),
                            Container(
                                width: 335,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text(
                                    '上传凭证地点',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
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
                                        "dizhi",
//                                  widget.currentAddress,
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
                            ),
                          ],
                        ),
                      ),
                      // 图片上传
                      Container(
                          width: 335,
                          child:
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, top: 10, bottom: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '图片上传',
                                  style: TextStyle(
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
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // 左边上传按钮
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 25,bottom: 5),
                                      child: Image(image: AssetImage('images/camera.png'),),
                                    ),
                                    Text('拍照上传',style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                            // 中间图片
                            GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                ),
                              ),
                            ),
                            // 右边图片或图片集合
                            GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 收起按钮
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _extend = false;
                          });
                        },
                        child: Container(
                          width: 33,
                          padding: EdgeInsets.only(bottom: 20),
                          child: Image(
                            image: AssetImage('images/upbtn.png'),
                            fit: BoxFit.fill,
                          ),
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
            top: 70,
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
                      progressBarColors: [
                        Color(0xFF0E7AE6),
                        Color(0xFF2692FD),
                        Color(0xFF93C0FB)
                      ],
                      trackColor: Color(0x20CCCCCC),
                      dotColor: Colors.transparent,
                    ),
                    infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF2692FD),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        )
                    )
                ),
                min: 0,
                max: 100,
                initialValue: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

