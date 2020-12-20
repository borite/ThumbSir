import 'package:ThumbSir/pages/broker/traded/traded_edit_gift_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GiftItem extends StatefulWidget {
  final date;
  final giftMsg;
  final price;
  final dec;
  final type;
  final id;
  final item;

  GiftItem({Key key,
    this.date,this.giftMsg,this.price,this.dec,this.type,this.item,this.id
  }):super(key:key);
  @override
  _GiftItemState createState() => _GiftItemState();
}

class _GiftItemState extends State<GiftItem> with SingleTickerProviderStateMixin{
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
    return Container(
      width: 335,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: animation.value),
//      margin: EdgeInsets.only(top: 25),
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
                    // 分类和时间
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF5580EB),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(left: 20,right: 10),
                                child: widget.type == "业务礼"?Image.asset("images/gift.png")
                                :widget.type == "成交礼"?Image.asset("images/gift_deal.png")
                                :widget.type == "生日礼"?Image.asset("images/gift_birth.png")
                                :widget.type == "日常问候"?Image.asset("images/care.png")
                                :Image.asset("images/gift_festive.png"),
                              ),
                              Text(
                                widget.type,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 50),
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              widget.date,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 礼品
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "维护动作：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5580EB),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.giftMsg,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 描述
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "备注：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5580EB),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.dec == ""?"未填写":widget.dec,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 价格
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "价格：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                widget.price+"元",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditGiftPage(
                                item: widget.item,
                                date:widget.date,
                                giftMsg:widget.giftMsg,
                                price:widget.price,
                                dec:widget.dec,
                                type:widget.type,
                                id:widget.id,
                              )));
                            },
                            child: Container(
                              width: 50,
                              height: 20,
                              child: Image.asset("images/editor.png"),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

