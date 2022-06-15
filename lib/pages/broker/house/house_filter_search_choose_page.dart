import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/add_house_step2_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/house/house_list_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../dao/modi_house_price_dao.dart';
import '../../../dao/update_house_public_dao.dart';
import '../../../dao/update_house_urgent_level_dao.dart';

class HouseFilterSearchChoosePage extends StatefulWidget {
  final houseId;
  final houseDetail;
  HouseFilterSearchChoosePage({Key? key,
    this.houseId,this.houseDetail
  }):super(key:key);
  @override
  _HouseFilterSearchChoosePageState createState() => _HouseFilterSearchChoosePageState();
}

class _HouseFilterSearchChoosePageState extends State<HouseFilterSearchChoosePage> {
  final TextEditingController countController=TextEditingController();
  final TextEditingController areaController=TextEditingController();
  final TextEditingController roomController=TextEditingController();
  final TextEditingController sittingRoomController=TextEditingController();
  final TextEditingController kitchenController=TextEditingController();
  final TextEditingController toiletController=TextEditingController();
  final TextEditingController floorController=TextEditingController();
  final TextEditingController totalFloorController=TextEditingController();
  final TextEditingController houseAgeController=TextEditingController();
  final TextEditingController managementCompanyController=TextEditingController();
  final TextEditingController priceController=TextEditingController();
  final TextEditingController priceReasonController=TextEditingController();
  late String companyName;
  late RegExp companyReg;
  bool companyNameBool = false;
  final TextEditingController managementPriceController=TextEditingController();
  String levelMinCount = "着急";
  bool _loading = false;
  List levels=["着急","诚心","一般","下架"];

  int priceCount = 1;
  int areaCount = 1;
  int roomCount = 1;
  String address = "暂无";
  String tradeLevelCount = "着急";

  List<String> tags = [];
  List idList = [];

  String directionSelect="";
  String decorationSelect="";
  String elevatorSelect="";
  String taxSelect="";
  String managementSelect="";
  int itemLength = 0;
  List missionContent=[];

  List<String> direction = [];
  List<String> lift =[];
  List<String> finish = [];
  List<String> manager = [];
  List<String> tax = [];

  List<String> directionSel = [];
  List<String> liftSel =[];
  List<String> finishSel = [];
  List<String> managerSel = [];
  List<String> taxSel = [];

  List<DealInfo> deal=[];
  List<NeedInfo> need=[];
  List<FamilyMember> member=[];

  LoginResultData? userData;
  late String uInfo;

  var workValue = "所有";
  var typeValue = 0;
  var sortValue = "时间近";

  bool alreadyChoose = false;

  List<DropdownMenuItem> getWorkList(){
    List<DropdownMenuItem> workLists = [];
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: '所有',);
    workLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('出售'),value: '出售',);
    workLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('出租'),value: '出租',);
    workLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('我的'),value: '我的',);
    workLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('下架'),value: '下架',);
    workLists.add(ageList5);
    return workLists;
  }

  List<DropdownMenuItem> getTypeList(){
    List<DropdownMenuItem> typeLists = [];
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('所有'),value: 0,);
    typeLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('住宅'),value: 1,);
    typeLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('商铺'),value: 2,);
    typeLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('公寓'),value: 3,);
    typeLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('车位'),value: 4,);
    typeLists.add(ageList5);
    return typeLists;
  }

  List<DropdownMenuItem> getSortList(){
    List<DropdownMenuItem> sortLists = [];
    DropdownMenuItem ageList1 = new DropdownMenuItem(child: Text('时间近'),value: '时间近',);
    sortLists.add(ageList1);
    DropdownMenuItem ageList2 = new DropdownMenuItem(child: Text('时间远'),value: '时间远',);
    sortLists.add(ageList2);
    DropdownMenuItem ageList3 = new DropdownMenuItem(child: Text('带看量'),value: '带看量',);
    sortLists.add(ageList3);
    DropdownMenuItem ageList4 = new DropdownMenuItem(child: Text('总价升'),value: '总价升',);
    sortLists.add(ageList4);
    DropdownMenuItem ageList5 = new DropdownMenuItem(child: Text('总价降'),value: '总价降',);
    sortLists.add(ageList5);
    DropdownMenuItem ageList6 = new DropdownMenuItem(child: Text('单价升'),value: '单价升',);
    sortLists.add(ageList6);
    DropdownMenuItem ageList7 = new DropdownMenuItem(child: Text('单价降'),value: '单价降',);
    sortLists.add(ageList7);
    return sortLists;
  }
  var houseList = [];
  List<Widget> houseShowList = [];
  List<Widget> houses=[];
  var pageIndex=0;
  var customersResult;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  @override
  void initState() {
    print(widget.houseDetail);
    companyReg = TextReg;

    if(widget.houseDetail !=null){
      priceCount = int.parse(widget.houseDetail.housePrice.toString().split(".")[0].toString());
      priceController.text = widget.houseDetail.housePrice.toString().split(".")[0].toString();
      address = widget.houseDetail.houseCommunity+widget.houseDetail.houseAddress;
      tradeLevelCount = widget.houseDetail.tradeLevel;
      if(widget.houseDetail.houseBasicInfo.length>0){
        if(widget.houseDetail.houseBasicInfo[0].area!=null){
          areaController.text = widget.houseDetail.houseBasicInfo[0].area.toString();
        }
        if(widget.houseDetail.houseBasicInfo[0].floor!=null){
          floorController.text = widget.houseDetail.houseBasicInfo[0].floor.toString();
        }
        if(widget.houseDetail.houseBasicInfo[0].totalFloor!=null){
          totalFloorController.text = widget.houseDetail.houseBasicInfo[0].totalFloor.toString();
        }
        if(widget.houseDetail.houseBasicInfo[0].houseAge!=null){
          houseAgeController.text = widget.houseDetail.houseBasicInfo[0].houseAge.toString();
        }
        if(widget.houseDetail.houseBasicInfo[0].managementPrice!=null){
          managementPriceController.text = widget.houseDetail.houseBasicInfo[0].managementPrice.toString();
        }
        if(widget.houseDetail.houseBasicInfo[0].managementCompany.toString().contains("-")){
          managementCompanyController.text = widget.houseDetail.houseBasicInfo[0].managementCompany.toString().split("-")[0];
        }
        if(widget.houseDetail.houseBasicInfo[0].structure.toString().contains("-")){
          roomController.text = widget.houseDetail.houseBasicInfo[0].structure.toString().split("-")[0];
          sittingRoomController.text =widget.houseDetail.houseBasicInfo[0].structure.toString().split("-")[1];
          kitchenController.text =widget.houseDetail.houseBasicInfo[0].structure.toString().split("-")[2];
          toiletController.text = widget.houseDetail.houseBasicInfo[0].structure.toString().split("-")[3];
        }
        if(widget.houseDetail.houseBasicInfo[0].orientation.toString().contains(",")){
          directionSel=widget.houseDetail.houseBasicInfo[0].orientation.toString().split(',');
        }
        if(widget.houseDetail.houseBasicInfo[0].decoration.toString().contains(",")){
          finishSel=widget.houseDetail.houseBasicInfo[0].decoration.toString().split(',');
        }
        if(widget.houseDetail.houseBasicInfo[0].haveElevator.toString().contains(",")){
          liftSel=widget.houseDetail.houseBasicInfo[0].haveElevator.toString().split(',');
        }
        if(widget.houseDetail.houseBasicInfo[0].managementCompany.toString().contains(",")){
          managerSel.add(widget.houseDetail.houseBasicInfo[0].managementCompany.toString().split(',')[0].toString().split("-")[1]);
        }
        if(widget.houseDetail.houseBasicInfo[0].tax.toString().contains(",")){
          taxSel=widget.houseDetail.houseBasicInfo[0].tax.toString().split(',');
        }



      }else{
        areaController.text = "1";
        floorController.text = "1";
        totalFloorController.text = "1";
        houseAgeController.text = "2000";
        managementPriceController.text = "0";
        roomController.text = "1";
        sittingRoomController.text = "1";
        kitchenController.text = "1";
        toiletController.text = "1";
      }
    }

    _getUserInfo();
    // _load();
    direction = ["东","南","西","北","未知"];
    lift =["有电梯","无电梯","未知"];
    finish = ["精装修","普通装修","毛坯房","未知"];
    manager = ["优质物业","普通物业","无物业","未知"];
    tax = ["满五唯一","满两年","不满两年","无关","未知"];

    super.initState();

  }



  @override
  void dispose(){
    countController.dispose();
    areaController.dispose();
    roomController.dispose();
    sittingRoomController.dispose();
    kitchenController.dispose();
    toiletController.dispose();
    floorController.dispose();
    totalFloorController.dispose();
    houseAgeController.dispose();
    managementPriceController.dispose();
    managementCompanyController.dispose();
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
                              padding: EdgeInsets.only(left: 15,top: 5,bottom: 10),
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
                                        child: Text('房源高级筛选',style: TextStyle(
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
                          // 分类
                          Container(
                            width: 335,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // 业务
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "业务：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: workValue,
                                      items: getWorkList(),
                                      hint: Text('所有'),
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 22,
                                      elevation: 24,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      onChanged: (dynamic T){
                                        setState(() {
                                          workValue = T;
                                          houses = [];
                                          customersResult = null;
                                          houseShowList = [];
                                          pageIndex = 0;
                                        });
                                        // _load();
                                      },
                                    )
                                  ],
                                ),
                                // 房源类型
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "类型：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: typeValue,
                                      items: getTypeList(),
                                      hint: Text('所有'),
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 22,
                                      elevation: 24,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      onChanged: (dynamic T){
                                        setState(() {
                                          typeValue = T;
                                          houses = [];
                                          customersResult = null;
                                          houseShowList = [];
                                          pageIndex = 0;
                                        });
                                        // _load();
                                      },
                                    )
                                  ],
                                ),
                                // 高级筛选
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "排序：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    DropdownButton(
                                      value: sortValue,
                                      items: getSortList(),
                                      hint: Text('时间近'),
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 22,
                                      elevation: 24,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      onChanged: (dynamic T){
                                        setState(() {
                                          sortValue = T;
                                          houses = [];
                                          houseShowList = [];
                                          customersResult = null;
                                          pageIndex = 0;
                                        });
                                        // _load();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          alreadyChoose?
                          // 高级筛选结果
                          Column(
                            children: [
                              Container(
                                width: 335,
                                child: Row(
                                  children: [
                                    Text(
                                      "高级筛选：",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Expanded(
                                        child:Wrap(
                                          spacing: 4,
                                          children: [
                                            Chip(
                                              backgroundColor: Color(0xFF93C0FB),
                                              label: Text('2居室',style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),),
                                            ),
                                            Chip(
                                              backgroundColor: Color(0xFF93C0FB),
                                              label: Text('朝南',style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),),
                                            ),
                                            Chip(
                                              backgroundColor: Color(0xFF93C0FB),
                                              label: Text('中楼层',style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),),
                                            ),
                                            Chip(
                                              backgroundColor: Color(0xFF93C0FB),
                                              label: Text('80-120平米',style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),),
                                            ),
                                            Chip(
                                              backgroundColor: Color(0xFF93C0FB),
                                              label: Text('精装修',style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),),
                                            ),
                                          ],
                                        )

                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          alreadyChoose = false;
                                        });
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseFilterSearchChoosePage(
                                        //   // item: widget.item,
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
                              )
                            ],
                          )
                          :
                          // 筛选选项
                          Column(
                            children: [
                              // 选择房源所在区域
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 15),
                                child: Text(
                                  '房源所在区域：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                // onTap: _incrementCounter,
                                child: Container(
                                  width: 335,
                                  height: 40,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF2692FD)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:EdgeInsets.only(left: 10),
                                        child: Text(
                                          // text ?? "点击选择",
                                          "点击选择",
                                          style:TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF999999),
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(right: 10),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // 面积区间
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '面积区间：',
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
                                margin: EdgeInsets.only(top: 5,left: 20),
                                child: Row(
                                  children: <Widget>[

                                    Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: TextField(
                                          controller: totalFloorController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("平米 ~",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: TextField(
                                          controller: totalFloorController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("平米",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              // 报价区间
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '总价区间：',
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
                                margin: EdgeInsets.only(top: 5,left: 20),
                                child: Row(
                                  children: <Widget>[

                                    Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: TextField(
                                          controller: totalFloorController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("万元 ~",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                    Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                                        ),
                                        child: TextField(
                                          controller: totalFloorController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF5580EB),
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20,left: 20),
                                      child: Text("万元",style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              // 朝向
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '朝向：',
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
                                        if (value.length > 4) {
                                          return "选择不可多于4项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: directionSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: direction,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    String sel="";
                                                    val.forEach((element) {
                                                      sel+=element+",";
                                                    });
                                                    directionSel = val;
                                                    directionSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    // val.forEach((element) {
                                                    //   var item=element;
                                                    //   directionSelect+=item + ',';
                                                    //   print(directionSelect);
                                                    //   if(state.value != null){
                                                    //     setState(() {
                                                    //       itemLength = state.value.length;
                                                    //     });
                                                    //   }
                                                    // });
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
                                                    state.errorText ?? state.value!.length.toString() + '/4 可选',
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
                              // 居室
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '居室：',
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
                                        if (value.length > 4) {
                                          return "选择不可多于4项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: directionSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: direction,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    String sel="";
                                                    val.forEach((element) {
                                                      sel+=element+",";
                                                    });
                                                    directionSel = val;
                                                    directionSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    // val.forEach((element) {
                                                    //   var item=element;
                                                    //   directionSelect+=item + ',';
                                                    //   print(directionSelect);
                                                    //   if(state.value != null){
                                                    //     setState(() {
                                                    //       itemLength = state.value.length;
                                                    //     });
                                                    //   }
                                                    // });
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
                                                    state.errorText ?? state.value!.length.toString() + '/4 可选',
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
                              // 电梯
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '电梯',
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
                                        if (value.length > 1) {
                                          return "选择不可多于1项";
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
                                                      source: lift,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    elevatorSelect="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      print(item);
                                                      elevatorSelect+=item + ',';
                                                      print(elevatorSelect);
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
                                                    state.errorText ?? state.value.length.toString() + '/1 可选',
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
                              // 楼层高中低
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '楼层：',
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
                                        if (value.length > 4) {
                                          return "选择不可多于4项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: directionSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: direction,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    String sel="";
                                                    val.forEach((element) {
                                                      sel+=element+",";
                                                    });
                                                    directionSel = val;
                                                    directionSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    // val.forEach((element) {
                                                    //   var item=element;
                                                    //   directionSelect+=item + ',';
                                                    //   print(directionSelect);
                                                    //   if(state.value != null){
                                                    //     setState(() {
                                                    //       itemLength = state.value.length;
                                                    //     });
                                                    //   }
                                                    // });
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
                                                    state.errorText ?? state.value!.length.toString() + '/4 可选',
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
                              // 装修
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '装修',
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
                                        if (value.length > 1) {
                                          return "选择不可多于1项";
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
                                                      source: finish,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    decorationSelect="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      print(item);
                                                      decorationSelect+=item + ',';
                                                      print(decorationSelect);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value!.length;
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
                                                    state.errorText ?? state.value.length.toString() + '/1 可选',
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
                              // 楼龄
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '楼龄：',
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
                                        if (value.length > 4) {
                                          return "选择不可多于4项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: directionSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: direction,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    String sel="";
                                                    val.forEach((element) {
                                                      sel+=element+",";
                                                    });
                                                    directionSel = val;
                                                    directionSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    // val.forEach((element) {
                                                    //   var item=element;
                                                    //   directionSelect+=item + ',';
                                                    //   print(directionSelect);
                                                    //   if(state.value != null){
                                                    //     setState(() {
                                                    //       itemLength = state.value.length;
                                                    //     });
                                                    //   }
                                                    // });
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
                                                    state.errorText ?? state.value!.length.toString() + '/4 可选',
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
                              // 权属
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '权属：',
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
                                        if (value.length > 4) {
                                          return "选择不可多于4项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: directionSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: direction,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    String sel="";
                                                    val.forEach((element) {
                                                      sel+=element+",";
                                                    });
                                                    directionSel = val;
                                                    directionSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    // val.forEach((element) {
                                                    //   var item=element;
                                                    //   directionSelect+=item + ',';
                                                    //   print(directionSelect);
                                                    //   if(state.value != null){
                                                    //     setState(() {
                                                    //       itemLength = state.value.length;
                                                    //     });
                                                    //   }
                                                    // });
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
                                                    state.errorText ?? state.value!.length.toString() + '/4 可选',
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
                              // 税费
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '税费',
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
                                        if (value.length > 1) {
                                          return "选择不可多于1项";
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
                                                      source: tax,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    taxSelect="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      print(item);
                                                      taxSelect+=item + ',';
                                                      print(taxSelect);
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
                                                    state.errorText ?? state.value.length.toString() + '/1 可选',
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
                              // 房源特色
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '房源特色',
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
                                        if (value.length > 1) {
                                          return "选择不可多于1项";
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
                                                      source: tax,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    taxSelect="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      print(item);
                                                      taxSelect+=item + ',';
                                                      print(taxSelect);
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
                                                    state.errorText ?? state.value.length.toString() + '/1 可选',
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

                              // 下一步
                              GestureDetector(
                                onTap: ()async {
                                  setState(() {
                                    alreadyChoose = true;
                                  });
                                  // if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
                                  // _onRefresh();
                                  //
                                  // //    _otherNeedPressed(context);
                                  // var addResult = await AddHouseStep2Dao
                                  //     .addHouseStep2(
                                  //   widget.houseId.toString(), //房源id
                                  //   areaController.text, // 面积
                                  //   roomController.text + "-" +
                                  //       sittingRoomController.text + "-" +
                                  //       kitchenController.text + "-" +
                                  //       toiletController.text, // 居室结构
                                  //   directionSelect == ""
                                  //       ? "未知"
                                  //       : directionSelect, // 朝向
                                  //   floorController.text, // 所在楼层
                                  //   totalFloorController.text, // 总楼层
                                  //   decorationSelect == ""
                                  //       ? "未知"
                                  //       : decorationSelect, // 装修情况
                                  //   houseAgeController.text, // 楼龄
                                  //   managementCompanyController.text+"-"+(managementSelect==""?"未知":managementSelect), // 物业
                                  //   managementPriceController.text, // 物业费
                                  //   elevatorSelect == "" ? "未知" : elevatorSelect, // 电梯
                                  //   taxSelect == "" ? "未知" : taxSelect, // 税费
                                  //   int.parse(floorController.text)/int.parse(totalFloorController.text)<0.17?1
                                  //       :int.parse(floorController.text)/int.parse(totalFloorController.text)>0.67?3:2, // 高中低楼层
                                  //   (widget.houseDetail.housePrice/double.parse(houseAgeController.text)).truncate(), // 单价
                                  // );
                                  // print(addResult);
                                  // if (addResult.code == 200 ||
                                  //     addResult.code == 201) {
                                  //   _onRefresh();
                                  //   if (userData!.userLevel.substring(0, 1) == "6") {
                                  //     Navigator.push(context, MaterialPageRoute(
                                  //         builder: (context) => HouseListPage()));
                                  //   }
                                  //   if (userData!.userLevel.substring(0, 1) == "4") {
                                  //     Navigator.push(context, MaterialPageRoute(
                                  //         builder: (context) => STradedPage()));
                                  //   }
                                  //   if (userData!.userLevel.substring(0, 1) == "5") {
                                  //     Navigator.push(context, MaterialPageRoute(
                                  //         builder: (context) => MTradedPage()));
                                  //   }
                                  // } else {
                                  //   _onRefresh();
                                  //   _onOverLoadPressed(context);
                                  //   // }
                                  //   // }else{
                                  //   //   // 必填信息不完整的弹窗
                                  //   //   _onMsgPressed(context);
                                  //   // }
                                  // }
                                },
                                child: Container(
                                    width: 335,
                                    height: 40,
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.only(bottom: 50,top: 100),
                                    decoration:
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
                            ],
                          )

                        ]
                    )
                  ],
                )
            )
        )
    );
  }

  // 价格未调整弹窗
  _onPriceCountWrongPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "价格未变动",
      desc: "请调价后重试",
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

  _editPricePressed(context) {
    Alert(
      context: context,
      title: "修改房源报价",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("修改报价：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xFF0E7AE6)))
                  ),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5580EB),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
              Text("万",style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: Text("调价原因：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xFF0E7AE6)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: priceReasonController,
                    autofocus: false,
                    keyboardType: TextInputType.multiline,
                    // onChanged: _onMapChanged,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      hintText:'请填写调价原因，5~300字',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text("点击确定立刻修改，请慎重选择",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666)
            ),
              textAlign: TextAlign.left,
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
            if(priceReasonController.text== null || priceReasonController.text==""){
              _onPriceReasonWrongPressed(context);
            }else{
              if(priceController.text == priceCount.toString()){
                _onPriceCountWrongPressed(context);
              } else{
                var r=await ModiHousePriceDao.modiHousePrice(
                    widget.houseId,
                    priceController.text,
                    userData!.userPid,
                    priceReasonController.text
                );
                if(r.code == 200){
                  setState(() {
                    priceCount = int.parse(priceController.text);
                  });
                  Navigator.pop(context);
                }
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

  _onPriceReasonWrongPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "调价原因为必填项",
      desc: "请完善后重试",
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
}


