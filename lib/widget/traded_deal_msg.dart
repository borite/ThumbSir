import 'package:ThumbSir/pages/broker/traded/traded_add_deal_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_edit_deal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TradedDealMsg extends StatefulWidget {
  final item;

  TradedDealMsg({Key key,
    this.item
  }):super(key:key);
  @override
  _TradedDealMsgState createState()=> _TradedDealMsgState();
}

class _TradedDealMsgState extends State<TradedDealMsg> with SingleTickerProviderStateMixin{
  List deal=new List();
  @override
  void initState(){
    deal = widget.item.dealList;
    super.initState();
  }


//  @override
//  void dispose(){
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:117,bottom:40),
                child: Column(
                  children: <Widget>[
                    // 姓名
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              margin: EdgeInsets.only(left: 20,right: 10,bottom: 10),
                              child: Image.asset("images/my_3.png"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.item.userName,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )

                          ],
                        ),
                        // 新增按钮
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedAddDealPage(
                              item: widget.item,
                            )));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                            margin: EdgeInsets.only(right: 20,top: 2,bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xFF93C0FB)
                                ),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text(
                              "+ 新增成交信息",
                              style: TextStyle(
                                  color: Color(0xFF93C0FB),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    deal.length>0?
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 520,
                      child: ListView.builder(
                        itemCount: deal.length,
                        itemBuilder: (BuildContext context,int index){
                          return Column(
                            children: <Widget>[
                              // 基本信息
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      deal[index].dealReason,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF5580EB),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditDealPage(
                                          item:widget.item,
                                          dealItem: deal[index],
                                        )));
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 20,
                                        color: Colors.transparent,
                                        child: Image.asset("images/editor.png"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // 时间
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "成交时间：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      deal[index].finishTime.toString().substring(0,10),
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
                              // 成交价
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "成交价：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      deal[index].dealPrice == 0?"未知":deal[index].dealPrice.toString(),
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
                              // 面积
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "面积：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      deal[index].dealArea == "0"?"未知":deal[index].dealArea,
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
                              // 地址
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "地址：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        deal[index].address,
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
                          );
                        },
                      ),
                    )
                        :
                    Container(
                      child: Text(
                        "暂无成交历史",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                )
              )
            ],
          )
      )
    );
  }
}
