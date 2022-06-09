import 'package:ThumbSir/pages/broker/client/client_detail_page.dart';
import 'package:flutter/material.dart';

class ClientItem extends StatefulWidget {
  final String name;
  final int star;
  final int gender;
  final int age;
  final String phone;
  final birthday;
  final need;
  final action;
  final giftList;
  final item;

  ClientItem({Key? key,
    required this.name,required this.star,required this.gender,required this.age,required this.phone,this.birthday,
    this.need,this.action, this.item,this.giftList,
  }):super(key:key);
  @override
  _ClientItemState createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> with SingleTickerProviderStateMixin{
  bool _extend = false;
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;


  @override
  void initState() {
    print(widget.need);
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
              child: Container(
                width: 335,
                padding: EdgeInsets.only(bottom: 5),
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
                            "重要度：",
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
                    widget.need.length > 0&& widget.need[0]!=[]?
                    // 需求1
                    Container(
                      width: 300,
                      padding: EdgeInsets.only(top: 7, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            child: Text(
                              // "购买住宅:",
                              widget.need[0].mainNeed ?? "暂无需求",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            decoration: BoxDecoration(
                              color:Color(0xFF5580EB),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Text(
                                widget.need[0].coreNeedOne.toString().contains(":")?
                              widget.need[0].coreNeedOne.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                                  :"未填写",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          widget.need[0].coreNeedTwo!=null&&widget.need[0].coreNeedTwo!="暂无第二核心需求"?
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            decoration: BoxDecoration(
                              color:Color(0xFF5580EB),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Text(
                              widget.need[0].coreNeedTwo.toString().contains(":")?
                              widget.need[0].coreNeedTwo.toString().substring(0,widget.need[0].coreNeedTwo.toString().indexOf(':'))
                                  :"-",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ):Container(width: 1,),
                          widget.need[0].coreNeedThree!=null&&widget.need[0].coreNeedThree!="暂无第三核心需求"?
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            decoration: BoxDecoration(
                              color:Color(0xFF5580EB),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Text(
                              widget.need[0].coreNeedThree.toString().contains(":")?
                              widget.need[0].coreNeedThree.toString().substring(0,widget.need[0].coreNeedThree.toString().indexOf(':'))
                                  :"-",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ):Container(width: 1,),
                        ],
                      ),
                    )
                    :
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: Text(
                        "暂无需求",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 需求2
                    widget.need.length>1&& widget.need[1]!=[]?
                    Container(
                      width: 300,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(0,3, 0, 3),
                            child: Text(
                              // "出售住宅:",
                              widget.need[1].mainNeed ?? "暂无第二需求",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            decoration: BoxDecoration(
                              color:Color(0xFF5580EB),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Text(
                              widget.need[1].coreNeedOne.toString().contains(":")?
                              widget.need[1].coreNeedOne.toString().substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                  :"未填写",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          widget.need[1].coreNeedTwo!=null?
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            decoration: BoxDecoration(
                              color:Color(0xFF5580EB),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Text(
                              widget.need[1].coreNeedTwo.toString().contains(":")?
                              widget.need[1].coreNeedTwo.toString().substring(0,widget.need[1].coreNeedTwo.toString().indexOf(':'))
                                  :"-",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ):Container(width: 1,),
                          widget.need[1].coreNeedThree!=null?
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            decoration: BoxDecoration(
                              color:Color(0xFF5580EB),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Text(
                              widget.need[1].coreNeedThree.toString().contains(":")?
                              widget.need[1].coreNeedThree.toString().substring(0,widget.need[1].coreNeedThree.toString().indexOf(':'))
                                  :"-",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ):Container(width: 1,),
                ]
                      ),
                    )
                        :
                    Container(
                      width: 1,
                    ),
                  ],
                ),
              )
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.only(right: 7,top: 2),
//                transform: Matrix4.rotationZ(1/8),
                decoration: BoxDecoration(
                  color: widget.gender== 0?Color(0xFFFF9600):Color(0xFFF24848),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12))
                ),
                child: Text(
                  widget.gender== 0?"♂":"♀",
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
      margin: EdgeInsets.only(top: 25),
      child: Stack(
        children: <Widget>[
          Container(
            width: 335,
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            child: Container(
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
                  // 姓名和年龄
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _extend = false;
                      });
                    },
                    child: Container(
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
                  ),
                  // 重要度星星
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "重要度：",
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
                  // 电话
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "电话：",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.phone,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 生日
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "生日：",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.birthday,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 需求
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '需求：',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF333333),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // 需求详情
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
//                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: <Widget>[
                        widget.need != null && widget.need.length>0 && widget.need[0]!=[]?
                        Container(
                          margin: EdgeInsets.only(bottom: 10,left: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF5580EB),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                            ),
                            child: Text(
                              // "购买住宅",
                              widget.need[0].mainNeed ?? "暂无需求",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                              Container(
                            padding: EdgeInsets.fromLTRB(8, 1, 10, 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF5580EB),
                                )
                            ),
                            child: Text(
                              // "三居室 | 三环内 | 精装修",
                              widget.need[0].coreNeedOne!=null
                                  && widget.need[0].coreNeedOne.toString().contains(":")
                                  && widget.need[0].coreNeedTwo !=null
                                  && widget.need[0].coreNeedTwo.toString().contains(":")
                                  && widget.need[0].coreNeedThree !=null
                                  &&widget.need[0].coreNeedThree.toString().contains(":")?
                              widget.need[0].coreNeedOne.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                                  +" | "+widget.need[0].coreNeedTwo.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                                  +" | "+ widget.need[0].coreNeedThree.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                                  :
                              widget.need[0].coreNeedOne!=null && widget.need[0].coreNeedOne.toString().contains(":")
                                  && widget.need[0].coreNeedTwo == null?
                              widget.need[0].coreNeedOne.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                                  :
                              widget.need[0].coreNeedOne!=null
                                  && widget.need[0].coreNeedOne.toString().contains(":")
                                  && widget.need[0].coreNeedTwo !=null
                                  && widget.need[0].coreNeedTwo.toString().contains(":")
                                  && widget.need[0].coreNeedThree ==null?
                              widget.need[0].coreNeedOne.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                                  +" | "+widget.need[0].coreNeedTwo.toString().substring(0,widget.need[0].coreNeedOne.toString().indexOf(':'))
                              :"未填写",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5580EB),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                            ],
                          )
                        )
                        :
                        Container(
                          child: Text(
                            "暂无需求信息",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        widget.need != null && widget.need.length>1 && widget.need[1]!=[]?
                        Container(
                            margin: EdgeInsets.only(bottom: 10,left: 15),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 2, 10, 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF5580EB),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                  ),
                                  child: Text(
                                    // widget.need,
                                    // "需求1",
                                    widget.need[1].mainNeed ?? "暂无需求",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(8, 1, 10, 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFF5580EB),
                                      )
                                  ),
                                  child: Text(
                                    // "三居室 | 三环内 | 精装修",
                                    widget.need[1].coreNeedOne!=null
                                        && widget.need[1].coreNeedOne.toString().contains(":")
                                        && widget.need[1].coreNeedTwo !=null
                                        && widget.need[1].coreNeedTwo.toString().contains(":")
                                        && widget.need[1].coreNeedThree !=null
                                        &&widget.need[1].coreNeedThree.toString().contains(":")?
                                    widget.need[1].coreNeedOne.toString().substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                        +" | "+widget.need[1].coreNeedTwo.toString().substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                        +" | "+ widget.need[1].coreNeedThree.toString().substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                        :
                                    widget.need[1].coreNeedOne!=null && widget.need[1].coreNeedOne.toString().contains(":")
                                        && widget.need[1].coreNeedTwo == null?
                                    widget.need[1].coreNeedOne.toString().substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                        :
                                    widget.need[1].coreNeedOne!=null
                                        && widget.need[1].coreNeedOne.toString().contains(":")
                                        && widget.need[1].coreNeedTwo !=null
                                        && widget.need[1].coreNeedTwo.toString().contains(":")
                                        && widget.need[1].coreNeedThree ==null?
                                    widget.need[1].coreNeedOne.substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                        +" | "+widget.need[0].coreNeedTwo.substring(0,widget.need[1].coreNeedOne.toString().indexOf(':'))
                                        :"未填写",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5580EB),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            )

                        )
                        :Container(width: 1,),
                      ],
                    )
                  ),

                  // 业务动作
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '业务动作：',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF333333),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // 业务动作详情
                  Container(
                      width: 335,
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
//                    margin: EdgeInsets.only(left: 15),
                      child: Column(
                        children: <Widget>[
                          widget.action != null && widget.action.act!=[]&& widget.action.act.length>0?
                          Container(
                            margin: EdgeInsets.only(bottom: 10,left: 15),
                            child: Row(
                              children: <Widget>[
                                Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF5580EB),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                            ),
                            child: Text(
                              widget.action.act[0].actionName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                                Container(
                            padding: EdgeInsets.fromLTRB(8, 1, 10, 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF5580EB),
                                )
                            ),
                            child: Text(
                              widget.action.act[0].actionTime.toString().substring(0,16),
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5580EB),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                              ],
                            )
                          )
                              :
                          Container(
                            child: Text(
                              "暂无业务动作",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          widget.action != null && widget.action.act!=[]&& widget.action.act.length>1?
                          Container(
                              margin: EdgeInsets.only(bottom: 10,left: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 2, 10, 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5580EB),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                    ),
                                    child: Text(
                                      // widget.need,
                                      widget.action.act[1].actionName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(8, 1, 10, 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF5580EB),
                                        )
                                    ),
                                    child: Text(
                                      widget.action.act[0].actionTime.toString().substring(0,16),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF5580EB),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              )

                          )
                              :Container(width: 1,),
                        ],
                      )
                  ),

                  // 维护动作
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '维护动作：',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF333333),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // 维护动作详情
//                  Container(
//                    width: 335,
//                    padding: EdgeInsets.only(bottom: 10, top: 10),
//                    child: Column(
//                      children: <Widget>[
//                        Container(
//                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
//                          child: Row(
//                            children: <Widget>[
//                              Text(
//                                widget.giftList.length >0 ?
//                                widget.giftList[0].addTime.toString().substring(0,10) + widget.giftList[0].giftReason+"："
//                                :"暂无维护动作",
//                                style: TextStyle(
//                                  fontSize: 14,
//                                  color: Color(0xFF5580EB),
//                                  decoration: TextDecoration.none,
//                                  fontWeight: FontWeight.normal,
//                                ),
//                              ),
//                              Expanded(
//                                child: Text(
//                                  widget.giftList.length >0?
//                                      widget.giftList[0].giftPrice.toString()+"元"+widget.giftList[0].giftName
//                                  :"",
//                                  style: TextStyle(
//                                    fontSize: 14,
//                                    color: Color(0xFF5580EB),
//                                    decoration: TextDecoration.none,
//                                    fontWeight: FontWeight.normal,
//                                  ),
//                                ),
//                              )
//                            ],
//                          )
//                        ),
//                        Container(
//                            margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
//                            child: Row(
//                              children: <Widget>[
//                                Text(
//                                  widget.giftList.length >1 ?
//                                  widget.giftList[1].addTime.toString().substring(0,10) + widget.giftList[1].giftReason+"："
//                                      :"",
//                                  style: TextStyle(
//                                    fontSize: 14,
//                                    color: Color(0xFF5580EB),
//                                    decoration: TextDecoration.none,
//                                    fontWeight: FontWeight.normal,
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Text(
//                                    widget.giftList.length >1?
//                                    widget.giftList[1].giftPrice.toString()+"元"+widget.giftList[1].giftName
//                                        :"",
//                                    style: TextStyle(
//                                      fontSize: 14,
//                                      color: Color(0xFF5580EB),
//                                      decoration: TextDecoration.none,
//                                      fontWeight: FontWeight.normal,
//                                    ),
//                                  ),
//                                )
//                              ],
//                            )
//                        ),
//                      ],
//                    ),
//                  ),
                  widget.giftList.length != 0?
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 100,
                    child: ListView.builder(
                      itemCount: widget.giftList.length,
                      itemBuilder: (BuildContext context,int index){
                        return Column(
                          children: <Widget>[
                            // 家庭成员
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    widget.giftList[index].addTime.toString().substring(0,10) + widget.giftList[index].giftReason+"：",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5580EB),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.giftList[index].giftPrice.toString()+"元"+widget.giftList[index].giftName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF5580EB),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                      :
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    child: Text(
                      "暂无维护动作",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5580EB),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
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
                      padding: EdgeInsets.only(bottom: 20,top: 10),
                      child: Image(
                        image: AssetImage('images/upbtn.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 32,
              height: 32,
              padding: EdgeInsets.only(right: 7,top: 2),
//                transform: Matrix4.rotationZ(1/8),
              decoration: BoxDecoration(
                  color: widget.gender == 0?Color(0xFFFF9600):Color(0xFFF24848),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12))
              ),
              child: Text(
                widget.gender == 0?"♂":"♀",
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
          ),
          // 编辑按钮
          Positioned(
            left: 250,
            top: 12,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                  item:widget.item,
                  tabIndex: 0,
                )));
              },
              child: Container(
                width: 60,
                height: 24,
                color: Colors.transparent,
                child: Image(
                    image: AssetImage('images/editor.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

