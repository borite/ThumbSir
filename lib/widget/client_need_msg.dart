import 'package:ThumbSir/dao/change_need_state_dao.dart';
import 'package:ThumbSir/dao/delete_customer_need_dao.dart';
import 'package:ThumbSir/pages/broker/client/buy_need_page.dart';
import 'package:ThumbSir/pages/broker/client/client_detail_page.dart';
import 'package:ThumbSir/pages/broker/client/client_need_to_add_deal_page.dart';
import 'package:ThumbSir/pages/broker/client/edit_buy_need_page.dart';
import 'package:ThumbSir/pages/broker/client/edit_sell_need_page.dart';
import 'package:ThumbSir/pages/broker/client/sell_need_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/get_needs_detail_dao.dart';
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
        print(needsList);

        if (needsList.length>0) {
          need = needsList;

          setState(() {
            for (var item in need) {
              List<Widget> others=[];
              print(item);
              var noOtherNeeds;
              var _otherNeedArr;
              var _otherList;

              String IsJueCe;
              //决策人姓名
              String JueCeName;
              //决策人手机号
              String JueCePhone;
              //是否有代理人
              String HasDaiLi;
              //代理人姓名
              String DaiLiName;
              //代理人手机号
              String DaiLiPhone;
              //付款方式
              String PayWay;
              //首付预算
              String ShouFu;
              //总价预算
              String ZongJia;
              //意向小区
              String YxXiaoQu;
              var _otherNeesArr;

              //核心需求记录
              String coreNeedsArr="";
              if(item.coreNeedOne!=null){
                coreNeedsArr+=item.coreNeedOne;
              }

              if(item.coreNeedTwo!=null&&!item.coreNeedTwo.toString().contains('暂无')){
                coreNeedsArr+='|'+item.coreNeedTwo;
              }
              if(item.coreNeedThree!=null&&!item.coreNeedThree.toString().contains('暂无')){
                coreNeedsArr+='|'+item.coreNeedThree;
              }

              if(item.otherNeed!=null){
                var iOtherNeed=item.otherNeed.toString();
                //增加分隔符|
                iOtherNeed= iOtherNeed.replaceAll('}', '}|');
                //通过分隔符分割字符串，0-为非核心需求，1-为决策之类的信息
                _otherNeedArr=iOtherNeed.split('|');

                //把决策类的信息再次用逗号分割
                noOtherNeeds=_otherNeedArr[1].split(',');

                print(noOtherNeeds);

                //定义相关数据变量
                //是否为决策人
                IsJueCe=noOtherNeeds[1].split(':')[1];
                //决策人姓名
                JueCeName=noOtherNeeds[2].split(':')[1];
                //决策人手机号
                JueCePhone=noOtherNeeds[3].split(':')[1];
                //是否有代理人
                HasDaiLi=noOtherNeeds[4].split(':')[1];
                //代理人姓名
                DaiLiName=noOtherNeeds[5].split(':')[1];
                //代理人手机号
                DaiLiPhone=noOtherNeeds[6].split(':')[1];
                //付款方式
                PayWay=noOtherNeeds[7].split(':')[1];
                //首付预算
                ShouFu=noOtherNeeds[8].split(':')[1];
                //总价预算
                ZongJia=noOtherNeeds[9].split(':')[1];
                //意向小区
                YxXiaoQu=noOtherNeeds[10].split(':')[1];

                _otherNeesArr= _reGroupOtherNeed(_otherNeedArr[0], coreNeedsArr,item.mainNeed);
                _otherList=_otherNeesArr.toString().split(",");
                for (var item1 in _otherList) {
                    others.add(
                      Chip(
                        backgroundColor: Color(0xFF93C0FB),
                        label: Text(item1.replaceAll('"', '')
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),),
                      ),
                    );
                };
              } else{
                IsJueCe="未完善";
                //决策人姓名
                JueCeName="未完善";
                //决策人手机号
                JueCePhone="未完善";
                //是否有代理人
                HasDaiLi="未完善";
                //代理人姓名
                DaiLiName="未完善";
                //代理人手机号
                DaiLiPhone="未完善";
                //付款方式
                PayWay="未完善";
                //首付预算
                ShouFu="未完善";
                //总价预算
                ZongJia="未完善";
                //意向小区
                YxXiaoQu="未完善";
                // _otherNeesArr;
              }

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
                                    item.mainNeed??"暂无需求",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF5580EB),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _changeStateAlertPressed(context,item.id,item);
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
                                  if(item.mainNeed.toString().substring(0,2)=="购买" || item.mainNeed.toString().substring(0,2)=="租赁"){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBuyNeedPage(
                                      cid: widget.item.mid,
                                      mainNeed:item.mainNeed,
                                      userName:widget.item.userName,
                                      needDetail: item,
                                    )));
                                  }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditSellNeedPage(
                                      cid: widget.item.mid,
                                      mainNeed:item.mainNeed,
                                      userName:widget.item.userName,
                                      needDetail: item,
                                    )));
                                  }

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
                        // 需求创建时间
                        Container(
                          margin: EdgeInsets.only(left: 20,bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "需求创建时间：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                item.addTime!=null?item.addTime.toString().substring(0,10):"-",
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
                                item.needReason??"未完善",
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
                        // Container(
                        //   margin: EdgeInsets.only(left: 20,top: 10),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Text(
                        //         "购房用途：",
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           color: Color(0xFF666666),
                        //           decoration: TextDecoration.none,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //       ),
                        //       Text(
                        //         "自住",
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           color: Color(0xFF666666),
                        //           decoration: TextDecoration.none,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // 是否为决策人
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "是否为决策人：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                IsJueCe,
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
                        // 决策人姓名
                        IsJueCe=="否"?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "决策人姓名：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                JueCeName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ):Container(width: 1,),
                        // 决策人手机号
                        IsJueCe=="否"?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "决策人手机号：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                JueCePhone,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ):Container(width: 1,),
                        // 是否有代理人
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "是否有代理人：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                HasDaiLi,
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
                        // 代理人姓名
                        HasDaiLi=="是"?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "代理人姓名：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                DaiLiName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ):Container(width: 1,),
                        // 代理人手机号
                        HasDaiLi=="是"?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "代理人手机号码：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                DaiLiPhone,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ):Container(width: 1,),
                        // 资质审核
                        // Container(
                        //   margin: EdgeInsets.only(left: 20,top: 10),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Text(
                        //         "是否有购房资质：",
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           color: Color(0xFF666666),
                        //           decoration: TextDecoration.none,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //       ),
                        //       Text(
                        //         "是",
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           color: Color(0xFF666666),
                        //           decoration: TextDecoration.none,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // 付款方式
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                item.mainNeed.toString().substring(0,1)=="购买"||item.mainNeed.toString().substring(0,1)=="租赁"?
                                    "付款方式：":"房屋现用途：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  PayWay,
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
                                item.mainNeed.toString().substring(0,2)=="购买"?"总价预算：":
                                item.mainNeed.toString().substring(0,1)=="租赁"?"押金预算：":"底价：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ZongJia,
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
                        PayWay=="全款"?Container(width: 1,):
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                item.mainNeed.toString().substring(0,2)=="购买"?"首付预算：":
                                item.mainNeed.toString().substring(0,1)=="租赁"?"月租金预算：":"报盘价：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ShouFu,
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
                                item.mainNeed.toString().substring(0,1)=="购买"||item.mainNeed.toString().substring(0,1)=="租赁"?
                                "意向区域：":"房源地址：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  YxXiaoQu,
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
                                  item.coreNeedOneRemark??"无描述",
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
                        item.coreNeedTwo != null && item.coreNeedTwo != ""?
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
                        item.coreNeedThree != null && item.coreNeedThree != ""?
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
                                  item.coreNeedThreeRemark??"-",
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

                        item.otherNeed==null?
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Row(
                            children: <Widget>[
                              Chip(
                                backgroundColor: Color(0xFF93C0FB),
                                label: Text('未完善，点我去完善信息吧~',style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                            ],
                          ),
                        )
                        :
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 0),
                          child: Wrap(
                            spacing: 10,
                            children: others,
                          ),
                        ),

                      ],
                    ),
                  )
              );
            }
            //others.clear();
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
  _changeStateAlertPressed(context,id,item) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientNeedToAddDealPage(
                item:widget.item,
                needID: id,
                needItem:item,
              )));
            }
            if(stateMinCount == "进行中"){
              // 改变state为2,并跳转到详情页
              var changeState = await ChangeNeedStateDao.cahngeNeedState(id.toString(),"2");
              if(changeState.code == 200){
                _onRefresh();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                  item:widget.item,
                  tabIndex: 0,
                )));
              }else {
                _onRefresh();
                onOverLoadPressed(context);
              }
            }
            if(stateMinCount == "失效"){
              // 改变state为3,并跳转到详情页
              var changeState = await ChangeNeedStateDao.cahngeNeedState(id.toString(),"3");
              if(changeState.code == 200){
                _onRefresh();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                  item:widget.item,
                  tabIndex: 0,
                )));
              }else {
                _onRefresh();
                onOverLoadPressed(context);
              }
            }
            if(stateMinCount == "删除此需求"){
              // 删自己,并跳转到详情页
              var deleteNeed = await DeleteCustomerNeedDao.deleteCustomerNeed(id.toString());
              if(deleteNeed.code == 200){
                _onRefresh();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                  item:widget.item,
                  tabIndex: 0,
                )));
              }else {
                _onRefresh();
                onOverLoadPressed(context);
              }
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

  //从其他需求中分离核心需求
  _reGroupOtherNeed(String otherNeedsArr,String coreNeedsArr,mainNeed){
      String oarr="";
      var coreNeedsList=coreNeedsArr.split('|');
      var coreNeedKey="";
      for(var i=0;i<coreNeedsList.length;i++){
        coreNeedKey+=","+coreNeedsList[i].split(':')[0];
      }
      coreNeedKey=coreNeedKey.substring(1);
      print(coreNeedKey);
      var on;
      if(mainNeed.toString().substring(0,2)=="出租"){
        on=otherNeedsArr.replaceAll('elevator', '电梯')
            .replaceAll('floor', '楼层')
            .replaceAll('houseage', '楼龄')
            .replaceAll('decoration', '装修')
            .replaceAll('traffic', '交通')
            .replaceAll('school', '学区')
            .replaceAll('hospital', '医院')
            .replaceAll('bank', '银行')
            .replaceAll('park', '公园')
            .replaceAll('shop', '商场')
            .replaceAll('property', '物业')
            .replaceAll('tax', '税费')
            .replaceAll('special', '特殊要求')
            .replaceAll('other', '其他')
            .replaceAll('area', '面积')
            .replaceAll('room', '居室')
            .replaceAll('direction', '朝向')
            .replaceAll('buyWay', '付款方式')
            .replaceAll('dingJin', '定金')
            .replaceAll('shouFu', '押金')
            .replaceAll('zhouQi', '成交周期')
            .replaceAll('{', '').replaceAll('}', '').split('\",\"');
      }else{
        on=otherNeedsArr.replaceAll('elevator', '电梯')
            .replaceAll('floor', '楼层')
            .replaceAll('houseage', '楼龄')
            .replaceAll('decoration', '装修')
            .replaceAll('traffic', '交通')
            .replaceAll('school', '学区')
            .replaceAll('hospital', '医院')
            .replaceAll('bank', '银行')
            .replaceAll('park', '公园')
            .replaceAll('shop', '商场')
            .replaceAll('property', '物业')
            .replaceAll('tax', '税费')
            .replaceAll('special', '特殊要求')
            .replaceAll('other', '其他')
            .replaceAll('area', '面积')
            .replaceAll('room', '居室')
            .replaceAll('direction', '朝向')
            .replaceAll('buyWay', '付款方式')
            .replaceAll('dingJin', '定金')
            .replaceAll('shouFu', '首付')
            .replaceAll('zhouQi', '成交周期')
            .replaceAll('{', '').replaceAll('}', '').split('\",\"');
      }
      var core=coreNeedsArr.split('|');
      for(var o=0;o<on.length;o++){

        var k=on[o].replaceAll('\"', '').split(':')[0];
        if(!coreNeedKey.contains(k)){
            oarr+=on[o]+"|";
        }
      }
      print(on);
      print(core);
      print(oarr);
      var reOtherNeedsArr=oarr.substring(0,oarr.lastIndexOf('|')).split('|');
      return reOtherNeedsArr;

  }

}
