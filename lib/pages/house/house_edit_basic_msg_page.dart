import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/add_house_step2_dao.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/dao/modi_house_price_dao.dart';
import 'package:ThumbSir/dao/update_house_public_dao.dart';
import 'package:ThumbSir/dao/update_house_urgentlevel_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/sell_need_page.dart';
import 'package:ThumbSir/pages/house/house_add_around_msg_page.dart';
import 'package:ThumbSir/pages/house/house_list_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:ThumbSir/model/set_kpimission_item_model.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';

class HouseEditBasicMsgPage extends StatefulWidget {
  final houseId;
  final houseDetail;
  HouseEditBasicMsgPage({Key key,
    this.houseId,this.houseDetail
  }):super(key:key);
  @override
  _HouseEditBasicMsgPageState createState() => _HouseEditBasicMsgPageState();
}

class _HouseEditBasicMsgPageState extends State<HouseEditBasicMsgPage> {
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
  String companyName;
  RegExp companyReg;
  bool companyNameBool;
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
  List missionContent=new List();

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

  List<DealInfo> deal=new List();
  List<NeedInfo> need=new List();
  List<FamilyMember> member=new List();

  LoginResultData userData;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uinfo));
      });
    }
  }

  @override
  void initState() {
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
                              padding: EdgeInsets.only(left: 15,top: 15,bottom: 20),
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
                                        child: Text('修改房源基本信息',style: TextStyle(
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

                          // 地址
                          Container(
                            width: 335,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  child: Text('地址:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Expanded(
                                  child: Text(
                                    address,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),),
                                ),
                                Container(
                                  width: 20,
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: (){
                                      // Navigator.push(context, MaterialPageRoute(
                                      //     builder: (context) => EditSellNeedDetailPage(
                                      //         houseId:widget.houseId
                                      //     )));
                                    },
                                    color: Color(0xFF5580EB),
                                    disabledColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 报价
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('报价:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    priceCount.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 40,left: 20),
                                  child: Text("万",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                  width: 20,
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: (){
                                      _editPricePressed(context);
                                    },
                                    color: Color(0xFF5580EB),
                                    disabledColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 急迫度
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('急迫度:',style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 40),
                                  width: 80,
                                  child: Text(
                                    tradeLevelCount,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF5580EB),
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),),
                                ),
                                Container(
                                  width: 20,
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: (){
                                      _onChooseLevelPressed(context);
                                    },
                                    color: Color(0xFF5580EB),
                                    disabledColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 面积
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('面积:',style: TextStyle(
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
                                      controller: areaController,
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
                          // 卧室数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('卧室数量:',style: TextStyle(
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
                                      controller: roomController,
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
                                  child: Text("间",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 客餐厅数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('客餐厅数量:',style: TextStyle(
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
                                      controller: sittingRoomController,
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
                                  child: Text("个",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 厨房数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('厨房数量:',style: TextStyle(
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
                                      controller: kitchenController,
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
                                  child: Text("个",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 卫生间数量
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('卫生间数量:',style: TextStyle(
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
                                      controller: toiletController,
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
                                  child: Text("个",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 所处楼层
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('所处楼层:',style: TextStyle(
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
                                      controller: floorController,
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
                                  child: Text("层",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          // 总楼层
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('总楼层:',style: TextStyle(
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
                                  child: Text("层",style: TextStyle(
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
                                    if (value.isEmpty) {
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
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: direction,
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
                                                state.errorText ?? state.value.length.toString() + '/4 可选',
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
                                    if (value.isEmpty) {
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
                                              value: state.value,
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: finish,
                                                  // 存储形式
                                                  value:(index,item)=>item,
                                                  // 展示形式
                                                  label: (index,item)=>item
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
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('建成年份:',style: TextStyle(
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
                                      controller: houseAgeController,
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
                                  child: Text("年",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
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
                                    if (value.isEmpty) {
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
                                              value: state.value,
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: lift,
                                                  // 存储形式
                                                  value:(index,item)=>item,
                                                  // 展示形式
                                                  label: (index,item)=>item
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
                          // 物业公司名称
                          Container(
                            width: 335,
                            child: Text(
                              '物业公司名称：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入物业公司名称",
                            tipText: "请输入物业公司名称",
                            errorTipText: "请输入物业公司名称",
                            rightText: "请输入物业公司名称",
                            controller: managementCompanyController,
                            inputType: TextInputType.text,
                            reg: companyReg,
                            onChanged: (text){
                              setState(() {
                                companyName = text;
                                companyNameBool = companyReg.hasMatch(companyName);
                              });
                            },
                          ),
                          Container(
                              width: 335,
                              // title: '可选的任务名称（ 多选 ）',
                              child: FormField<List<String>>(
                                  initialValue: tags,
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                                              value: state.value,
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: manager,
                                                  // 存储形式
                                                  value:(index,item)=>item,
                                                  // 展示形式
                                                  label: (index,item)=>item
                                              ),
                                              onChanged: (val) {
                                                state.didChange(val);
                                                missionContent = val;
                                                managementSelect="";
                                                val.forEach((element) {
                                                  var item=element;
                                                  print(item);
                                                  managementSelect+=item + ',';
                                                  print(managementSelect);
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
                          // 物业费
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text('物业费:',style: TextStyle(
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
                                      controller: managementPriceController,
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
                                  child: Text("元/平米/月",style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),),
                                ),
                              ],
                            ),
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
                                    if (value.isEmpty) {
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
                                              value: state.value,
                                              options:  ChipsChoiceOption.listFrom(
                                                  source: tax,
                                                  // 存储形式
                                                  value:(index,item)=>item,
                                                  // 展示形式
                                                  label: (index,item)=>item
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
                              // if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
                              _onRefresh();

                              //    _otherNeedPressed(context);
                              var addResult = await AddHouseStep2Dao
                                  .addHouseStep2(
                                  widget.houseId.toString(),
                                  areaController.text,
                                  roomController.text + "-" +
                                      sittingRoomController.text + "-" +
                                      kitchenController.text + "-" +
                                      toiletController.text,
                                  directionSelect == ""
                                      ? "未知"
                                      : directionSelect,
                                  floorController.text,
                                  totalFloorController.text,
                                  decorationSelect == ""
                                      ? "未知"
                                      : decorationSelect,
                                  houseAgeController.text,
                                  managementCompanyController.text+"-"+(managementSelect==""?"未知":managementSelect),
                                  managementPriceController.text,
                                  elevatorSelect == "" ? "未知" : elevatorSelect,
                                  taxSelect == "" ? "未知" : taxSelect
                              );
                              print(addResult);
                              if (addResult.code == 200 ||
                                  addResult.code == 201) {
                                _onRefresh();
                                if (userData.userLevel.substring(0, 1) == "6") {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HouseListPage()));
                                }
                                if (userData.userLevel.substring(0, 1) == "4") {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => STradedPage()));
                                }
                                if (userData.userLevel.substring(0, 1) == "5") {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => MTradedPage()));
                                }
                              } else {
                                _onRefresh();
                                _onOverLoadPressed(context);
                                // }
                                // }else{
                                //   // 必填信息不完整的弹窗
                                //   _onMsgPressed(context);
                                // }
                              };
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
                    userData.userPid,
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
// 选择急迫度
  _onChooseLevelPressed(context) {
    Alert(
      context: context,
      title: "您要调整急迫度为：",
      content: Container(
        width: 200,
        height: 120,
        margin: EdgeInsets.only(top: 18),
        child: WheelChooser(
          onValueChanged: (s){
            setState(() {
              levelMinCount = s;
            });
          },
          datas: levels,
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
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            if(levelMinCount == tradeLevelCount){
              Navigator.pop(context);
            }else{
              if(levelMinCount=="下架"){
                // 调用下架，成功后给tradeLevelCount赋值
                var dr=await UpdateHousePublicDao.updateHousePublic(
                    widget.houseId,
                    false
                );
                if(dr.code == 200){
                  setState(() {
                    tradeLevelCount = levelMinCount;
                  });
                  Navigator.pop(context);
                }
              }else{
                if(tradeLevelCount=="下架"){
                  // 调用上架+改急迫度，成功后给tradeLevelCount赋值
                  var ur=await UpdateHousePublicDao.updateHousePublic(
                      widget.houseId,
                      true
                  );
                  var lr=await UpdateHouseUrgentlevelDao.updateHouseUrgentlevel(
                      widget.houseId,
                      levelMinCount
                  );
                  if(ur.code == 200 && lr.code == 200){
                    setState(() {
                      tradeLevelCount = levelMinCount;
                    });
                    Navigator.pop(context);
                  }

                }else{
                  // 调用改急迫度，成功后给tradeLevelCount赋值
                  var lr=await UpdateHouseUrgentlevelDao.updateHouseUrgentlevel(
                      widget.houseId,
                      levelMinCount
                  );
                  if(lr.code == 200){
                    setState(() {
                      tradeLevelCount = levelMinCount;
                    });
                    Navigator.pop(context);
                  }
                }
              }
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


