import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../pages/qlist/broker/img_view_page.dart';

class QListCheckItem extends StatefulWidget {
  final String name;
  final String number;
  final String time;
  final int star;
  final double percent;
  final String remark;
  final String address;
  final String currentAddress;
  int pageIndex;
  int tabIndex;
  final callBack;
  final String imgs;
  QListCheckItem({Key? key,required this.imgs,required this.name,required this.number,required this.time,required this.star,required this.percent,required this.remark,required this.address,required this.currentAddress,required this.tabIndex,required this.pageIndex,this.callBack}):super(key:key);
  @override
  _QListCheckItemState createState() => _QListCheckItemState();
}

class _QListCheckItemState extends State<QListCheckItem> with SingleTickerProviderStateMixin{
  bool _extend = false;
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;
  int page = 0;
  late List _images;

  @override
  void initState() {
    super.initState();

    if(widget.imgs!=""){
      for(String imgUrl in widget.imgs.split('|')){
        if(imgUrl!=""){
          _images.add(imgUrl);
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
        width: 340,
        margin: EdgeInsets.only(top: animation.value),
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
                                color: widget.percent!=100.0?const Color(0xFF333333)
                                    :const Color(0xFF6E85D3),
                                size: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: widget.percent!=100.0?const Color(0xFF333333)
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
                                  color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
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
                                  color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
                              ),
                              textAlign: TextAlign.right,
                            )
                        ),
                        Container(
                            margin:const EdgeInsets.only(top:10),
                            width: 40,
                            child: Text(
                              widget.percent==100.0?"已完成" :"未完成",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
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
    )
        :
    Container(
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
                              color: widget.percent!=100.0?const Color(0xFF333333)
                                  :const Color(0xFF6E85D3),
                              size: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.percent!=100.0?const Color(0xFF333333)
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
                                color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
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
                                color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
                            ),
                            textAlign: TextAlign.right,
                          )
                      ),
                      Container(
                          margin:const EdgeInsets.only(top:10),
                          width: 40,
                          child: Text(
                            widget.percent==100.0?"已完成" :"未完成",
                            style: TextStyle(
                                fontSize: 12,
                                color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
                            ),
                            textAlign: TextAlign.right,
                          )
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          if(_images.isNotEmpty ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ImgViewPage(
                              imglist:_images,
                              canDel: false,
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
                              child: _images.isEmpty ? const Image(image: AssetImage('images/camera.png')) :
                              Image(image: NetworkImage(_images[0]),fit: BoxFit.fill,)

                          ),
                        ),
                      ),
                      // 中间图片
                      GestureDetector(
                        onTap: (){
                          if(_images.length >= 2 ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ImgViewPage(
                              imglist:_images,
                              canDel: false,
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
                              child: _images.length >= 2 ?
                              Image(image: NetworkImage(_images[1]),fit: BoxFit.fill,)
                                  :
                              const Image(image: AssetImage('images/camera.png'))


                          ),
                        ),
                      ),
                      // 右边图片或图片集合
                      GestureDetector(
                        onTap: (){
                          if(_images.length >= 3 ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ImgViewPage(
                              imglist:_images,
                              canDel: false,
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
                            child: _images.isEmpty ?
                            const Image(image: AssetImage('images/camera.png'),)
                                : _images.length == 1 ?
                            const Image(image: AssetImage('images/camera.png'),)
                                :_images.length == 2 ?
                            const Image(image: AssetImage('images/camera.png'),)
                                :_images.length==3?
                            Image(image: NetworkImage(_images[2]),fit: BoxFit.fill,)
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
    );
  }
}

