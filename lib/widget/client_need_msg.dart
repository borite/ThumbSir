import 'package:ThumbSir/pages/broker/client/buy_need_page.dart';
import 'package:ThumbSir/pages/broker/client/sell_need_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_needs_detail_dao.dart';
import 'package:ThumbSir/pages/broker/traded/traded_add_deal_page.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/common/alert.dart';


class ClientNeedMsg extends StatefulWidget {
  final item;

  ClientNeedMsg({Key key,
    this.item
  }):super(key:key);
  @override
  _ClientNeedMsgState createState()=> _ClientNeedMsgState();
}

class _ClientNeedMsgState extends State<ClientNeedMsg> with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  bool _loading = false;
  List need=new List();
  List<Widget> msgs=[];
  String needMinCount = "购买住宅";
  String stateMinCount = "已成交";

  _load() async {
    var needResult = await GetNeedsDetailDao.httpGetNeedsDetail(
      widget.item.mid.toString()
    );

      if (needResult.code == 200) {
        var needsList = needResult.data;
        if (needsList.length>0) {
          need = needsList;
          setState(() {
            for (var item in need) {
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
                              Row(
                                children: [
                                  Text(
                                    item.mainNeed??"暂无",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5580EB),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _changeStateAlertPressed(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Chip(
                                          backgroundColor: Color(0xFF24CC8E),
                                          label: Row(
                                            children: [
                                              Text(
                                                item.state == 2?'进行中 ':item.state==1?"已成交️ ":"失效️ ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),),
                                              Icon(
                                                Icons.edit,
                                                color:Colors.white,
                                                size: 14,
                                              )

                                            ],
                                          )

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditDealPage(
                                  //   item:widget.item,
                                  //   dealItem: item,
                                  // )));
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
                        // 购房原因
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "需求原因：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                item.needReason??"未知",
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
                        // 购房用途
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "购房用途：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "自住",
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
                        // 决策人
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "是否为购房决策人：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "是",
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
                        // 资质审核
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "是否有购房资质：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "是",
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
                        // 付款方式
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "付款方式：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "贷款",
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
                        // 总价预算
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "总价预算：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "700万",
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
                        // 首付预算
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "首付预算：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "300万",
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
                        // 意向区域
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "意向区域：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "三环内，长河湾小区、卫生部小区、交大东路56号院",
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
                        // 核心需求
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "核心需求：",
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
                        // 核心需求1
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                  // "居室：3居室",
                                  item.coreNeedOne??"暂无核心需求",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child:Text(
                                  // "要住三代人",
                                  item.coreNeedOneRemark??"无备注",
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
                        // 核心需求2
                        item.coreNeedTwo == null || item.coreNeedTwo == ""?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                  item.coreNeedTwo??"暂无第二核心需求",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child:Text(
                                  item.coreNeedTwoRemark??"-",
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
                        )
                            :
                        Container(width: 1,),
                        // 核心需求3
                        item.coreNeedThree == null || item.coreNeedThree == ""?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
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
                                  item.coreNeedThree??"暂无第三核心需求",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child:Text(
                                  item.coreNeedTwoRemark??"-",
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
                        )
                        :
                        Container(width: 1,),

                        // 综合描述
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "综合描述：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item.otherNeedRemark??"无",
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

                        // 其他需求
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "其他需求：",
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
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Wrap(
                            spacing: 10,
                            children: <Widget>[
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('楼层：3~5层',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('面积：70平米',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('朝向：不限',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('税费：满五唯一',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('楼龄：不限',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('电梯：不带电梯',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('交通：近地铁',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('医院：不限',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('银行：不限',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('公园：不限',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('商场：不限',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('物业：中等',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('特殊要求：车位、安静、人车分流',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('其他：小书房',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
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
                            _addNeedAlertPressed(context);
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
                              "+ 新增需求",
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
                            '暂无需求记录',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF999999)
                            ),
                          ),
                        )
                    ),
                    // 购买
                    Container(
                      child: Column(
                        children: [
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
                                        "购买公寓",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditDealPage(
                                          //   item:widget.item,
                                          //   dealItem: item,
                                          // )));
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
                                // 购房原因
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "购房原因：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "婚房",
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
                                // 购房用途
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "购房用途：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "自住",
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
                                // 决策人
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "是否为购房决策人：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "是",
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
                                // 资质审核
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "是否有购房资质：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "是",
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
                                // 付款方式
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "付款方式：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "贷款",
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
                                // 总价预算
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "总价预算：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "700万",
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
                                // 首付预算
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "首付预算：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "300万",
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
                                // 意向区域
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "意向区域：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "三环内，长河湾小区、卫生部小区、交大东路56号院",
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
                                // 核心需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "核心需求：",
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
                                // 核心需求1
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "居室：3居室",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "要住三代人",
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
                                // 核心需求2
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "学区：交大附小",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "孩子2022年上小学",
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
                                // 核心需求3
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
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
                                          "装修：精装修",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "房子已经卖了，着急住",
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

                                // 综合描述
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "综合描述：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "自己的房子已经卖了，着急住，最好楼层低一些或带电梯",
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

                                // 其他需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "其他需求：",
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
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Wrap(
                                    spacing: 10,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('楼层：3~5层',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('面积：70平米',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('朝向：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('税费：满五唯一',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('楼龄：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('电梯：不带电梯',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('交通：近地铁',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('医院：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('银行：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('公园：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('商场：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('物业：中等',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('特殊要求：车位、安静、人车分流',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('其他：小书房',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                    // 租赁
                    Container(
                      child: Column(
                        children: [
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
                                        "租赁住宅",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditDealPage(
                                          //   item:widget.item,
                                          //   dealItem: item,
                                          // )));
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
                                // 租房原因
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "租房原因：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "上班",
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
                                // 租房用途
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "租房用途：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "自住",
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
                                // 决策人
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "是否为租房决策人：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "是",
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
                                // 付款方式
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "付款方式：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "押一付三",
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
                                // 每月预算
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "每月房租预算：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "4000元",
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
                                // 意向区域
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "意向区域：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "三环内，长河湾小区、卫生部小区、交大东路56号院",
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
                                // 核心需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "核心需求：",
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
                                // 核心需求1
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "居室：3居室",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "要住三代人",
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
                                // 核心需求2
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "学区：交大附小",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "孩子2022年上小学",
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
                                // 核心需求3
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
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
                                          "装修：精装修",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "房子已经卖了，着急住",
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

                                // 综合描述
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "综合描述：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "自己的房子已经卖了，着急住，最好楼层低一些或带电梯",
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

                                // 其他需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "其他需求：",
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
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Wrap(
                                    spacing: 10,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('楼层：3~5层',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('面积：70平米',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('朝向：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('税费：满五唯一',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('楼龄：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('电梯：不带电梯',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('交通：近地铁',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('医院：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('银行：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('公园：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('商场：不限',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('物业：中等',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('特殊要求：车位、安静、人车分流',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('其他：小书房',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                    // 出售
                    Container(
                      child: Column(
                        children: [
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
                                        "出售公寓",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditDealPage(
                                          //   item:widget.item,
                                          //   dealItem: item,
                                          // )));
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
                                // 出售原因
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "出售原因：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "变现",
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
                                // 房屋现用途
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "房屋现用途：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "自住",
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
                                // 决策人
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "是否为出售决策人：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "是",
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
                                // 当前报价
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "当前报价：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "700万",
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
                                // 房屋地址
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "房屋地址：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "北京市海淀区交大东路56号院3号楼1单元402",
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
                                // 房源详情
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "房源详情：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "点击前往房源系统",
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
                                // 核心需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "核心需求：",
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
                                // 核心需求1
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "付款方式：全款",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "着急用钱",
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
                                // 核心需求2
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "定金：50万",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "3月3日之前需要用",
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
                                // 核心需求3
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
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
                                          "底价：680万",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "不能再低了",
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

                                // 综合描述
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "综合描述：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "着急用钱，需要周期短且全款的用户",
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

                                // 其他需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "其他需求：",
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
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Wrap(
                                    spacing: 10,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('成交周期：5月之前',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('其他：越快越好',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                    // 出租
                    Container(
                      child: Column(
                        children: [
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
                                        "出租住宅",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedEditDealPage(
                                          //   item:widget.item,
                                          //   dealItem: item,
                                          // )));
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
                                // 出租原因
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "出租原因：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "闲置",
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
                                // 房屋现用途
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "房屋现用途：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "闲置",
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
                                // 决策人
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "是否为出租决策人：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "是",
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
                                // 当前报价
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "当前报价：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "5000元/月",
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
                                // 房屋地址
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "房屋地址：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "北京市海淀区交大东路56号院3号楼1单元402",
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
                                // 房源详情
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "房源详情：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "点击前往房源系统",
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
                                // 核心需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "核心需求：",
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
                                // 核心需求1
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "付款方式：押一付三",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "无",
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
                                // 核心需求2
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
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
                                          "押金：2个月房租",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "家电设备好，业主想多要押金",
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
                                // 核心需求3
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
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
                                          "底价：4800元/月",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Text(
                                          "不能再低了",
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

                                // 综合描述
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "综合描述：",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "自己的房子已经卖了，着急住，最好楼层低一些或带电梯",
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

                                // 其他需求
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "其他需求：",
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
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                                  child: Wrap(
                                    spacing: 10,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('其他：租户最好是女生',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                      Chip(
                                        backgroundColor: Color(0xFF93C0FB),
                                        label: Text('其他：整租优先',style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),

            ],
          )
      )
    );

  }
  _addNeedAlertPressed(context) {
    Alert(
      context: context,
      title: "添加客户需求",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("需求类型：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            height: 120,
            margin: EdgeInsets.only(top: 18),
            child: WheelChooser(
              onValueChanged: (s){
                setState(() {
                  needMinCount = s;
                });
              },
              datas: ["购买住宅", "购买商铺", "购买公寓", "购买车位","出售住宅", "出售商铺", "出售公寓", "出售车位","租赁住宅", "租赁商铺", "租赁公寓", "租赁车位","出租住宅", "出租商铺", "出租公寓", "出租车位",],
              selectTextStyle: TextStyle(
                  color: Color(0xFF0E7AE6),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: 12
              ),
              unSelectTextStyle: TextStyle(
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: 12
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if(needMinCount.substring(0,2)=="购买"|| needMinCount.substring(0,2)=="租赁"){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyNeedPage(
                cid: widget.item.mid,
                mainNeed:needMinCount,
                userName:widget.item.userName
              )));
            }
            if(needMinCount.substring(0,2) == "出售" || needMinCount.substring(0,2) == "出租"){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SellNeedPage(
                cid: widget.item.mid,
                mainNeed:needMinCount,
                userName:widget.item.userName
              )));
            }

          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  _changeStateAlertPressed(context) {
    Alert(
      context: context,
      title: "修改需求状态",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("将需求修改为：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            width: 150,
            height: 120,
            margin: EdgeInsets.only(top: 18),
            child: WheelChooser(
              onValueChanged: (s){
                setState(() {
                  stateMinCount = s;
                });
              },
              datas: ["已成交", "进行中", "失效","删除此需求", ],
              selectTextStyle: TextStyle(
                  color: Color(0xFF0E7AE6),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: 12
              ),
              unSelectTextStyle: TextStyle(
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontSize: 12
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            // 修改需求状态并跳转到详情页
            if(stateMinCount == "已成交"){
              // 删自己，添加成交信息,并跳转到详情页

            }
            if(stateMinCount == "进行中"){
              // 改变state为2,并跳转到详情页

            }
            if(stateMinCount == "失效"){
              // 改变state为3,并跳转到详情页

            }
            if(stateMinCount == "删除此需求"){
              // 删自己,并跳转到详情页

            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }


  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}
