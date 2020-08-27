import 'package:ThumbSir/pages/broker/qlist/img_view_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_upload_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QListItem extends StatefulWidget {
  final String name;
  final String number;
  final String time;
  final int star;
  final double percent;
  final String remark;
  final String address;
  final String currentAddress;
  final String taskId;
  final String unit;
  final String defaultId;
  final startTime;
  final userID,userLevel;
  final endTime;
  final int planCount;
  final int date;
  final String imgs;
  int pageIndex;
  int tabIndex;
  final callBack;
  QListItem({Key key,
    this.imgs,this.userID,this.userLevel,
    this.name,this.number,this.time,this.star,this.defaultId,this.planCount,this.date,
    this.percent,this.remark,this.address,this.currentAddress,this.taskId,this.unit,
    this.startTime,this.endTime,
    this.tabIndex,this.pageIndex,this.callBack
  }):super(key:key);
  @override
  _QListItemState createState() => _QListItemState();
}

class _QListItemState extends State<QListItem> with SingleTickerProviderStateMixin{
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
    print(widget.userLevel);
//    setState(() {
//      if(widget.imgs!=""){
//        print(widget.imgs);
//        //var sss=widget.imgs.split(',');
//        for(String imgUrl in widget.imgs.split(',')){
//          if(imgUrl!=""){
//            _images.add(imgUrl);
//          }
//        }
//        print(_images);
//      }
//    });

    if(widget.imgs!=""){

      print(widget.imgs);
      //var sss=widget.imgs.split(',');
      for(String imgUrl in widget.imgs.split('|')){
         if(imgUrl!=""){
           setState(() {
             _images.add(imgUrl);
           });
         }
      }
      print(_images);
    }

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
                        this.widget.percent == 1 ?
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
                              Container(
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
                              ),
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
                              Container(
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
                              Container(
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
                                      : widget.star == 4 ?
                                  Image(image: AssetImage('images/star2_big.png'),
                                    fit: BoxFit.fill,)
                                      : widget.star == 5 ?
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
                                      : widget.star == 4 ?
                                  Image(image: AssetImage('images/star3_big.png'),
                                    fit: BoxFit.fill,)
                                      : widget.star == 5 ?
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
                                  child: widget.star == 4 ?
                                  Image(image: AssetImage('images/star4_big.png'),
                                    fit: BoxFit.fill,)
                                      : widget.star == 5 ?
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
                                  child: widget.star == 5 ?
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
            this.widget.percent == 1?
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
                  initialValue: this.widget.percent*100,
                ),
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
                            this.widget.percent == 1 ?
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
                                Container(
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
                                  Container(
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
                                  Container(
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
                                DateTime now = new DateTime.now();
                                // 如果是今日且任务时间结束，不可修改
                                 var aa = now.difference(widget.endTime);
                                 print(aa);
                                 print(aa.inHours);
                                 if(aa.inSeconds>0){
                                   print("已经过期了");
                                   _onEditorAlert(context);
                                 }else{
                                   print("可以修改");
                                   Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => QListChangePage(
                                        id: widget.taskId,
                                        taskName: widget.name,
                                        taskUnit: widget.unit,
                                        defaultTaskID: widget.defaultId,
                                        stars: widget.star,
                                        planningCount: widget.planCount,
                                        planningStartTime: widget.startTime,
                                        planningEndTime: widget.endTime,
                                        remark: widget.remark,
                                        address: widget.address,
                                        date: widget.date,
                                      ))
                                   );
                                 }
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
                            widget.remark,
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
                                    padding: EdgeInsets.only(right: 5),
                                    child: Image(image: AssetImage(
                                        'images/site_small.png'),),
                                  ),
                                  Container(
                                    child: Expanded(
                                      child: Text(
                                        widget.address,
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
                                    padding: EdgeInsets.only(right: 5),
                                    child: Image(image: AssetImage(
                                        'images/site_small.png'),),
                                  ),
                                  Container(
                                    child: Expanded(
                                      child: Text(
                                        widget.currentAddress,
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
                                DateTime now = new DateTime.now();
                                // 今日且任务时间已经开始且没过1小时，可以上传
                                var aa= now.difference(widget.endTime);
                                if(aa.inHours<1 && now.isAfter(widget.startTime)){
                                  print("可以修改图片");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => QListUploadPage(
                                      name : widget.name,
                                      star : widget.star,
                                      percent : widget.percent,
                                      currentAddress : widget.currentAddress,
                                      taskId : widget.taskId,
                                      unit : widget.unit,
                                      defaultId : widget.defaultId,
                                      startTime : widget.startTime,
                                      endTime : widget.endTime,
                                      planCount : widget.planCount,
                                      uploadImgs:widget.imgs
                                  ))).then((x) => setState((){
                                    _extend=true;
                                  }));
                                }else{
                                  // 不可上传
                                  print("不可以上传图片");
                                  _onUploadAlert(context);
                                }
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
                                DateTime now = new DateTime.now();
                                // 今日且任务时间已经开始且没过1小时，可以上传
                                var aa= now.difference(widget.endTime);
                                print("图片修改@~");
                                print(aa.inHours);
                                if(_images.length != 0 ){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImgViewPage(
                                    imglist:_images,
                                    userid:widget.userID,
                                    userlevel:widget.userLevel,
                                    taskid:widget.taskId,
                                    canDel: aa.inHours<1 && now.isAfter(widget.startTime)==true?true:false,
                                  )));
                                }
                              },
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: _images.length == 0 ? Image(image: AssetImage('images/camera.png')) :
                                    Image(image: NetworkImage(_images[0]),fit: BoxFit.fill,)

                                ),
                              ),
                            ),
                            // 右边图片或图片集合
                            GestureDetector(
                              onTap: (){
                                if(_images.length >= 2 ){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImgViewPage(
                                    imglist:_images,
                                    canDel: true,
                                  )));
                                }
                              },
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: _images.length == 0 ?
                                  Image(image: AssetImage('images/camera.png'),)
                                      : _images.length == 1 ?
                                  Image(image: AssetImage('images/camera.png'),)
                                      :_images.length == 2 ?
                                  Image(image: NetworkImage(_images[1]),fit: BoxFit.fill,)
                                      :
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Image(image: NetworkImage(_images[1]),fit: BoxFit.fill,),
                                        Container(width: 90,height: 90,color: Colors.black45,),
                                        Text("+"+(_images.length-1).toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                          textAlign: TextAlign.center,)
                                      ],
                                    ),
                                  ),
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
          this.widget.percent == 1 ?
          Positioned(
            top: 80,
            left: 112,
            child: Container(
              width: 110,
              height: 110,
              child: Image(image: AssetImage("images/finish_big.png"),),
            ),
          )
              : Positioned(
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
                initialValue: this.widget.percent*100,
              ),
            ),
          )
        ],
      ),
    );
  }
  _onEditorAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "任务已经结束了，无法修改",
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
  _onUploadAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "当前任务不可上传",
      desc: "任务开始后至任务结束一小时前可以上传图片凭证，其余时间不可上传",
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

