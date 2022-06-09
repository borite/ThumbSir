import 'package:ThumbSir/dao/get_deal_detail_dao.dart';
import 'package:ThumbSir/pages/broker/client/client_add_deal_page.dart';
import 'package:ThumbSir/pages/broker/client/client_edit_deal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/common/alert.dart';


class ClientDealMsg extends StatefulWidget {
  final item;

  ClientDealMsg({Key? key,
    this.item
  }):super(key:key);
  @override
  _ClientDealMsgState createState()=> _ClientDealMsgState();
}

class _ClientDealMsgState extends State<ClientDealMsg> with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  bool _loading = false;
  late List deal;
  List<Widget> msgs=[];

  _load() async {
    var dealResult = await GetDealDetailDao.httpGetDealDetail(
      widget.item.mid.toString()
    );

      if (dealResult.code == 200) {
        var dealsList = dealResult.data;
        if (dealsList!.length>0) {
          deal = dealsList;
          setState(() {
            for (var item in deal) {
              msgs.add(
                  Container(
                    width: 335,
                    child: Column(
                      children: <Widget>[
                        // 基本信息
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item.dealReason,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF5580EB),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientEditDealPage(
                                    item:widget.item,
                                    dealItem: item,
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
                                item.finishTime.toString().substring(0,10),
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
                                item.dealPrice == 0 || item.dealPrice == null ?"未知":item.dealPrice.toString()+"万元",
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
                                item.dealArea == "0" || item.dealArea == null || item.dealArea == ""?"未知":item.dealArea+"平米",
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
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                  item.address == "" || item.address == null?"未知":item.address,
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
                        // 关联房源
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "关联房源：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                width: 22,
                                padding: EdgeInsets.only(right: 5,top: 2),
                                child: Image(image: AssetImage(
                                    'images/site_small.png'),),
                              ),
                              Expanded(
                                child: Text(
                                  item.address == "" || item.address == null?"未知":item.address,
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
                        // 备注
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "备注：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item.dealRemark == "" || item.dealRemark == null?"未填写":item.dealRemark,
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

                  )

              );
            }
          });
        }
      } else {
        onLoadAlert(context);
        _onRefresh();
      }

  }

  @override
  void initState(){
    _load();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.only(top:100,bottom:40),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientAddDealPage(
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
                    // 需求记录列表
                    Container(
                      child: msgs.length>0?
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: msgs.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 20),
                        itemBuilder: (BuildContext context,int index){
                          return msgs[index];
                        },
                      )
                          :
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          '暂无成交记录',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF999999)
                          ),
                        ),
                      )
                    ),
                  ],
                )
              ),

            ],
          )
      )
    );
  }


  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}
