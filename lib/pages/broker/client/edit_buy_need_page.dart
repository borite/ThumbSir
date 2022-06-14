import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'edit_buy_need_detail_page.dart';

class EditBuyNeedPage extends StatefulWidget {
  final cid;
  final mainNeed;
  final userName;
  final needDetail;

  EditBuyNeedPage({Key? key,
    this.cid,this.mainNeed,this.userName,this.needDetail
  }):super(key:key);
  @override
  _EditBuyNeedPageState createState() => _EditBuyNeedPageState();
}

class _EditBuyNeedPageState extends State<EditBuyNeedPage> {
  dynamic items;
  bool _loading = false;
  // 核心需求
  dynamic CoreNeedName;
  dynamic WidgetCoreNeedOne;

  ScrollController _dealScrollController = ScrollController();
  ScrollController _needScrollController = ScrollController();
  final TextEditingController agencyMemberScrollController = TextEditingController();
  String agencyPhoneNum = "-";
  late RegExp agencyPhoneReg;
  bool agencyPhoneBool = false;
  final TextEditingController desideMemberController = TextEditingController();
  String desidePhoneNum = "-";
  late RegExp desidePhoneReg;
  bool desidePhoneBool = false;
  final TextEditingController firstPriceNumController = TextEditingController();
  int firstPriceNum=1;
  late RegExp firstPriceNumReg;
  bool firstPriceNumBool = false;
  final TextEditingController totalPriceNumController = TextEditingController();
  int totalPriceNum=1;
  late RegExp totalPriceNumReg;
  bool totalPriceNumBool = false;
  final TextEditingController yaPriceNumController = TextEditingController();
  int yaPriceNum=1;
  late RegExp yaPriceNumReg;
  bool yaPriceNumBool = false;
  final TextEditingController fuPriceNumController = TextEditingController();
  int fuPriceNum=1;
  late RegExp fuPriceNumReg;
  bool fuPriceNumBool = false;
  final TextEditingController agencyNameController = TextEditingController();
  String agencyName = "-";
  late RegExp agencyNameReg;
  bool agencyNameBool = false;
  final TextEditingController desideNameController = TextEditingController();
  String desideName = "-";
  late RegExp desideNameReg;
  bool desideNameBool = false;
  final TextEditingController msgController=TextEditingController();
  late RegExp msgReg;
  bool msgBool = false;
  String comeMinCount="";
  List<String> tags = [];
  List idList = [];
  String selectTaskIDs="";
  int itemLength = 0;
  List missionContent=[];
  List<String> tasks = [];

  List<DealInfo> deal=[];
  List<NeedInfo> need=[];
  List<FamilyMember> member=[];

  dynamic _desideRadioGroupA = 0;
  dynamic _buyWayRadioGroupA = 0;
  dynamic _agencyRadioGroupA = 0;

  _handleAgencyRadioValueChanged(int value) {
    setState(() {
      _agencyRadioGroupA = value;
    });
  }

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  _needsSplit() {
    print(widget.needDetail);
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
    String coreNeedsArr = "";
    if (widget.needDetail.otherNeed != null) {
      var iOtherNeed = widget.needDetail.otherNeed.toString();
      //增加分隔符|
      iOtherNeed = iOtherNeed.replaceAll('}', '}|');
      //通过分隔符分割字符串，0-为非核心需求，1-为决策之类的信息
      _otherNeedArr = iOtherNeed.split('|');

      //把决策类的信息再次用逗号分割
      noOtherNeeds = _otherNeedArr[1].split(',');

      if (widget.needDetail.otherNeed != null) {
        var iOtherNeed = widget.needDetail.otherNeed.toString();
        //增加分隔符|
        iOtherNeed = iOtherNeed.replaceAll('}', '}|');
        //通过分隔符分割字符串，0-为非核心需求，1-为决策之类的信息
        _otherNeedArr = iOtherNeed.split('|');

        //把决策类的信息再次用逗号分割
        noOtherNeeds = _otherNeedArr[1].split(',');

        print(noOtherNeeds);

        //定义相关数据变量
        //是否为决策人
        IsJueCe = noOtherNeeds[1].split(':')[1];
        //决策人姓名
        JueCeName = noOtherNeeds[2].split(':')[1];
        //决策人手机号
        JueCePhone = noOtherNeeds[3].split(':')[1];
        //是否有代理人
        HasDaiLi = noOtherNeeds[4].split(':')[1];
        //代理人姓名
        DaiLiName = noOtherNeeds[5].split(':')[1];
        //代理人手机号
        DaiLiPhone = noOtherNeeds[6].split(':')[1];
        //付款方式
        PayWay = noOtherNeeds[7].split(':')[1];
        //首付预算
        ShouFu = noOtherNeeds[8].split(':')[1];
        //总价预算
        ZongJia = noOtherNeeds[9].split(':')[1];
        //意向小区
        YxXiaoQu = noOtherNeeds[10].split(':')[1];

        _otherNeesArr =
            _reGroupOtherNeed(_otherNeedArr[0], coreNeedsArr, widget.mainNeed);
        _otherList = _otherNeesArr.toString().split(",");

        // 购房原因
        if(widget.needDetail.needReason!=null){comeMinCount = widget.needDetail.needReason;}
        // 是否为决策人
        if(IsJueCe=="否"){
          _desideRadioGroupA=1;
        }else{_desideRadioGroupA=0;}
        // 决策人姓名
        desideNameController.text=JueCeName;
        desideName=JueCeName;
        // 决策人手机号
        desideMemberController.text=JueCePhone;
        desidePhoneNum=JueCePhone;
        // 是否有代理人
        if(HasDaiLi=="是"){
          _agencyRadioGroupA=1;
        }else{_agencyRadioGroupA=0;}
        // 代理人姓名
        agencyNameController.text=DaiLiName;
        agencyName=DaiLiName;
        // 代理人手机号
        agencyMemberScrollController.text=DaiLiPhone;
        agencyPhoneNum=DaiLiPhone;
        // 付款方式
        if(widget.mainNeed.toString().substring(0,2)=="购买"){
          if(PayWay=="贷款"){_buyWayRadioGroupA = 0;}else{_buyWayRadioGroupA = 1;}
        }else{
          // 租赁
          yaPriceNumController.text=PayWay.substring(1,2);
          yaPriceNum=int.parse(PayWay.substring(1,2));
          fuPriceNumController.text=PayWay.substring(3,);
          fuPriceNum=int.parse(PayWay.substring(3,));
        }
        // 首付与房租预算
        if(widget.mainNeed.toString().substring(0,2)=="购买"){
          firstPriceNumController.text=ShouFu.split("万").first;
          firstPriceNum=int.parse(ShouFu.split("万").first);
        }else{
          firstPriceNumController.text=ShouFu.split("元").first;
          firstPriceNum=int.parse(ShouFu.split("元").first);
        }
        // 总价与押金预算
        if(widget.mainNeed.toString().substring(0,2)=="购买"){
          totalPriceNumController.text=ZongJia.split("万").first;
          totalPriceNum=int.parse(ZongJia.split("万").first);
        }else {
          totalPriceNumController.text = ZongJia.split("元").first;
          totalPriceNum = int.parse(ZongJia.split("元").first);
        }
        // 地址
        msgController.text=YxXiaoQu;
        // 核心需求名称
        if(widget.needDetail.coreNeedOne!=null){
          CoreNeedName=widget.needDetail.coreNeedOne.split(':')[0].toString();
          if(widget.needDetail.coreNeedTwo!=null&&widget.needDetail.coreNeedTwo!="暂无第二核心需求" ){
            CoreNeedName=CoreNeedName+"，"+widget.needDetail.coreNeedTwo.split(':')[0].toString();
            if(widget.needDetail.coreNeedThree!=null&&widget.needDetail.coreNeedThree!="暂无第三核心需求" ){
              CoreNeedName=CoreNeedName+"，"+widget.needDetail.coreNeedThree.split(':')[0].toString();
            }
          }
        }
        WidgetCoreNeedOne=widget.needDetail.coreNeedOne;
      } else {
        IsJueCe = "未完善";
        //决策人姓名
        JueCeName = "未完善";
        //决策人手机号
        JueCePhone = "未完善";
        //是否有代理人
        HasDaiLi = "未完善";
        //代理人姓名
        DaiLiName = "未完善";
        //代理人手机号
        DaiLiPhone = "未完善";
        //付款方式
        PayWay = "未完善";
        //首付预算
        ShouFu = "未完善";
        //总价预算
        ZongJia = "未完善";
        //意向小区
        YxXiaoQu = "未完善";
        // _otherNeesArr;
      }
    }
  }

  @override
  void initState() {
    agencyNameReg = TextReg;
    desideNameReg = TextReg;
    agencyPhoneReg = telPhoneReg;
    desidePhoneReg = telPhoneReg;
    totalPriceNumReg = TextReg;
    msgReg = FeedBackReg;
    firstPriceNumReg = TextReg;
    yaPriceNumReg = TextReg;
    fuPriceNumReg = TextReg;
    _getUserInfo();
    tasks=["面积","居室","朝向","电梯","楼层","楼龄","装修","交通","学区","医院","银行","公园","商场","物业","税费","特殊要求","其他"];
    _needsSplit();

    super.initState();

  }

  @override
  void dispose(){
    _dealScrollController.dispose();
    _needScrollController.dispose();
    msgController.dispose();
    agencyNameController.dispose();
    agencyMemberScrollController.dispose();
    desideMemberController.dispose();
    desideNameController.dispose();
    firstPriceNumController.dispose();
    totalPriceNumController.dispose();
    yaPriceNumController.dispose();
    fuPriceNumController.dispose();
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
                                        child: Text(
                                          // '张先生的购买住宅需求',
                                          widget.userName+"的"+widget.mainNeed+"需求",
                                          style: TextStyle(
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

                          // 购房原因
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              widget.mainNeed.substring(0,2) +'原因：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          widget.needDetail.needReason !=null?
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "已选："+widget.needDetail.needReason+"（如果不转动滚轮则保留此选项）",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ):Container(width: 1,),
                          Container(
                            width: 200,
                            height: 120,
                            margin: EdgeInsets.only(top: 18),
                            child: WheelChooser(
                              onValueChanged: (s){
                                setState(() {
                                  comeMinCount = s;
                                });
                              },

                              // 原因
                              datas:
                              widget.mainNeed == "购买住宅"?
                              ["刚需首套","改善", "婚房", "上学", "投资","养老","办公","其他"]
                              :widget.mainNeed == "购买商铺"?
                              ["投资","办公","其他"]
                              :widget.mainNeed == "租赁商铺"?
                              ["办公","其他"]
                              :widget.mainNeed == "购买车位"?
                              ["投资","自用","其他"]
                              :widget.mainNeed == "租赁车位"?
                              ["自用","其他"]
                              :widget.mainNeed == "购买公寓"?
                              ["自住", "投资","办公","其他"]
                              :widget.mainNeed == "租赁公寓"?
                              ["自住","办公","其他"]
                              :["上班","陪读", "换房周转", "办公","长辈暂住", "上学","其他"],
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

                          // 是否为购房决策人
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '是否为'+widget.mainNeed.substring(0,2)+'决策人：',
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
                            width: 335,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _desideRadioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _desideRadioGroupA = value;
                                    });
                                  },
                                  title: Text('是'),
                                  selected: _desideRadioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _desideRadioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _desideRadioGroupA = value;
                                    });
                                  },
                                  title: Text('否'),
                                  selected: _desideRadioGroupA == 1,
                                ),
                              ],
                            ),
                          ),

                          _desideRadioGroupA == 1?
                          Column(
                            children: [
                              // 决策人姓名
                              Container(
                                width: 335,
                                child: Text(
                                  '决策人姓名（选填）：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "请输入决策人姓名",
                                tipText: "请输入决策人姓名",
                                errorTipText: "请输入决策人姓名",
                                rightText: "请输入决策人姓名",
                                controller: desideNameController,
                                inputType: TextInputType.text,
                                reg: desideNameReg,
                                password: false,
                                onChanged: (text){
                                  setState(() {
                                    desideName = text;
                                    desideNameBool = desideNameReg.hasMatch(desideName);
                                  });
                                },
                              ),
                              // 决策人手机号
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  '决策人手机号码：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "手机号码",
                                tipText: "请输入决策人的手机号码",
                                errorTipText: "请输入格式正确的手机号码",
                                rightText: "手机号码格式正确",
                                controller: desideMemberController,
                                inputType: TextInputType.phone,
                                reg: desidePhoneReg,
                                password: false,
                                onChanged: (text){
                                  setState(() {
                                    desidePhoneNum = text;
                                    desidePhoneBool = desidePhoneReg.hasMatch(desidePhoneNum);
                                  });
                                },
                              ),
                            ],
                          )
                          :Container(width: 1,),

                          // 是否有代理人
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '是否有代理人：',
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
                            width: 335,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _agencyRadioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _agencyRadioGroupA = value;
                                    });
                                  },
                                  title: Text('否'),
                                  selected: _agencyRadioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _agencyRadioGroupA,
                                  onChanged:(value){
                                    setState(() {
                                      _agencyRadioGroupA = value;
                                    });
                                  },
                                  title: Text('是'),
                                  selected: _agencyRadioGroupA == 1,
                                ),
                              ],
                            ),
                          ),

                          _agencyRadioGroupA == 1?
                          Column(
                            children: [
                              // 代理人姓名
                              Container(
                                width: 335,
                                child: Text(
                                  '代理人姓名（选填）：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "请输入代理人姓名",
                                tipText: "请输入代理人姓名",
                                errorTipText: "请输入代理人姓名",
                                rightText: "请输入代理人姓名",
                                controller: agencyNameController,
                                inputType: TextInputType.text,
                                reg: agencyNameReg,
                                password: false,
                                onChanged: (text){
                                  setState(() {
                                    agencyName = text;
                                    agencyNameBool = agencyNameReg.hasMatch(agencyName);
                                  });
                                },
                              ),
                              // 代理人手机号
                              Container(
                                width: 335,
                                child: Text(
                                  '代理人手机号码（选填）：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Input(
                                hintText: "手机号码",
                                tipText: "请输入代理人的手机号码",
                                errorTipText: "请输入格式正确的手机号码",
                                rightText: "手机号码格式正确",
                                controller: agencyNameController,
                                inputType: TextInputType.phone,
                                reg: agencyPhoneReg,
                                password: false,
                                onChanged: (text){
                                  setState(() {
                                    agencyPhoneNum = text;
                                    agencyPhoneBool = agencyPhoneReg.hasMatch(agencyPhoneNum);
                                  });
                                },
                              ),
                            ],
                          )
                              :Container(width: 1,),


                          // 付款方式
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '付款方式：',
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
                          widget.mainNeed.substring(0,2)=="购买"?
                          Container(
                            width: 335,
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _buyWayRadioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _buyWayRadioGroupA = value;
                                    });
                                  },
                                  title: Text('贷款'),
                                  selected: _buyWayRadioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _buyWayRadioGroupA,
                                  onChanged: (value){
                                    setState(() {
                                      _buyWayRadioGroupA = value;
                                    });
                                  },
                                  title: Text('全款'),
                                  selected: _buyWayRadioGroupA == 1,
                                ),
                              ],
                            ),
                          )
                          :
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('押',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onYaPriceCountPressed(context);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      yaPriceNum.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20,left: 20),
                                  child: Text('付',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _onFuPriceCountPressed(context);
                                  },
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                    ),
                                    child: Text(
                                      fuPriceNum.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5580EB),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 首付预算+总价预算或月租金预算+押金预算
                          widget.mainNeed.substring(0,2)=="购买"?
                          Column(
                            children: [
                              // 首付预算
                              _buyWayRadioGroupA == 0?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('首付预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onFirstPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          firstPriceNum.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("万",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              ):Container(width: 1,),
                              // 总价预算
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('总价预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onTotalPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          totalPriceNum.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("万",style: TextStyle(
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
                          :
                          Column(
                            children: [
                              // 月租金预算
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('月租金预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onFirstPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          firstPriceNum.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("元/月",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              // 押金预算
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text('押金预算',style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _onTotalPriceCountPressed(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: Text(
                                          totalPriceNum.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("元",style: TextStyle(
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
                          ),



                          // 意向区域和小区
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '意向区域和小区：',
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
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: msgController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onMsgChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写客户的意向区域或小区，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),


                          WidgetCoreNeedOne!=null?
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '已选的核心需求：',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF333333),
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          CoreNeedName,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF5580EB),
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        editNeedPressed(context);
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
                          // 选择核心需求
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '选择核心需求(1~3项)',
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
                                  // title: '可选的任务名称（ 多选 ）',
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value==null) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > 3) {
                                          return "选择不可多于3项";
                                        }
                                        return null;
                                      },
                                      builder: (dynamic state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: tasks,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    items="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      items+=item+',';
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  choiceStyle: const C2ChoiceStyle(
                                                    color: Color(0xFF5580EB),
                                                    borderOpacity: .3,
                                                  ),
                                                  choiceActiveStyle: const C2ChoiceStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    backgroundColor: Color(0xFF5580EB),
                                                    borderOpacity: .3,
                                                  ),
                                                  wrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/3 可选',
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
                            ],
                          ),

                          // 下一步
                          GestureDetector(
                            onTap: ()async {
                              if ((WidgetCoreNeedOne!=null)||(WidgetCoreNeedOne==null&&items != null&& items!="")) {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (
                                    context) =>
                                    EditBuyNeedDetailPage(
                                        isNew:WidgetCoreNeedOne!=null?"old":"new",
                                        cid: widget.cid,
                                        needDetail:widget.needDetail,
                                        mainNeed: widget.mainNeed,
                                        needReason: comeMinCount,
                                        userName: widget.userName,
                                        coreNeedNames: WidgetCoreNeedOne!=null?CoreNeedName:items,
                                        otherMsg:
                                        // 是否为购房决策人
                                        '是否为' +
                                            widget.mainNeed.substring(0, 2) +
                                            '决策人:' + (_desideRadioGroupA == 0
                                            ? "是"
                                            : "否") + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '决策人姓名:' + desideName + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '决策人手机号:' + desidePhoneNum + ","
                                            // 是否有代理人
                                            + '是否有' +
                                            widget.mainNeed.substring(0, 2) +
                                            '代理人:' + (_agencyRadioGroupA == 0
                                            ? "否"
                                            : "是") + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '代理人姓名:' + agencyName + ","
                                            + widget.mainNeed.substring(0, 2) +
                                            '代理人手机号:' + agencyPhoneNum + ","
                                            // 付款方式
                                            + "付款方式:" +
                                            (widget.mainNeed.substring(0, 2) ==
                                                "购买" && _buyWayRadioGroupA == 0
                                                ? "贷款"
                                                : widget.mainNeed.substring(
                                                0, 2) == "购买" &&
                                                _buyWayRadioGroupA == 1
                                                ? "全款"
                                                : "押" + yaPriceNum.toString() +
                                                "付" + fuPriceNum.toString()) +
                                            ","
                                            // 首付预算/月租金预算
                                            +
                                            (widget.mainNeed.substring(0, 2) ==
                                                "购买"
                                                ? "首付预算:" +
                                                firstPriceNum.toString() + "万"
                                                : "月租金预算:" +
                                                firstPriceNum.toString() +
                                                "元/月") + ","
                                            // 总价预算/押金预算
                                            +
                                            (widget.mainNeed.substring(0, 2) ==
                                                "购买"
                                                ? "总价预算:" +
                                                totalPriceNum.toString() + "万"
                                                : "押金预算:" +
                                                totalPriceNum.toString() +
                                                "元/月") + ","
                                            // 意向区域或小区
                                            + "意向区域或小区:" + msgController.text

                                    )));
                              }
                              else{
                                _onMsgPressed(context);
                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration:(WidgetCoreNeedOne!=null)||(WidgetCoreNeedOne==null&&items != null&& items!="")?
                                BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF5580EB)
                                )
                                    :
                                BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF93C0FB)
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text('下一步：完善需求信息',style: TextStyle(
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

  // 输入首付弹窗
  _onFirstPriceCountPressed(context) {
    Alert(
      context: context,
      title: "请输入金额数字",
      content: Column(
        children: <Widget>[
          TextField(
            controller: firstPriceNumController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if(int.parse(firstPriceNumController.text) > 0){
              setState(() {
                firstPriceNum = int.parse(firstPriceNumController.text.toString());
              });
              Navigator.pop(context);
            }else{
              _onCountWrongPressed(context);
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
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
          width: 120,
        )
      ],
    ).show();
  }

  // 输入总价弹窗
  _onTotalPriceCountPressed(context) {
    Alert(
      context: context,
      title: "请输入金额数字",
      content: Column(
        children: <Widget>[
          TextField(
            controller: totalPriceNumController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if(int.parse(totalPriceNumController.text) > 0){
              setState(() {
                totalPriceNum = int.parse(totalPriceNumController.text.toString());
              });
              Navigator.pop(context);
            }else{
              _onCountWrongPressed(context);
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
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
          width: 120,
        )
      ],
    ).show();
  }

  // 押n弹窗
  _onYaPriceCountPressed(context) {
    Alert(
      context: context,
      title: "输入押金月份数",
      content: Column(
        children: <Widget>[
          TextField(
            controller: yaPriceNumController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if(int.parse(yaPriceNumController.text) > 0){
              setState(() {
                yaPriceNum = int.parse(yaPriceNumController.text.toString());
              });
              Navigator.pop(context);
            }else{
              _onCountWrongPressed(context);
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
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
          width: 120,
        )
      ],
    ).show();
  }

  // 付n弹窗
  _onFuPriceCountPressed(context) {
    Alert(
      context: context,
      title: "输入付款周期月份数",
      content: Column(
        children: <Widget>[
          TextField(
            controller: fuPriceNumController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if(int.parse(fuPriceNumController.text) > 0){
              setState(() {
                fuPriceNum = int.parse(fuPriceNumController.text.toString());
              });
              Navigator.pop(context);
            }else{
              _onCountWrongPressed(context);
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
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
          width: 120,
        )
      ],
    ).show();
  }

  // 数量不得小于1弹窗
  _onCountWrongPressed(context) {
    Alert(
      context: context,
      title: "数值不得小于1",
      desc: "请重试",
      buttons: [
        DialogButton(
          child: Text(
            "知道了",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show();
  }

  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }

  _onMsgChanged(String text){
    if(text != null){
      setState(() {
        msgBool = msgReg.hasMatch(msgController.text);
      });
    }
  }

  _onMsgPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "请至少选择1个核心需求",
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

  editNeedPressed(context) {
    Alert(
      type: AlertType.warning,
      context: context,
      title: "是否确认修改核心需求？",
      desc: "确认修改后将清空现有的所有需求，并重新填写选项和描述，请慎重选择",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            setState(() {
              WidgetCoreNeedOne=null;
            });
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "再想想",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
          width: 120,
        )
      ],
    ).show();
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


