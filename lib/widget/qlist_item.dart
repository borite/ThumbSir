import 'package:ThumbSir/pages/broker/qlist/qlist_upload_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class QListItem extends StatefulWidget {
  final String name;
  final String number;
  final String time;
  final int star;
  final double percent;
  int pageIndex;
  int tabIndex;
  final callBack;
  QListItem({Key key,this.name,this.number,this.time,this.star,this.percent,this.tabIndex,this.pageIndex,this.callBack}):super(key:key);
  @override
  _QListItemState createState() => _QListItemState();
}

class _QListItemState extends State<QListItem> with SingleTickerProviderStateMixin{
  bool _extend = false;
  int _starIndex = 1;
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;
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

    print("tab");
    print(this.widget.tabIndex);
    print("page");
    print(this.widget.pageIndex);

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
        print(_extend);
      },
      child: Container(
        margin: EdgeInsets.only(top: animation.value),
        child: Stack(
          children: <Widget>[
            Container(
              width: 340,
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
                        )
                        ],
                        color: Colors.white
                    ),
                    child: Column(
                      children: <Widget>[
                        // 项目和数量
                        this.widget.percent == 100 ?
                        Container(
                          width: 270,
                          padding: EdgeInsets.only(top: 12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '恭喜你!完成 ' + this.widget.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF24CC8E),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4, top: 3),
                                child: Text(
                                  this.widget.number,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF24CC8E),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                            :
                        Container(
                          width: 270,
                          padding: EdgeInsets.only(top: 12),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/time.png'),),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  this.widget.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF0E7AE6),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4, top: 3),
                                child: Text(
                                  this.widget.number,
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
                        // 时间
                        Container(
                          width: 270,
                          padding: EdgeInsets.only(top: 5, bottom: 8),
                          child: Text(
                            '时间 ' + this.widget.time,
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
                          width: 270,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: 20,
                                  height: 16,
                                  padding: EdgeInsets.only(right: 3),
                                  child: _starIndex == 0 ?
                                  Image(image: AssetImage('images/star1_e.png'),
                                    fit: BoxFit.fill,) :
                                  Image(image: AssetImage('images/star1_big.png'),
                                    fit: BoxFit.fill,)
                              ),
                              Container(
                                  width: 20,
                                  height: 16,
                                  padding: EdgeInsets.only(right: 3),
                                  child: _starIndex == 2 ?
                                  Image(image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 3 ?
                                  Image(image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 4 ?
                                  Image(image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 5 ?
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
                                  child: _starIndex == 3 ?
                                  Image(image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 4 ?
                                  Image(image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 5 ?
                                  Image(image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      :
                                  Image(image: AssetImage('images/star3_e.png'),
                                    fit: BoxFit.fill,)
                              ),
                              Container(
                                  width: 20,
                                  height: 16,
                                  padding: EdgeInsets.only(right: 3),
                                  child: _starIndex == 4 ?
                                  Image(image: AssetImage('images/star4_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 5 ?
                                  Image(image: AssetImage('images/star4_big.png'),
                                    fit: BoxFit.fill,)
                                      :
                                  Image(image: AssetImage('images/star4_e.png'),
                                    fit: BoxFit.fill,)
                              ),
                              Container(
                                  width: 20,
                                  height: 16,
                                  padding: EdgeInsets.only(right: 3),
                                  child: _starIndex == 5 ?
                                  Image(image: AssetImage('images/star5_big.png'),
                                    fit: BoxFit.fill,)
                                      :
                                  Image(image: AssetImage('images/star5_e.png'),
                                    fit: BoxFit.fill,)
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
            this.widget.percent == 100 ?
            Positioned(
              left: 260,
              top: 14,
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
                  )
                  ],
                ),
                child: Image(image: AssetImage('images/finish.png')),
              ),
            )
                :
            Positioned(
              left: 260,
              top: 14,
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
                  )
                  ],
                ),
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      startAngle: 280,
                      angleRange: 360,
                      customWidths: CustomSliderWidths(progressBarWidth: 7),
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
                            fontSize: 14,
                            color: Color(0xFF2692FD),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          )
                      )
                  ),
                  min: 0,
                  max: 100,
                  initialValue: this.widget.percent,
                ),
              ),
            )
          ],
        ),
      ),
    )
        :
    Stack(
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
                          this.widget.percent == 100 ?
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _extend = false;
                                  });
                                },
                                child: Text(
                                  "恭喜你!完成 " + this.widget.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF24CC8E),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4, top: 3),
                                child: Text(
                                  this.widget.number,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF24CC8E),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          )
                              :
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _extend = false;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Image(
                                    image: AssetImage('images/time.png'),),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 4, top: 3),
                                  child: Text(
                                    this.widget.number,
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
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => QListUploadPage()));
                            },
                            child: Container(
                              width: 24,
                              child: Image(
                                  image: AssetImage('images/upload.png')),
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
                          Padding(
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
                                  child: _starIndex == 0 ?
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
                                  child: _starIndex == 2 ?
                                  Image(
                                    image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 3 ?
                                  Image(
                                    image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 4 ?
                                  Image(
                                    image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 5 ?
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
                                  child: _starIndex == 3 ?
                                  Image(
                                    image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 4 ?
                                  Image(
                                    image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 5 ?
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
                                  child: _starIndex == 4 ?
                                  Image(
                                    image: AssetImage('images/star4_big.png'),
                                    fit: BoxFit.fill,)
                                      : _starIndex == 5 ?
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
                                  child: _starIndex == 5 ?
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
                            Padding(
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
                              this.widget.time,
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
                        child:
                        Padding(
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
                        child:
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                          child: Text(
                            '共带看3套房，客户对第二套比较满意,共带看3套房，客户对第二套比较满意,共带看3套房，客户对第二套比较满意',
                            style: TextStyle(
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
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          // 每一条定位
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image(image: AssetImage(
                                      'images/site_small.png'),),
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
                                  child: Image(image: AssetImage(
                                      'images/site_small.png'),),
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
                                  child: Image(image: AssetImage(
                                      'images/site_small.png'),),
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
                        width: 335,
                        child:
                        Padding(
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
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
        this.widget.percent == 100 ?
        Positioned(
          top: 70,
          left: 112,
          child: Container(
            width: 110,
            height: 110,
            child: Image(image: AssetImage("images/finish_big.png"),),
          ),
        )
            : Positioned(
          top: 60,
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
              initialValue: this.widget.percent,
            ),
          ),
        )
      ],
    );
  }
}
