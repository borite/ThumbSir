import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/delete_deal_info_dao.dart';
import 'package:ThumbSir/model/get_customer_main_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_detail_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TradedEditDealPage extends StatefulWidget {
  final item;
  final dealItem;

  TradedEditDealPage({Key key,
    this.item,this.dealItem
  }):super(key:key);
  @override
  _TradedEditDealPageState createState() => _TradedEditDealPageState();
}

class _TradedEditDealPageState extends State<TradedEditDealPage> {
  bool _loading = false;

  final TextEditingController priceController=TextEditingController();
  String price;
  RegExp priceReg;
  bool priceBool;
  final TextEditingController areaController=TextEditingController();
  String area;
  RegExp areaReg;
  bool areaBool = false;
  final TextEditingController mapController=TextEditingController();
  RegExp mapReg;
  bool mapBool = false;

  String dealMinCount = "购买住宅";

  List<DealInfo> deal=new List();

  DateTime _selectedDate=DateTime(2010,1,1);

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
    mapReg = TextReg;
    priceReg = TextReg;
    areaReg = TextReg;
    priceController.text = widget.dealItem.dealPrice.toString();
    areaController.text = widget.dealItem.dealArea == "0"?"":widget.dealItem.dealArea;
    mapController.text = widget.dealItem.address == "-"?"":widget.dealItem.address;
    _getUserInfo();
    super.initState();
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
                                        child: Text('修改'+widget.item.userName+"的成交信息",style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _deleteAlertPressed(context);
                                    },
                                    child: Container(
                                      width:50,
                                      child: Text(
                                        "删除",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          // 成交原因
                          Container(
                            width: 335,
                            child: Text(
                              '成交原因（ 修改前原因为'+widget.dealItem.dealReason+' ）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 120,
                            margin: EdgeInsets.only(top: 18),
                            child: WheelChooser(
                              onValueChanged: (s){
                                setState(() {
                                  dealMinCount = s;
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
                          // 成交时间
                          Container(
                            width: 335,
                            child: Text(
                              '成交时间（ 修改前成交时间为'+widget.dealItem.finishTime.toString().substring(0,10)+' ）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 240,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030, 1, 1),
                              initialDate: DateTime(2010,1,1),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),
                          // 成交价格
                          Container(
                            width: 335,
                            child: Text(
                              '成交价格：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "例如：500万元",
                            tipText: "请输入签约时的成交价格",
                            errorTipText: "请输入签约时的成交价格",
                            rightText: "请输入签约时的成交价格",
                            controller: priceController,
                            inputType: TextInputType.phone,
                            reg: priceReg,
                            onChanged: (text){
                              setState(() {
                                price = text;
                                priceBool = priceReg.hasMatch(price);
                              });
                            },
                          ),
                          // 面积
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '面积：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "例如：100平米",
                            tipText: "请输入购买或出售的价格",
                            errorTipText: "请输入购买或出售的价格",
                            rightText: "请输入购买或出售的价格",
                            controller: areaController,
                            inputType: TextInputType.phone,
                            reg: areaReg,
                            onChanged: (text){
                              setState(() {
                                area = text;
                                areaBool = areaReg.hasMatch(area);
                              });
                            },
                          ),
                          // 地址
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '地址：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 30),
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
                                hintText:'请输入成交房屋、公寓等的地址',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
//                              if(userNameBool == true && phoneBool == true && _starIndex != 0 ){
//                                _onRefresh();
//                                var addResult = await AddCustomerDao.addCustomer(
//                                    userData.companyId,
//                                    userData.userPid,
//                                    "5",
//                                    userNameController.text,
//                                    _radioGroupA.toString(),
//                                    phoneNumController.text,
//                                    _selectedBirthdayDate.toIso8601String(),
//                                    _starIndex.toString(),
//                                    careerController.text==null?"未知":careerController.text,
//                                    incomeMinCount,
//                                    likeController.text==null?"未知":likeController.text,
//                                    msgController.text==null?"未知":msgController.text,
//                                    mapController.text==null?"未知":mapController.text,
//                                    member,  // 家庭成员
//                                    deal,  // 成交历史
//                                );
//                                print(addResult);
//                                if (addResult.code == 200) {
//                                  _onRefresh();
//                                  if (userData.userLevel.substring(0, 1) == "6") {
//                                    Navigator.push(context, MaterialPageRoute(
//                                        builder: (context) => MyTradedPage()));
//                                  }
//                                  if (userData.userLevel.substring(0, 1) == "4") {
//                                    Navigator.push(context, MaterialPageRoute(
//                                        builder: (context) => STradedPage()));
//                                  }
//                                  if (userData.userLevel.substring(0, 1) == "5") {
//                                    Navigator.push(context, MaterialPageRoute(
//                                        builder: (context) => MTradedPage()));
//                                  }
//                                } else {
//                                  _onRefresh();
//                                  _onOverLoadPressed(context);
//                                }
//                              }else{
//                                // 必填信息不完整的弹窗
//                                _onMsgPressed(context);
//                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 40),
                                decoration: BoxDecoration(
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
                        ]
                    )
                  ],
                )
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
  _onMapChanged(String text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
      });
    }
  }
  _deleteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否确定删除此条成交信息?",
      desc: "删除后该用户的信息将无法找回，请谨慎操作",
      buttons: [
        DialogButton(
          child: Text(
            "确定删除",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            var deleteResult = await DeleteDealInfoDao.deleteDealInfo(
                widget.dealItem.id.toString()
            );
            if (deleteResult.code == 200) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedDetailPage(
                item:widget.item,
                tabIndex: 1,
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
}


