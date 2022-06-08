import 'dart:convert';

import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_new_needs_dao.dart';
import 'package:ThumbSir/dao/get_user_detail_by_id_dao.dart';
import 'package:ThumbSir/dao/update_customer_need_dao.dart';
import 'package:ThumbSir/model/sell_other_needs_model.dart';
import 'package:ThumbSir/pages/broker/client/client_detail_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';

class EditSellNeedDetailPage extends StatefulWidget {
  final isNew;
  final cid;
  final needDetail;
  final mainNeed;
  final needReason;
  final userName;
  final coreNeedNames;
  final otherMsg;

  EditSellNeedDetailPage({Key key,
    this.isNew,this.cid,this.needDetail,this.mainNeed,this.needReason,this.userName,this.coreNeedNames,this.otherMsg
  }):super(key:key);
  @override
  _EditSellNeedDetailPageState createState() => _EditSellNeedDetailPageState();
}

class _EditSellNeedDetailPageState extends State<EditSellNeedDetailPage> {
  //其它需求类
  SellOtherNeeds _otherNeeds = new SellOtherNeeds();

  //默认是所有需求，下面通过对比传来的核心字符，会去除核心需求，最终是非核心需求
  List<BuyRequirement> reqList=new List();
  List<BuyRequirement> allList = new List();
  //核心需求列表
  List<BuyRequirement> coreList=new List();
  //非核心需求列表
  List<BuyRequirement> nonCoreList=new List();

  //默认选择的选项
  List<String> defaultSel=new List();

  String oldCoreNeedOne;
  String oldCoreNeedOneRemark;
  String oldCoreNeedTwo;
  String oldCoreNeedTwoRemark;
  String oldCoreNeedThree;
  String oldCoreNeedThreeRemark;

  bool _loading = false;
  String otherChooses;

  final TextEditingController mapController=TextEditingController();
  RegExp mapReg;
  bool mapBool = false;
  final TextEditingController coreController1=TextEditingController();
  RegExp core1Reg;
  bool core1Bool = false;
  final TextEditingController coreController2=TextEditingController();
  RegExp core2Reg;
  bool core2Bool = false;
  final TextEditingController coreController3=TextEditingController();
  RegExp core3Reg;
  bool core3Bool = false;
  final TextEditingController otherController=TextEditingController();
  RegExp otherReg;
  bool otherBool = false;
  final TextEditingController dingJinController=TextEditingController();
  RegExp dingJinReg;
  bool dingJinBool = false;
  final TextEditingController shouFuController=TextEditingController();
  RegExp shouFuReg;
  bool shouFuBool = false;

  String core1choose="";
  String core2choose="";
  String core3choose="";

  List<String> tags = [];
  List idList = [];
  int itemLength = 0;
  List missionContent=new List();
  List<String> way = [];
  List<String> period = [];

  List<String> waySel = [];
  List<String> periodSel = [];

  List<Widget> nonCoreShowList = [];
  List<Widget> noncore = [];

  int dingJinCount = 1;
  int shouFuCount = 1;

  @override
  void initState() {
    mapReg = FeedBackReg;
    otherReg = TextReg;
    core1Reg = TextReg;
    core2Reg = TextReg;
    core3Reg = TextReg;
    dingJinReg = TextReg;
    shouFuReg = TextReg;

    way=["全款","商业贷款","组合贷","无要求"];
    period=["2个月内","3个月内","4个月内","半年内","无要求"];

    _oldMsg();

    if(widget.mainNeed.toString().substring(0,2)=="出售"){
      reqList.add(new BuyRequirement("付款方式", "全款,商业贷款,组合贷,无要求",3));
    }else{
      reqList.add(new BuyRequirement("付款方式", "月付,季付,半年付,年付,无要求",3));
    }

    reqList.add(new BuyRequirement("成交周期", "1个月内,2个月内,3个月内,4个月内,半年内,无要求",3));
    reqList.add(new BuyRequirement("定金", "a,b",1));
    if(widget.mainNeed.toString().substring(0,2)=="出售"){
      reqList.add(new BuyRequirement("首付", "a,b",1));
    }else{
      reqList.add(new BuyRequirement("押金", "a,b",1));
    }
    reqList.add(new BuyRequirement("其他", "a,b",1));

    //这里把所有的需求都加入,默认都为非核心需求，isCore为false

    //遍历一下需求List，如果有同传过来的一样，则为核心需求,会从reqList去除核心需求项，并加入到coreList里，最终reqList是非核心需求列表
    //coreList是核心需求列表
    reqList.forEach((element) {
      if(element!=null) {
        allList.add(element);
        if (widget.coreNeedNames.contains(element.reqName)) {
          coreList.add(element);
        }else{
          nonCoreList.add(element);
        }
      }
    });

    if(coreList.length>0&& nonCoreList.length>0){
      _addOtherList();
      noncore = nonCoreShowList;
    }

    super.initState();
  }

  _addOtherList(){
    if (nonCoreList.length>0) {
      var oneed=widget.needDetail.otherNeed.toString().split('}')[0]+"}";
      Map<String,dynamic> otherNeedSelected = json.decode(oneed);
      for (var item in nonCoreList) {
        if(item.reqName=="其他"){
          nonCoreShowList.add(
              Column(
                children: [
                  // 其他
                  Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.reqName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF5580EB)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: otherController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      onChanged: _onOtherChanged,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              )
          );
        }
        else if(item.reqName=="定金"){
          nonCoreShowList.add(
              Column(
                children: [
                  // 定金
                  Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.reqName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                    width: 335,
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text('最低定金数额',style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF333333),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),),
                        ),
                        Container(
                          // height: 50,
                          width:100,
                          margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: dingJinController,
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onChanged: _onDingJinChanged,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.bottom,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              hintText:'-',
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20,left: 5),
                          child: Text(
                            widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",
                            style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF333333),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        }
        else if(item.reqName=="首付" || item.reqName=="押金"){
          nonCoreShowList.add(
              Column(
                children: [
                  // 首付
                  Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.reqName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                    width: 335,
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            widget.mainNeed.toString().substring(0,2)=="出售"?'最低首付数额':"最低押金数额",
                            style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF333333),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),),
                        ),
                        Container(
                          // height: 50,
                          width:100,
                          margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: shouFuController,
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onChanged: _onShouFuChanged,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.bottom,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              hintText:'-',
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: Text(widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF333333),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        }
        else{
          if(item.reqName=="付款方式"){
            setState(() {
              waySel=otherNeedSelected["buyWay"].toString().split(',');
            });
          }

          if(item.reqName=="成交周期"){
            setState(() {
              periodSel=otherNeedSelected["zhouQi"].toString().split(',');
            });
          }

          nonCoreShowList.add(
              Column(
                children: [
                  Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.reqName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: 335,
                      child: FormField<List<String>>(
                          initialValue: tags,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '请选择核心任务的名称';
                            }
                            if (value.length > item.maxSelect) {
                              return "选择不可多于"+item.maxSelect.toString()+"项";
                            }
                            return null;
                          },
                          builder: (state) {
                            return Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ChipsChoice<String>.multiple(
                                      value: _returnStateList(item.reqName),
                                      options:  ChipsChoiceOption.listFrom(
                                          source: item.reqOptions.split(','),
                                          // 存储形式
                                          value:(index,item)=>item,
                                          // 展示形式
                                          label: (index,item)=>item
                                      ),
                                      onChanged: (val) {
                                        state.didChange(val);

                                        String sel="";
                                        val.forEach((element) {
                                          sel+=element+",";
                                        });

                                        //设置新的选中项
                                        setState(() {
                                          if(item.reqName=="付款方式"){
                                            waySel=val;
                                          }else if(item.reqName=="成交周期"){
                                            periodSel=val;
                                          }else{
                                            defaultSel=val;
                                          }
                                        });
                                        _CheckSelection(item.reqName, sel.substring(0,sel.lastIndexOf(',')));
                                      },
                                      itemConfig: ChipsChoiceItemConfig(
                                        selectedColor: Color(0xFF5580EB),
                                        selectedBrightness: Brightness.dark,
                                        unselectedColor: Color(0xFF5580EB),
                                        unselectedBorderOpacity: .3,
                                      ),
                                      isWrapped: true,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.errorText ?? _returnStateList(item.reqName).length.toString() + '/'+item.maxSelect.toString()+' 可选',
                                        style: TextStyle(
                                            color: state.hasError
                                                ? Colors.redAccent
                                                : Colors.green
                                        ),
                                      )
                                  )
                                ]);}
                      )
                  ),
                ],
              )
          );
        }
      }
    }
  }

  _oldMsg(){
    mapController.text = widget.needDetail.otherNeedRemark;
    if(widget.isNew=="old"){
      oldCoreNeedOne = "old";
      if(widget.needDetail.coreNeedOne != null && widget.needDetail.coreNeedOne.toString().contains(":")){
        core1choose = widget.needDetail.coreNeedOne.toString().split(":")[1]+",";
      }
      oldCoreNeedOneRemark = widget.needDetail.coreNeedOneRemark;
      coreController1.text = widget.needDetail.coreNeedOneRemark;

      oldCoreNeedTwo = "old";
      if(widget.needDetail.coreNeedTwo != null &&widget.needDetail.coreNeedTwo.toString().contains(":")){
        core2choose = widget.needDetail.coreNeedTwo.toString().split(":")[1]+",";
      }
      oldCoreNeedTwoRemark = widget.needDetail.coreNeedTwoRemark;
      coreController2.text = widget.needDetail.coreNeedTwoRemark;

      oldCoreNeedThree = "old";
      if(widget.needDetail.coreNeedThree != null &&widget.needDetail.coreNeedThree.toString().contains(":")){
        core3choose = widget.needDetail.coreNeedThree.toString().split(":")[1]+",";
      }
      oldCoreNeedThreeRemark = widget.needDetail.coreNeedThreeRemark;
      coreController3.text = widget.needDetail.coreNeedThreeRemark;

      if(widget.needDetail.coreNeedOne.toString().split(":")[0]=="其他"){
        otherController.text = widget.needDetail.coreNeedOne.toString().split(":")[1];
      }
      if(widget.needDetail.coreNeedTwo.toString().split(":")[0]=="其他"){
        otherController.text = widget.needDetail.coreNeedTwo.toString().split(":")[1];
      }
      if(widget.needDetail.coreNeedThree.toString().split(":")[0]=="其他"){
        otherController.text = widget.needDetail.coreNeedThree.toString().split(":")[1];
      }

      if(widget.needDetail.coreNeedOne.toString().split(":")[0]=="定金"){
        dingJinController.text = widget.needDetail.coreNeedOne.toString().split(":")[1];
      }
      if(widget.needDetail.coreNeedTwo.toString().split(":")[0]=="定金"){
        dingJinController.text = widget.needDetail.coreNeedTwo.toString().split(":")[1];
      }
      if(widget.needDetail.coreNeedThree.toString().split(":")[0]=="定金"){
        dingJinController.text = widget.needDetail.coreNeedThree.toString().split(":")[1];
      }

      if(widget.needDetail.coreNeedOne.toString().split(":")[0]=="首付"){
        shouFuController.text = widget.needDetail.coreNeedOne.toString().split(":")[1];
      }
      if(widget.needDetail.coreNeedTwo.toString().split(":")[0]=="首付"){
        shouFuController.text = widget.needDetail.coreNeedTwo.toString().split(":")[1];
      }
      if(widget.needDetail.coreNeedThree.toString().split(":")[0]=="首付"){
        shouFuController.text = widget.needDetail.coreNeedThree.toString().split(":")[1];
      }

    }else{
      oldCoreNeedOne = "new";
      oldCoreNeedTwo = "new";
      oldCoreNeedThree = "new";
    }
  }

  @override
  void dispose(){
    mapController.dispose();
    otherController.dispose();
    dingJinController.dispose();
    shouFuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
            child:Container(
              // 背景
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image:AssetImage('images/circle.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          // 导航栏
                          Padding(
                              padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // 首页和标题
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 28,
                                          padding: EdgeInsets.only(top: 3),
                                          child: Image(image: AssetImage('images/back.png'),),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(widget.userName+"的"+widget.mainNeed+"需求",style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),),
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ),

                          // 核心需求1
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '核心需求：'+coreList[0].reqName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                              coreList[0].reqName == "其他"?
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: otherController,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore1OtherChanged,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                                  :
                              coreList[0].reqName == "定金"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text('最低定金数额',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                      // height: 50,
                                      width:100,
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: dingJinController,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: _onCore1DingJinChanged,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0E7AE6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        decoration: InputDecoration(
                                          hintText:'-',
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 5),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              coreList[0].reqName == "首付" || coreList[0].reqName == "押金"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?'最低首付数额':"最低押金数额",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                      // height: 50,
                                      width:100,
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: shouFuController,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: _onCore1ShouFuChanged,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0E7AE6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        decoration: InputDecoration(
                                          hintText:'-',
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              coreList[0].reqName != "其他" && coreList[0].reqName != "定金" && coreList[0].reqName != "首付" && coreList[0].reqName != "押金"&& oldCoreNeedOne=="old"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top:10,bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:42,
                                      child: Text(
                                        '已选：',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.needDetail.coreNeedOne.toString().split(":")[1],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5580EB),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          oldCoreNeedOne="new";
                                        });
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
                              )
                                  :
                              coreList[0].reqName != "其他" && coreList[0].reqName != "定金" && coreList[0].reqName != "首付" && coreList[0].reqName != "押金"&& oldCoreNeedOne=="new"?
                              Container(
                                  width: 335,
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > coreList[0].maxSelect) {
                                          return "选择不可多于"+coreList[0].maxSelect.toString()+"项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  options:  ChipsChoiceOption.listFrom(
                                                      source: coreList[0].reqOptions.split(','),
                                                      // 存储形式
                                                      value:(index,item)=>item,
                                                      // 展示形式
                                                      label: (index,item)=>item
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    core1choose="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      core1choose+=item+',';
                                                      //print(core1choose);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  itemConfig: ChipsChoiceItemConfig(
                                                    selectedColor: Color(0xFF5580EB),
                                                    selectedBrightness: Brightness.dark,
                                                    unselectedColor: Color(0xFF5580EB),
                                                    unselectedBorderOpacity: .3,
                                                  ),
                                                  isWrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/'+coreList[0].maxSelect.toString()+' 可选',
                                                    style: TextStyle(
                                                        color: state.hasError
                                                            ? Colors.redAccent
                                                            : Colors.green
                                                    ),
                                                  )
                                              )
                                            ]);}
                                  )
                              )
                              :Container(width: 1,),
                              // 对核心需求的描述
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '对核心需求-'+coreList[0].reqName+'的描述：',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: coreController1,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore1Changed,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // 核心需求2
                          coreList.length>1?
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '核心需求：'+coreList[1].reqName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                              coreList[1].reqName == "其他"?
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: otherController,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore2OtherChanged,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                                  :
                              coreList[1].reqName == "定金"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text('最低定金数额',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                      // height: 50,
                                      width:100,
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: dingJinController,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: _onCore2DingJinChanged,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0E7AE6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        decoration: InputDecoration(
                                          hintText:'-',
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 5),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              coreList[1].reqName == "首付" || coreList[1].reqName == "押金"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?'最低首付数额':"最低押金数额",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                      // height: 50,
                                      width:100,
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: shouFuController,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: _onCore2ShouFuChanged,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0E7AE6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        decoration: InputDecoration(
                                          hintText:'-',
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              coreList[1].reqName != "其他" && coreList[1].reqName != "定金" &&coreList[1].reqName != "首付" && coreList[1].reqName != "押金"&& oldCoreNeedTwo=="old"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top:10,bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 42,
                                      child: Text(
                                        '已选：',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                        child:Text(
                                          widget.needDetail.coreNeedTwo.toString().split(":")[1],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF5580EB),
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          oldCoreNeedTwo="new";
                                        });
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
                              )
                                  :coreList[1].reqName != "其他" && coreList[1].reqName != "定金" &&coreList[1].reqName != "首付" && coreList[1].reqName != "押金"&&  oldCoreNeedTwo=="new"?
                              Container(
                                  width: 335,
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > coreList[1].maxSelect) {
                                          return "选择不可多于"+coreList[1].maxSelect.toString()+"项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  options:  ChipsChoiceOption.listFrom(
                                                      source: coreList[1].reqOptions.split(','),
                                                      // 存储形式
                                                      value:(index,item)=>item,
                                                      // 展示形式
                                                      label: (index,item)=>item
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    core2choose="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      core2choose+=item+',';
                                                      //print(core2choose);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  itemConfig: ChipsChoiceItemConfig(
                                                    selectedColor: Color(0xFF5580EB),
                                                    selectedBrightness: Brightness.dark,
                                                    unselectedColor: Color(0xFF5580EB),
                                                    unselectedBorderOpacity: .3,
                                                  ),
                                                  isWrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/'+coreList[1].maxSelect.toString()+' 可选',
                                                    style: TextStyle(
                                                        color: state.hasError
                                                            ? Colors.redAccent
                                                            : Colors.green
                                                    ),
                                                  )
                                              )
                                            ]);}
                                  )
                              )
                                  :
                                  Container(width: 1,),
                              // 对核心需求的描述
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '对核心需求-'+coreList[1].reqName+'的描述：',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: coreController2,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore2Changed,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Container(width: 1,),

                          // 核心需求3
                          coreList.length>2?
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '核心需求：'+coreList[2].reqName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                              coreList[2].reqName == "其他"?
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: otherController,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore3OtherChanged,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                                  :
                              coreList[2].reqName == "定金"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text('最低定金数额',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                      // height: 50,
                                      width:100,
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: dingJinController,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: _onCore3DingJinChanged,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0E7AE6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        decoration: InputDecoration(
                                          hintText:'-',
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 5),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              coreList[2].reqName == "首付" || coreList[2].reqName == "押金"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?'最低首付数额':"最低押金数额",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                      // height: 50,
                                      width:100,
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6))),
                                        color: Colors.white,
                                      ),
                                      child: TextField(
                                        controller: shouFuController,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: _onCore3ShouFuChanged,
                                        maxLines: null,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0E7AE6),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        decoration: InputDecoration(
                                          hintText:'-',
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text(
                                        widget.mainNeed.toString().substring(0,2)=="出售"?"万":"元",
                                        style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              coreList[2].reqName != "其他" && coreList[2].reqName != "定金"&& coreList[2].reqName != "首付" && coreList[2].reqName != "押金" && oldCoreNeedThree=="old"?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top:10,bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:42,
                                      child: Text(
                                        '已选：',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                        child:Text(
                                          widget.needDetail.coreNeedThree.toString().split(":")[1],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF5580EB),
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          oldCoreNeedThree="new";
                                        });
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
                              )
                                  :coreList[2].reqName != "其他" && coreList[2].reqName != "定金"&& coreList[2].reqName != "首付" && coreList[2].reqName != "押金" && oldCoreNeedThree=="new"?
                              Container(
                                  width: 335,
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > coreList[2].maxSelect) {
                                          return "选择不可多于"+coreList[2].maxSelect.toString()+"项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  options:  ChipsChoiceOption.listFrom(
                                                      source: coreList[2].reqOptions.split(','),
                                                      // 存储形式
                                                      value:(index,item)=>item,
                                                      // 展示形式
                                                      label: (index,item)=>item
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    core3choose="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      core3choose+=item+',';
                                                      //print(core3choose);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  itemConfig: ChipsChoiceItemConfig(
                                                    selectedColor: Color(0xFF5580EB),
                                                    selectedBrightness: Brightness.dark,
                                                    unselectedColor: Color(0xFF5580EB),
                                                    unselectedBorderOpacity: .3,
                                                  ),
                                                  isWrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/'+coreList[2].maxSelect.toString()+' 可选',
                                                    style: TextStyle(
                                                        color: state.hasError
                                                            ? Colors.redAccent
                                                            : Colors.green
                                                    ),
                                                  )
                                              )
                                            ]);}
                                  )
                              )
                                  :Container(width: 1,),
                              // 对核心需求的描述
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '对核心需求-'+coreList[2].reqName+'的描述：',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: coreController3,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore3Changed,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Container(width: 1,),

                          // 非核心需求标题

                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '非核心需求：',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),

                          // 非核心需求
                          Column(
                            children: noncore,
                          ),

                          // 综合描述
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '综合描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: mapController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onMapChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写客户需求的综合描述，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 下一步
                          GestureDetector(
                            onTap: ()async{

                              if(_otherNeeds.dingJin==null) {_otherNeeds.dingJin = "无要求";}
                              if(_otherNeeds.shouFu==null){_otherNeeds.shouFu = "无要求";}
                              if(_otherNeeds.zhouQi==null){_otherNeeds.zhouQi = "无要求";}
                              if(_otherNeeds.buyWay==null){_otherNeeds.buyWay = "无要求";}
                              if(_otherNeeds.other==null){_otherNeeds.other = "无要求";}

                              otherChooses=sellOtherNeedsToJson(_otherNeeds);
                              _onRefresh();

                              var addResult = await UpdateCustomerNeedDao.updateCustomerNeed(
                                widget.needDetail.id.toString(),
                                widget.cid.toString(),
                                widget.mainNeed,
                                widget.needReason,
                                coreList[0].reqName=="其他"? (coreList[0].reqName+":"+otherController.text??"无要求")
                                    :coreList[0].reqName=="定金"&& widget.mainNeed.toString().substring(0,2)=="出租"? (coreList[0].reqName+":"+(dingJinController.text??"-")+"元")
                                    :coreList[0].reqName=="定金"&& widget.mainNeed.toString().substring(0,2)=="出售"? (coreList[0].reqName+":"+(dingJinController.text??"-")+"万")
                                    :coreList[0].reqName=="首付"? (coreList[0].reqName+":"+(shouFuController.text??"-")+"万")
                                    :coreList[0].reqName=="押金"? (coreList[0].reqName+":"+(shouFuController.text??"-")+"元")
                                    :(coreList[0].reqName+":"+core1choose.substring(0,core1choose.lastIndexOf(','))),
                                coreController1.text,
                                coreList.length<2?"暂无第二核心需求"
                                    :coreList.length>1&&coreList[1].reqName=="其他"?(coreList[1].reqName+":"+otherController.text??"无要求")
                                    :coreList.length>1&&coreList[1].reqName=="定金"&& widget.mainNeed.toString().substring(0,2)=="出售"?(coreList[1].reqName+":"+(dingJinController.text??"-")+"万")
                                    :coreList.length>1&&coreList[1].reqName=="定金"&& widget.mainNeed.toString().substring(0,2)=="出租"?(coreList[1].reqName+":"+(dingJinController.text??"-")+"元")
                                    :coreList.length>1&&coreList[1].reqName=="首付"?(coreList[1].reqName+":"+(shouFuController.text??"-")+"万")
                                    :coreList.length>1&&coreList[1].reqName=="押金"?(coreList[1].reqName+":"+(shouFuController.text??"-")+"元")
                                    :(coreList[1].reqName+":"+core2choose.substring(0,core2choose.lastIndexOf(','))),
                                coreController2.text,
                                coreList.length<3?"暂无第三核心需求"
                                    :coreList.length>2&&coreList[2].reqName=="其他"?(coreList[2].reqName+":"+otherController.text??"无要求")
                                    :coreList.length>2&&coreList[2].reqName=="定金"&& widget.mainNeed.toString().substring(0,2)=="出售"?(coreList[2].reqName+":"+(dingJinController.text??"-")+"万")
                                    :coreList.length>2&&coreList[2].reqName=="定金"&& widget.mainNeed.toString().substring(0,2)=="出租"?(coreList[2].reqName+":"+(dingJinController.text??"-")+"元")
                                    :coreList.length>2&&coreList[2].reqName=="首付"?(coreList[2].reqName+":"+(shouFuController.text??"-")+"万")
                                    :coreList.length>2&&coreList[2].reqName=="押金"?(coreList[2].reqName+":"+(shouFuController.text??"-")+"元")
                                    :(coreList[2].reqName+":"+core3choose.substring(0,core3choose.lastIndexOf(','))),
                                coreController3.text,
                                otherChooses+","+widget.otherMsg,
                                mapController.text??"-",
                                "2",
                              );
                              if (addResult.code == 200) {
                                var getItem = await GetUserDetailBByIDDao.getUserDetailBByID(widget.cid.toString());
                                if(getItem.code == 200){
                                  _onRefresh();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                                    item:getItem.data[0],
                                    tabIndex: 0,
                                  )));
                                }else {
                                  _onRefresh();
                                  _onOverLoadPressed(context);
                                }
                              } else {
                                _onRefresh();
                                _onOverLoadPressed(context);
                              }

                              // }
                              // else{
                              //   // 必填信息不完整的弹窗
                              //   _onMsgPressed(context);
                              // }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration:
                                // phoneBool == true &&
                                //     userNameBool == true && _starIndex != 0?
                                BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF5580EB)
                                ),
                                //     :
                                // BoxDecoration(
                                //     border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                //     borderRadius: BorderRadius.circular(8),
                                //     color: Color(0xFF93C0FB)
                                // ),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text('完成',style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                )
                            ),
                          )
                        ]
                    )
                  ],
                )
            )
        )
    );
  }

  _onOverLoadPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "请检查网络后重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
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

  _CheckSelection(itemName,selOpts){
    switch(itemName){
      case "付款方式":
        _otherNeeds.buyWay=selOpts;
        break;
      case "成交周期":
        _otherNeeds.zhouQi=selOpts;
        break;
      default:
        break;
    }
  }

  List<String> _returnStateList(reqName){
    switch(reqName){
      case "付款方式":
        return waySel;
      case "成交周期":
        return periodSel;
      default:
        return defaultSel;
    }
  }

  _onMapChanged(String text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
      });
    }
  }
  _onCore1Changed(String text){
    if(text != null){
      setState(() {
        core1Bool = core1Reg.hasMatch(coreController1.text);
      });
    }
  }
  _onCore2Changed(String text){
    if(text != null){
      setState(() {
        core2Bool = core2Reg.hasMatch(coreController2.text);
      });
    }
  }
  _onCore3Changed(String text){
    if(text != null){
      setState(() {
        core3Bool = core3Reg.hasMatch(coreController3.text);
      });
    }
  }


  _onDingJinChanged(String text){
    if(text != null){
      setState(() {
        dingJinBool = dingJinReg.hasMatch(dingJinController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?_otherNeeds.dingJin=dingJinController.text+"万":_otherNeeds.dingJin=dingJinController.text+"元";
      });
    }
  }
  _onCore1DingJinChanged(String text){
    if(text != null){
      setState(() {
        dingJinBool = dingJinReg.hasMatch(dingJinController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?core1choose=dingJinController.text+"万":core1choose=dingJinController.text+"元";
      });
    }
  }
  _onCore2DingJinChanged(String text){
    if(text != null){
      setState(() {
        dingJinBool = dingJinReg.hasMatch(dingJinController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?core2choose=dingJinController.text+"万":core2choose=dingJinController.text+"元";
      });
    }
  }
  _onCore3DingJinChanged(String text){
    if(text != null){
      setState(() {
        dingJinBool = dingJinReg.hasMatch(dingJinController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?core3choose=dingJinController.text+"万":core3choose=dingJinController.text+"元";
      });
    }
  }

  _onShouFuChanged(String text){
    if(text != null){
      setState(() {
        shouFuBool = shouFuReg.hasMatch(shouFuController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?_otherNeeds.shouFu=shouFuController.text+"万":_otherNeeds.shouFu=shouFuController.text+"元";
      });
    }
  }
  _onCore1ShouFuChanged(String text){
    if(text != null){
      setState(() {
        shouFuBool = shouFuReg.hasMatch(shouFuController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?core1choose=shouFuController.text+"万":core1choose=shouFuController.text+"元";
      });
    }
  }
  _onCore2ShouFuChanged(String text){
    if(text != null){
      setState(() {
        shouFuBool = shouFuReg.hasMatch(shouFuController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?core2choose=shouFuController.text+"万":core2choose=shouFuController.text+"元";
      });
    }
  }
  _onCore3ShouFuChanged(String text){
    if(text != null){
      setState(() {
        shouFuBool = shouFuReg.hasMatch(shouFuController.text);
        widget.mainNeed.toString().substring(0,2)=="出售"?core3choose=shouFuController.text+"万":core3choose=shouFuController.text+"元";
      });
    }
  }

  _onOtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        _otherNeeds.other=otherController.text==null?"无要求":otherController.text;
      });
    }
  }
  _onCore1OtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        core1choose=otherController.text??"无要求";
      });
    }
  }
  _onCore2OtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        core2choose=otherController.text??"无要求";
      });
    }
  }
  _onCore3OtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        core3choose=otherController.text??"无要求";
      });
    }
  }
}



//所有需求类
class BuyRequirement {
  BuyRequirement(
      this.reqName,
      this.reqOptions,
      this.maxSelect
      );

  String reqName;
  String reqOptions;
  int maxSelect;
}