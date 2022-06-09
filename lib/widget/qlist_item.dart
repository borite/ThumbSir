import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../pages/qlist/broker/img_view_page.dart';
import '../pages/qlist/broker/qlist_change_page.dart';

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
  final userID;
  final userLevel;
  final endTime;
  final int planCount;
  final int date;
  final String imgs;
  final int pageIndex;
  final int tabIndex;
  final callBack;
  const QListItem({Key? key,
    required this.imgs,this.userID,this.userLevel,
    required this.name,required this.number,required this.time,required this.star,required this.defaultId,
    required this.planCount,required this.date,
    required this.percent,required this.remark,required this.address,required this.currentAddress,
    required this.taskId,required this.unit,
    this.startTime,this.endTime, required this.tabIndex,required this.pageIndex,this.callBack
  }) : super(key: key);
  @override
  _QListItemState createState() => _QListItemState();
}

class _QListItemState extends State<QListItem> with SingleTickerProviderStateMixin{
  bool _extend = false;
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;
  final dynamic _images=[];
  int page = 0;

  DateTime now = DateTime.now();
  // var todayTime;


  @override
  void initState() {
    super.initState();

    if(widget.imgs!=""){
      for(String imgUrl in widget.imgs.split('|')){
         if(imgUrl!=""){
           setState(() {
             _images.add(imgUrl);
           });
         }
      }
    }

    controller = AnimationController(vsync:this,duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 500,end:15).animate(
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
        child: Container(
          width: 340,
          decoration: const BoxDecoration(
              color: Colors.transparent
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 335,
                height: 104,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(
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
                        width: 300,
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_alarms,
                                  color: now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFF333333)
                                      :const Color(0xFF6E85D3),
                                  size: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    widget.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFF333333)
                                          :const Color(0xFF6E85D3),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10, top: 3),
                                  child: Text(
                                    widget.number,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10, top: 7),
                                  child: Text(
                                    widget.star.toString(),
                                    style: TextStyle(
                                        color: widget.star==1||widget.star==2?const Color(0xFF4ED491)
                                            :widget.star==3||widget.star==4?const Color(0xFFF9C626)
                                            :const Color(0xFFD44E4E),
                                        fontSize: 12
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: widget.star==1||widget.star==2?const Color(0xFF4ED491)
                                      :widget.star==3||widget.star==4?const Color(0xFFF9C626)
                                      :const Color(0xFFD44E4E),
                                  size: 24,
                                ),
                              ],
                            )

                          ],
                        )

                    ),
                    // 时间
                    Container(
                      width: 300,
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        '时间: ' + widget.time,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 完成度
                    SizedBox(
                      width: 300,
                      child: Row(
                        children: <Widget>[
                          // Container(
                          //   width: 182,
                          //   height: 14,
                          //   margin: EdgeInsets.only(top: 10),
                          //   decoration: BoxDecoration(
                          //     gradient: LinearGradient(
                          //         begin: Alignment.topLeft,
                          //         end:Alignment.bottomRight,
                          //         colors: [Color(0xFF6E85D3),Color(0xFF4ED491)]
                          //     ),
                          //     borderRadius: BorderRadius.circular(7),
                          //   ),
                          // ),
                          Container(
                            padding:const EdgeInsets.only(top: 10),
                            width: 182,
                            child: StepProgressIndicator(
                              totalSteps: 100,
                              currentStep: widget.percent==0.0?0:widget.percent==100.0?100:widget.percent.toInt(),
                              size: 14,
                              padding: 0,
                              selectedColor: const Color(0xFF4ED491),
                              unselectedColor: const Color(0xFF6E85D3),
                              roundedEdges: const Radius.circular(7),
                              selectedGradientColor: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF6E85D3),Color(0xFF4ED491)],
                              ),
                              unselectedGradientColor: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0x80CCCCCC),Color(0x30CCCCCC),Color(0x10CCCCCC)],
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 60,
                              child: Text(
                                // "88.8",
                                widget.percent==0.0?"0":widget.percent==100.0?"100":widget.percent.toString(),
                                style: TextStyle(
                                    fontSize: 24,
                                    color: widget.percent==100.0?const Color(0xFF4ED491)
                                        :now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFFD44E4E)
                                        :now.isAfter(widget.startTime)&&now.isBefore(widget.endTime)&&widget.percent!=100.0?const Color(0xFF6E85D3)
                                        :const Color(0xFF666666)
                                ),
                                textAlign: TextAlign.right,
                              )
                          ),
                          Container(
                              margin:const EdgeInsets.only(top:10,right: 6),
                              child: Text(
                                "%",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: widget.percent==100.0?const Color(0xFF4ED491)
                                        :now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFFD44E4E)
                                        :now.isAfter(widget.startTime)&&now.isBefore(widget.endTime)&&widget.percent!=100.0?const Color(0xFF6E85D3)
                                        :const Color(0xFF666666)
                                ),
                                textAlign: TextAlign.right,
                              )
                          ),
                          Container(
                              margin:const EdgeInsets.only(top:10),
                              width: 40,
                              child: Text(
                                widget.percent==100.0?"已完成"
                                    :now.isAfter(widget.endTime)&&widget.percent!=100.0? "未完成"
                                    :now.isBefore(widget.startTime)&&widget.percent!=100.0? "未开始"
                                    :"进行中",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: widget.percent==100.0?const Color(0xFF4ED491)
                                        :now.isAfter(widget.startTime)&&now.isBefore(widget.endTime)&&widget.percent!=100.0?const Color(0xFF6E85D3)
                                        :now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFFD44E4E)
                                        :const Color(0xFF666666)
                                ),
                                textAlign: TextAlign.right,
                              )
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
      ),
    )
        :
    Container(
      width: 335,
      alignment: Alignment.center,
      child: Container(
        width: 340,
        margin: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
            color: Colors.transparent
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 335,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(
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
                    width: 300,
                    padding: const EdgeInsets.only(top: 12),
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
                              Icon(
                                Icons.access_alarms,
                                color: now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFF333333)
                                    :const Color(0xFF6E85D3),
                                size: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFF333333)
                                        :const Color(0xFF6E85D3),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10, top: 3),
                                child: Text(
                                  widget.number,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF999999),
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
                            // DateTime now = DateTime.now();
                            // 如果是今日且任务时间结束，不可修改（这个要求取消了2021-01-13）
                            //  var aa = now.difference(widget.endTime);
                            //  print(aa);
                            //  print(aa.inHours);
                            //  if(aa.inSeconds>0){
                            //    print("已经过期了");
                            //    _onEditorAlert(context);
                            //  }else{
                            //    print("可以修改");
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
                          },
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF666666),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 时间
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '时间: ' + widget.time,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // 完成度
                  SizedBox(
                    width: 300,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding:const EdgeInsets.only(top: 10),
                          width: 182,
                          child: StepProgressIndicator(
                            totalSteps: 100,
                            currentStep: widget.percent==0.0?0:widget.percent==100.0?100:widget.percent.toInt(),
                            size: 14,
                            padding: 0,
                            selectedColor: const Color(0xFF4ED491),
                            unselectedColor: const Color(0xFF6E85D3),
                            roundedEdges: const Radius.circular(7),
                            selectedGradientColor: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF6E85D3),Color(0xFF4ED491)],
                            ),
                            unselectedGradientColor: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0x80CCCCCC),Color(0x30CCCCCC),Color(0x10CCCCCC)],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 60,
                            child: Text(
                              //"88.8",
                              widget.percent==0.0?"0":widget.percent==100.0?"100":widget.percent.toString(),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: widget.percent==100.0?const Color(0xFF4ED491)
                                      :now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFFD44E4E)
                                      :now.isAfter(widget.startTime)&&now.isBefore(widget.endTime)&&widget.percent!=100.0?const Color(0xFF6E85D3)
                                      :const Color(0xFF666666)
                              ),
                              textAlign: TextAlign.right,
                            )
                        ),
                        Container(
                            margin:const EdgeInsets.only(top:10,right: 6),
                            child: Text(
                              "%",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: widget.percent==100.0?const Color(0xFF4ED491)
                                      :now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFFD44E4E)
                                      :now.isAfter(widget.startTime)&&now.isBefore(widget.endTime)&&widget.percent!=100.0?const Color(0xFF6E85D3)
                                      :const Color(0xFF666666)
                              ),
                              textAlign: TextAlign.right,
                            )
                        ),
                        Container(
                            margin:const EdgeInsets.only(top:10),
                            width: 40,
                            child: Text(
                              widget.percent==100.0?"已完成"
                                  :now.isAfter(widget.endTime)&&widget.percent!=100.0? "未完成"
                                  :now.isBefore(widget.startTime)&&widget.percent!=100.0? "未开始"
                                  :"进行中",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: widget.percent==100.0?const Color(0xFF4ED491)
                                      :now.isAfter(widget.startTime)&&now.isBefore(widget.endTime)&&widget.percent!=100.0?const Color(0xFF6E85D3)
                                      :now.isAfter(widget.endTime)&&widget.percent!=100.0?const Color(0xFFD44E4E)
                                      :const Color(0xFF666666)
                              ),
                              textAlign: TextAlign.right,
                            )
                        ),
                      ],
                    ),
                  ),
                  // 重要度星星
                  Container(
                    width: 335,
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 20,
                            height: 16,
                            padding: const EdgeInsets.only(right: 3),
                            child: widget.star == 0 ?
                            const Image(
                              image: AssetImage('images/star1_e.png'),
                              fit: BoxFit.fill,) :
                            const Image(
                              image: AssetImage('images/star1_big.png'),
                              fit: BoxFit.fill,)
                        ),
                        Container(
                            width: 20,
                            height: 16,
                            padding: const EdgeInsets.only(right: 3),
                            child: widget.star == 2 ?
                            const Image(
                              image: AssetImage('images/star2_big.png'),
                              fit: BoxFit.fill,)
                                : widget.star == 3 ?
                            const Image(
                              image: AssetImage('images/star2_big.png'),
                              fit: BoxFit.fill,)
                                : widget.star == 4 ?
                            const Image(
                              image: AssetImage('images/star2_big.png'),
                              fit: BoxFit.fill,)
                                : widget.star == 5 ?
                            const Image(
                              image: AssetImage('images/star2_big.png'),
                              fit: BoxFit.fill,)
                                :
                            const Image(
                              image: AssetImage('images/star2_e.png'),
                              fit: BoxFit.fill,)
                        ),
                        Container(
                            width: 20,
                            height: 16,
                            padding: const EdgeInsets.only(right: 3),
                            child: widget.star == 3 ?
                            const Image(
                              image: AssetImage('images/star3_big.png'),
                              fit: BoxFit.fill,)
                                : widget.star == 4 ?
                            const Image(
                              image: AssetImage('images/star3_big.png'),
                              fit: BoxFit.fill,)
                                : widget.star == 5 ?
                            const Image(
                              image: AssetImage('images/star3_big.png'),
                              fit: BoxFit.fill,)
                                :
                            const Image(
                              image: AssetImage('images/star3_e.png'),
                              fit: BoxFit.fill,)
                        ),
                        Container(
                            width: 20,
                            height: 16,
                            padding: const EdgeInsets.only(right: 3),
                            child: widget.star == 4 ?
                            const Image(
                              image: AssetImage('images/star4_big.png'),
                              fit: BoxFit.fill,)
                                : widget.star == 5 ?
                            const Image(
                              image: AssetImage('images/star4_big.png'),
                              fit: BoxFit.fill,)
                                :
                            const Image(
                              image: AssetImage('images/star4_e.png'),
                              fit: BoxFit.fill,)
                        ),
                        Container(
                            width: 20,
                            height: 16,
                            padding: const EdgeInsets.only(right: 3),
                            child: widget.star == 5 ?
                            const Image(
                              image: AssetImage('images/star5_big.png'),
                              fit: BoxFit.fill,)
                                :
                            const Image(
                              image: AssetImage('images/star5_e.png'),
                              fit: BoxFit.fill,)
                        ),
                      ],
                    ),
                  ),
                  // 任务描述
                  SizedBox(
                      width: 300,
                      child: Row(
                        children: [
                          Container(
                            margin:const EdgeInsets.only(right: 3),
                            child: const Text(
                                '·',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Color(0xFF333333),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                )
                            ),
                          ),
                          const Text(
                            '任务描述',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                  ),
                  // 任务描述详情
                  Container(
                    width: 300,
                    padding: const EdgeInsets.only(left: 14,bottom: 5,right: 14),
                    child: Text(
                      widget.remark,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                  ),
                  // 定位
                  Column(
                    children: <Widget>[
                      // 每一条定位
                      SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Container(
                                margin:const EdgeInsets.only(right: 3),
                                child: const Text(
                                    '·',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    )
                                ),
                              ),
                              const Text(
                                '计划地点',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF333333),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(left: 14,bottom: 5,right: 14),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(right: 2),
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFF6E85D3),
                                size: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.address,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6E85D3),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Container(
                                margin:const EdgeInsets.only(right: 3),
                                child: const Text(
                                    '·',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    )
                                ),
                              ),
                              const Text(
                                '上传凭证地点',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF333333),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(left: 14,bottom: 5,right: 14),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(right: 2),
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFF6E85D3),
                                size: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.currentAddress,
//                                  widget.currentAddress,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6E85D3),
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
                  // 图片上传
                  SizedBox(
                      width: 300,
                      child: Row(
                        children: [
                          Container(
                            margin:const EdgeInsets.only(right: 3),
                            child: const Text(
                                '·',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Color(0xFF333333),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                )
                            ),
                          ),
                          const Text(
                            '上传图片',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                  ),
                  // 图片
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // 左边上传按钮
                        GestureDetector(
                          onTap: () {
                            DateTime now = DateTime.now();
                            // 今日且任务时间已经开始且没过1小时，可以上传
                            // 改为任务时间已经开始且今日23:59:59前可以上传，2021-01-13
                            // var aa= now.difference(widget.endTime);
                            // if(aa.inHours<1 && now.isAfter(widget.startTime)){
                            if(now.isAfter(widget.startTime)){
                              if (kDebugMode) {
                                print("跳转到上传页");
                              }
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => QListUploadPage(
                              //     name : widget.name,
                              //     star : widget.star,
                              //     percent : widget.percent,
                              //     currentAddress : widget.currentAddress,
                              //     taskId : widget.taskId,
                              //     unit : widget.unit,
                              //     defaultId : widget.defaultId,
                              //     startTime : widget.startTime,
                              //     endTime : widget.endTime,
                              //     planCount : widget.planCount,
                              //     uploadImgs:widget.imgs
                              // ))).then((x) => setState((){
                              //   _extend=true;
                              // }));
                            }else{
                              // 不可上传
                              _onUploadAlert(context);
                            }
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage('images/imgbg.png'))
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 25,bottom: 5),
                                  child: const Image(image: AssetImage('images/camera.png'),),
                                ),
                                const Text('点击上传',style: TextStyle(
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
                            if(_images.length != 0 ){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ImgViewPage(
                                imglist:_images,
                                userid:widget.userID,
                                userlevel:widget.userLevel,
                                taskid:widget.taskId,
                                canDel: true,
                              )));
                            }
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage('images/imgbg.png'))
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: _images.length == 0 ? const Image(image: AssetImage('images/camera.png')) :
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
                                userid:widget.userID,
                                userlevel:widget.userLevel,
                                taskid:widget.taskId,
                              )));
                            }
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage('images/imgbg.png'))
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: _images.length == 0 ?
                              const Image(image: AssetImage('images/camera.png'),)
                                  : _images.length == 1 ?
                              const Image(image: AssetImage('images/camera.png'),)
                                  :_images.length == 2 ?
                              Image(image: NetworkImage(_images[1]),fit: BoxFit.fill,)
                                  :
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Image(image: NetworkImage(_images[1]),fit: BoxFit.fill,),
                                    Container(width: 90,height: 90,color: Colors.black45,),
                                    Text("+"+(_images.length-1).toString(),
                                      style: const TextStyle(
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
                  IconButton(
                    icon:const Icon(Icons.keyboard_arrow_up,
                        color: Color(0xFFCCCCCC),
                        size:30
                    ), onPressed: () {
                    setState(() {
                      _extend = false;
                    });
                  },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _onUploadAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "当前任务还不可上传凭证",
      // desc: "任务开始后至任务结束一小时前可以上传图片凭证，其余时间不可上传",
      desc: "任务开始后至任务当天23:59:59前可以上传图片凭证，其余时间不可上传",
      buttons: [
        DialogButton(
          child: const Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}

