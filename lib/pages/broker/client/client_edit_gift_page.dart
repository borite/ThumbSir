import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/update_care_action_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/client_detail_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClientEditGiftPage extends StatefulWidget {
  final item;
  final date;
  final giftMsg;
  final price;
  final dec;
  final type;
  final id;

  ClientEditGiftPage({Key? key,
    this.date,this.giftMsg,this.price,this.dec,this.type,this.item,this.id
  }):super(key:key);
  @override
  _ClientEditGiftPageState createState() => _ClientEditGiftPageState();
}

class _ClientEditGiftPageState extends State<ClientEditGiftPage> {
  bool _loading = false;

  final TextEditingController nameController=TextEditingController();
  late String name;
  late RegExp nameReg;
  bool nameBool = false;
  final TextEditingController priceController=TextEditingController();
  late String price;
  late RegExp priceReg;
  bool priceBool = false;
  final TextEditingController decController=TextEditingController();
  late RegExp decReg;
  bool decBool = false;

  String sendReason = "节日礼";

  List<DealInfo> deal=[];

  DateTime _selectedDate=DateTime(2021,1,1);

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  @override
  void initState() {
    decReg = TextReg;
    priceReg = numberReg;
    nameReg = TextReg;
    decController.text = widget.dec;
    priceController.text = widget.price.toString();
    nameController.text = widget.giftMsg;
    _getUserInfo();
    super.initState();
  }

  @override
  void dispose(){
    decController.dispose();
    priceController.dispose();
    nameController.dispose();
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
                                        child: Text('修改'+widget.item.userName+"的维护动作",style: TextStyle(
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
                              '维护原因（ 修改前原因为：'+widget.type+' ）：',
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
                                  sendReason = s;
                                });
                              },
                              datas: ["节日礼", "生日礼", "成交礼", "业务礼", "日常问候"],
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
                              '维护时间（ 修改前时间为'+widget.date+' ）：',
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
                              initialDate: DateTime(2021,1,1),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),
                          // 礼物名称
                          Container(
                            width: 335,
                            child: Text(
                              '维护动作（ 微信问候或礼物名称 ）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "例如：微信问候或月饼礼盒套装1套",
                            tipText: "请输入维护动作",
                            errorTipText: "请请输入维护动作",
                            rightText: "请输入维护动作",
                            controller: nameController,
                            inputType: TextInputType.text,
                            reg: nameReg,
                            onChanged: (text){
                              setState(() {
                                name = text;
                                nameBool = priceReg.hasMatch(name);
                              });
                            }, password: false,
                          ),
                          // 价格
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '价格（ 单位：元 ）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "例如：1000",
                            tipText: "请输入维护花费金额",
                            errorTipText: "请输入维护花费金额",
                            rightText: "请输入维护花费金额",
                            controller: priceController,
                            inputType: TextInputType.number,
                            reg: priceReg,
                            password: false,
                            onChanged: (text){
                              setState(() {
                                price = text;
                                priceBool = priceReg.hasMatch(price);
                              });
                            },
                          ),
                          // 地址
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '备注：',
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
                              controller: decController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onDecChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请输入维护描述',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              _onRefresh();
                              var editResult = await UpdateCareActionDao.updateCareAction(
                                  widget.id.toString(),
                                  widget.item.mid.toString(),
                                  sendReason,
                                  nameController.text,
                                  decController.text,
                                  priceController.text.toString(),
                                  _selectedDate.toIso8601String(),
                              );
                              if(editResult.code == 200){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                                  item:widget.item,
                                  tabIndex: 2,
                                )));
                              }else {
                                _onRefresh();
                                _onOverLoadPressed(context);
                              }
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
  _onDecChanged(dynamic text){
    if(text != null){
      setState(() {
        decBool = decReg.hasMatch(decController.text);
      });
    }
  }
  _deleteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否确定删除此条维护信息?",
      desc: "删除后该用户的信息将无法找回，请谨慎操作",
      buttons: [
        DialogButton(
          child: Text(
            "确定删除",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            _onRefresh();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
              item:widget.item,
              tabIndex: 2,
            )));
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
}


