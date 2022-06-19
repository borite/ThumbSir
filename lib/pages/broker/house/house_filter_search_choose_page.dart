import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_house_list_by_filter_Search_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../widget/house_search_item.dart';

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
  final TextEditingController priceMaxController=TextEditingController();
  final TextEditingController priceMinController=TextEditingController();
  final TextEditingController areaMaxController=TextEditingController();
  final TextEditingController areaMinController=TextEditingController();
  late String companyName;
  late RegExp companyReg;
  bool companyNameBool = false;
  String levelMinCount = "着急";
  bool _loading = false;
  List levels=["着急","诚心","一般","下架"];
  String tradeLevelCount = "着急";
  
  dynamic nowYear = DateTime.now().year;
  List searchChoose =[];
  List<Widget> showSearchChoose=[];

  String directionSelect='-1';
  String decorationSelect='-1';
  String elevatorSelect='-1';
  String taxSelect='-1';
  String managementSelect='-1';
  String roomsSelect ='-1';
  String floorSelect ='-1';
  String houseAgeSelect ='-1';
  String ownerShipSelect ='-1';
  String otherLabelSelect ='-1';


  List<String> direction = [];
  List<String> lift =[];
  List<String> finish = [];
  List<String> manager = [];
  List<String> tax = [];
  List<String> rooms = [];
  List<String> floor = [];
  List<String> houseAge = [];
  List<String> ownerShip = [];
  List<String> otherLabel = [];

  List<String> directionSel = [];
  List<String> liftSel =[];
  List<String> finishSel = [];
  List<String> managerSel = [];
  List<String> taxSel = [];
  List<String> roomsSel = [];
  List<String> floorSel = [];
  List<String> houseAgeSel = [];
  List<String> ownerShipSel = [];
  List<String> otherLabelSel = [];


  LoginResultData? userData;
  late String uInfo;

  String workValue = "所有";
  String typeValue = "所有";
  int sortValue = -1;

  bool alreadyChoose = false;

  List<DropdownMenuItem> getWorkList(){
    List<DropdownMenuItem> workLists = [];
    DropdownMenuItem workList1 = new DropdownMenuItem(child: Text('所有'),value: '所有',);
    workLists.add(workList1);
    DropdownMenuItem workList2 = new DropdownMenuItem(child: Text('出售'),value: '出售',);
    workLists.add(workList2);
    DropdownMenuItem workList3 = new DropdownMenuItem(child: Text('出租'),value: '出租',);
    workLists.add(workList3);
    DropdownMenuItem workList4 = new DropdownMenuItem(child: Text('我的'),value: '我的',);
    workLists.add(workList4);
    DropdownMenuItem workList5 = new DropdownMenuItem(child: Text('下架'),value: '下架',);
    workLists.add(workList5);
    return workLists;
  }

  List<DropdownMenuItem> getTypeList(){
    List<DropdownMenuItem> typeLists = [];
    DropdownMenuItem typeList1 = new DropdownMenuItem(child: Text('所有'),value: '所有',);
    typeLists.add(typeList1);
    DropdownMenuItem typeList2 = new DropdownMenuItem(child: Text('住宅'),value: '住宅',);
    typeLists.add(typeList2);
    DropdownMenuItem typeList3 = new DropdownMenuItem(child: Text('商铺'),value: '商铺',);
    typeLists.add(typeList3);
    DropdownMenuItem typeList4 = new DropdownMenuItem(child: Text('公寓'),value: '公寓',);
    typeLists.add(typeList4);
    DropdownMenuItem typeList5 = new DropdownMenuItem(child: Text('车位'),value: '车位',);
    typeLists.add(typeList5);
    return typeLists;
  }

  List<DropdownMenuItem> getSortList(){
    List<DropdownMenuItem> sortLists = [];
    DropdownMenuItem sortList1 = new DropdownMenuItem(child: Text('时间近'),value: -1,);
    sortLists.add(sortList1);
    DropdownMenuItem sortList2 = new DropdownMenuItem(child: Text('时间远'),value: 1,);
    sortLists.add(sortList2);
    DropdownMenuItem sortList3 = new DropdownMenuItem(child: Text('带看量'),value: 6,);
    sortLists.add(sortList3);
    DropdownMenuItem sortList4 = new DropdownMenuItem(child: Text('总价升'),value: 2,);
    sortLists.add(sortList4);
    DropdownMenuItem sortList5 = new DropdownMenuItem(child: Text('总价降'),value: 3,);
    sortLists.add(sortList5);
    DropdownMenuItem sortList6 = new DropdownMenuItem(child: Text('单价升'),value: 5,);
    sortLists.add(sortList6);
    DropdownMenuItem sortList7 = new DropdownMenuItem(child: Text('单价降'),value: 4,);
    sortLists.add(sortList7);
    return sortLists;
  }
  var houseList = [];
  List<Widget> houseShowList = [];
  List<Widget> houses=[];
  var pageIndex=1;

  List inputRoom=[];

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  _load()async {
    if (
    (priceMinController.text != "" && priceMaxController.text == "")
        || (priceMinController.text == "" && priceMaxController.text != "")
        || (areaMinController.text != "" && areaMaxController.text == "")
        || (areaMinController.text == "" && areaMaxController.text != "")
    ){
      _onMsgWrongPressed(context);
    } else {
      _onRefresh();
      searchChoose=[];
      showSearchChoose=[];

      // 已选择标签
      // 这里缺省份区域的判断
      if(areaMaxController.text!=''&& areaMinController.text!=''){
        searchChoose.add(areaMinController.text+"平米~"+areaMaxController.text+"平米");
      }
      if(priceMaxController.text!=''&& priceMinController.text!=''){
        searchChoose.add(priceMinController.text+"万元~"+priceMaxController.text+"万元");
      }
      if(directionSelect!="-1"){
        searchChoose.add(directionSelect);
      }
      if(roomsSelect!="-1"){
        searchChoose.add(roomsSelect);
      }
      if(elevatorSelect!='-1'){
        searchChoose.add(elevatorSelect);
      }
      if(floorSelect!='-1'){
        searchChoose.add(floorSelect);
      }
      if(houseAgeSelect!="-1"){
        searchChoose.add(houseAgeSelect);
      }
      if(ownerShipSelect!="-1"){
        searchChoose.add(ownerShipSelect);
      }
      if(taxSelect!="-1"){
        searchChoose.add(taxSelect);
      }
      if(otherLabelSelect!="-1"){
        searchChoose.add(otherLabelSelect);
      }

      dynamic searchResult = await GetHouseListByFilterSearchDao
          .httpGetHouseListByFilterSearch(
        userData!.userPid,
        userData!.companyId,
        workValue == "我的" ? 3 : workValue == "失效" ? 4 : -1, // 业务
        '-1', // 省份区域,
        priceMinController.text == "" ? -1 : double.parse(priceMinController.text), // 最低价格
        priceMaxController.text == "" ? -1 : double.parse(priceMaxController.text), // 最高价格
        areaMinController.text == "" ? -1 : double.parse(areaMinController.text), // 最小面积
        areaMaxController.text == "" ? -1 : double.parse(areaMaxController.text), // 最大面积
        workValue == "出售" ? 1 : workValue == "出租" ? 2 : -1,
        otherLabelSelect.contains("学区房") ? 1 : -1, // 是否为学区房
        taxSelect, // 税费
        otherLabelSelect, // 房源特色
        directionSelect, // 朝向
        roomsSelect == "-1" ? "-1" : inputRoom.toString().replaceAll("[", "").replaceAll("]", ""), // 居室
        elevatorSelect, // 电梯
        floorSelect, // 楼层
        decorationSelect, // 装修
        houseAgeSelect == "5年以内" ? (nowYear - 5)
            : houseAgeSelect == "10年以内" ? (nowYear - 10)
            : houseAgeSelect == "15年以内" ? (nowYear - 15)
            : houseAgeSelect == "20年以内" ? (nowYear - 20)
            : 1949, // 楼龄
        typeValue == "所有" ? "-1" : typeValue, // 类型：住宅车位等
        ownerShipSelect, // 权属
        sortValue, // 排序规则
        pageIndex,
        30,
      );
      if (searchResult.code == 200) {
        houseList = searchResult.data!;
        if (houseList.length > 0) {
          for (var item in houseList) {
            houseShowList.add(
              HouseSearchItem(
                  houseItem: item
              ),
            );
          }
        }

        if(searchChoose.length>0){
          for (var chooseItem in searchChoose) {
            showSearchChoose.add(
                Chip(
                  backgroundColor: Color(0xFF93C0FB),
                  label: Text(
                    chooseItem,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),),
                )
            );
          }
        }else{
          showSearchChoose.add(
              Chip(
                backgroundColor: Color(0xFF93C0FB),
                label: Text('所有',style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),),
              )
          );
        }

        setState(() {
          alreadyChoose = true;
          houses = houseShowList;
        });
        _onRefresh();
      } else {
        _onRefresh();
        _onOverLoadPressed(context);
      }
    }
  }

  @override
  void initState() {
    companyReg = TextReg;

    priceMinController.text = "";
    priceMaxController.text = "";
    areaMinController.text = "";
    areaMaxController.text = "";

    _getUserInfo();
    direction = ["东","南","西","北"];
    rooms = ["1居室","2居室","3居室","4居室","5居室及以上"];
    lift =["有电梯","无电梯"];
    floor = ["低楼层","中楼层","高楼层"];
    finish = ["精装修","普通装修","毛坯房"];
    houseAge = ["5年以内","10年以内","15年以内","20年以内","20年以上"];
    ownerShip = ["商品房","公房","别墅","四合院","其他"];
    manager = ["优质物业","普通物业","无物业"];
    tax = ["满五唯一","满两年","不满两年"];
    otherLabel = ["近地铁","学区房","随时看房"];

    super.initState();

  }



  @override
  void dispose(){
    priceMinController.dispose();
    priceMaxController.dispose();
    areaMinController.dispose();
    areaMaxController.dispose();
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
                                          houseShowList = [];
                                          pageIndex = 1;
                                        });
                                        if(alreadyChoose){
                                          _load();
                                        }
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
                                          houseShowList = [];
                                          pageIndex = 1;
                                        });
                                        if(alreadyChoose){
                                          _load();
                                        }
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
                                          pageIndex = 1;
                                        });
                                        if(alreadyChoose){
                                          _load();
                                        }
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
                                          children:showSearchChoose,
                                        )

                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          alreadyChoose = false;
                                          houses = [];
                                          houseShowList = [];
                                          pageIndex = 1;
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
                              ),
                              houseList.length>0 && houses !=[]?
                                  Container(width: 1,)
                                  :
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 20),
                                  width: 335,
                                  height: 104,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 25,bottom: 8),
                                        child: Text(
                                          '没有相关房源',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            color: Color(0xFFCCCCCC),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        '换一换筛选条件再试试吧~',
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          color: Color(0xFFCCCCCC),
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
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
                                        '面积区间（须同时填写或同时不填）：',
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
                                          controller: areaMinController,
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
                                          controller: areaMaxController,
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
                                        '总价区间（须同时填写或同时不填）：',
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
                                          controller: priceMinController,
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
                                          controller: priceMaxController,
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
                                      initialValue: directionSel,
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
                                                    if(sel!=""){
                                                      directionSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      directionSelect="-1";
                                                    }
                                                    // val.forEach((element) {
                                                    //   var item=element;
                                                    //   directionSelect+=item + ',';
                                                    //   print(directionSelect);
                                                    //   if(state.value != null){
                                                    //     setState(() {
                                                    //       itemLength = state.value!.length;
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
                                      initialValue: roomsSel,
                                      validator: (value) {
                                        if (value==null) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > 5) {
                                          return "选择不可多于5项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: roomsSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: rooms,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (dynamic val) {
                                                    state.didChange(val);
                                                    String sel="";
                                                    inputRoom=[];
                                                      val.forEach((element) {
                                                        sel+=element+",";
                                                        inputRoom.add(element.substring(0,1));
                                                      });
                                                      roomsSel = val;
                                                      if(sel!=""){
                                                        roomsSelect=sel.substring(0,sel.lastIndexOf(','));
                                                      }else{
                                                        roomsSelect="-1";
                                                      }
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
                                                    state.errorText ?? state.value!.length.toString() + '/5 可选',
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
                                      initialValue: liftSel,
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
                                                  value: liftSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: lift,
                                                      // 存储形式
                                                      value:(index,item)=>item.toString(),
                                                      // 展示形式
                                                      label: (index,item)=>item.toString()
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    String sel ="";
                                                    val.forEach((element) {
                                                      sel+=element + ',';
                                                      // if(state.value != null){
                                                      //   setState(() {
                                                      //     itemLength = state.value.length;
                                                      //   });
                                                      // }
                                                    });
                                                    liftSel = val;
                                                    if(sel!=""){
                                                      elevatorSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      elevatorSelect="-1";
                                                    }
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
                                      initialValue: floorSel,
                                      validator: (value) {
                                        if (value==null) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > 1) {
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
                                                  value: floorSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: floor,
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
                                                    floorSel = val;
                                                    if(sel!=""){
                                                      floorSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      floorSelect="-1";
                                                    }
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
                                                    state.errorText ?? state.value!.length.toString() + '/1 可选',
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
                                      initialValue: finishSel,
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
                                                  value: finishSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: finish,
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
                                                    finishSel = val;
                                                    if(sel!=""){
                                                      decorationSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      decorationSelect="-1";
                                                    }
                                                    // if(state.value != null){
                                                    //   setState(() {
                                                    //     itemLength = state.value!.length;
                                                    //   });
                                                    // }
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
                                      initialValue: houseAgeSel,
                                      validator: (value) {
                                        if (value==null) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > 4) {
                                          return "选择不可多于1项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: houseAgeSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: houseAge,
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
                                                    houseAgeSel = val;
                                                    if(sel!=""){
                                                      houseAgeSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      houseAgeSelect="-1";
                                                    }
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
                                                    state.errorText ?? state.value!.length.toString() + '/1 可选',
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
                                        '类型：',
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
                                      initialValue: ownerShipSel,
                                      validator: (value) {
                                        if (value==null) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > 1) {
                                          return "选择不可多于1项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: ownerShipSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: ownerShip,
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
                                                    ownerShipSel = val;
                                                    if(sel!=""){
                                                      ownerShipSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      ownerShipSelect="-1";
                                                    }
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
                                                    state.errorText ?? state.value!.length.toString() + '/1 可选',
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
                                      initialValue: taxSel,
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
                                                  value: taxSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: tax,
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
                                                    taxSel = val;
                                                    if(sel!=""){
                                                      taxSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      taxSelect="-1";
                                                    }
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
                                      initialValue: otherLabelSel,
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
                                                  value: otherLabelSel,
                                                  choiceItems:  C2Choice.listFrom(
                                                      source: otherLabel,
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
                                                    otherLabelSel = val;
                                                    if(sel!=""){
                                                      otherLabelSelect=sel.substring(0,sel.lastIndexOf(','));
                                                    }else{
                                                      otherLabelSelect="-1";
                                                    }
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
                              ),

                              // 完成
                              GestureDetector(
                                onTap: ()async {
                                  _load();
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
                          ),
                          // 列表
                          houseList.length>0 && houses !=[]?
                          Column(
                            children: houses,
                          ):
                              Container(width: 1,)


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

  _onMsgWrongPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "面积和总价的最大最小值须同时填写或同时不填",
      desc: "请检查后重试",
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


