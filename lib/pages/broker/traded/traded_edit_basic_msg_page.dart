import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_customer_info_dao.dart';
import 'package:ThumbSir/dao/update_customer_dao.dart';
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

class TradedEditBasicMsgPage extends StatefulWidget {
  final item;

  TradedEditBasicMsgPage({Key key,
    this.item
  }):super(key:key);
  @override
  _TradedEditBasicMsgPageState createState() => _TradedEditBasicMsgPageState();
}

class _TradedEditBasicMsgPageState extends State<TradedEditBasicMsgPage> {
  bool _loading = false;

  final TextEditingController userNameController = TextEditingController();
  String userName;
  RegExp nameReg;
  bool userNameBool;
  final TextEditingController phoneNumController=TextEditingController();
  String phoneNum;
  RegExp phoneReg;
  bool phoneBool;
  final TextEditingController careerController=TextEditingController();
  String career;
  RegExp careerReg;
  bool careerBool = false;
  final TextEditingController mapController=TextEditingController();
  RegExp mapReg;
  bool mapBool = false;
  final TextEditingController likeController=TextEditingController();
  RegExp likeReg;
  bool likeBool = false;

  String dealMinCount = "购买住宅";
  String incomeMinCount = "10万以下";
  String memberMinCount = "妻子";
  int _starIndex = 0;

  DateTime _selectedDate=DateTime(2010,1,1);
  DateTime _selectedBirthdayDate=DateTime(1980,1,1);

  int _radioGroupA = 0;

  void _handleRadioValueChanged(int value) {
    setState(() {
      _radioGroupA = value;
    });
  }

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
    nameReg = TextReg;
    phoneReg = telPhoneReg;
    careerReg = TextReg;
    mapReg = FeedBackReg;
    likeReg = TextReg;
    userNameController.text = widget.item.userName;
    _starIndex = widget.item.starslevel;
    phoneNumController.text = widget.item.phone;
    _selectedBirthdayDate = widget.item.birthday;
    _radioGroupA = widget.item.sex;
    careerController.text = widget.item.occupation;
    mapController.text = widget.item.address;
    likeController.text = widget.item.hobby;
    incomeMinCount = widget.item.income;

    _getUserInfo();
    super.initState();
  }

  // 防止页面销毁时内存泄漏造成性能问题
  @override
  void dispose(){
    phoneNumController.dispose();
    userNameController.dispose();
    careerController.dispose();
    mapController.dispose();
    likeController.dispose();
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
                                        child: Text('修改'+widget.item.userName+"的基本信息",style: TextStyle(
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
                          // 客户姓名
                          Container(
                            width: 335,
                            child: Text(
                              '客户姓名：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入客户姓名",
                            tipText: "请输入客户姓名",
                            errorTipText: "请输入客户姓名",
                            rightText: "请输入客户姓名",
                            controller: userNameController,
                            inputType: TextInputType.text,
                            reg: nameReg,
                            onChanged: (text){
                              setState(() {
                                userName = text;
                                userNameBool = nameReg.hasMatch(userName);
                              });
                            },
                          ),
                          // 重要度
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '重要度：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _starIndex=1;
                                          });
                                        },
                                        child: Container(
                                            width: 39,
                                            height: 25,
                                            padding: EdgeInsets.only(right: 15),
                                            child: _starIndex ==0 ?
                                            Image(image: AssetImage('images/star1_e.png'),fit: BoxFit.fill,):
                                            Image(image: AssetImage('images/star1_big.png'),fit: BoxFit.fill,)
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _starIndex=2;
                                          });
                                        },
                                        child: Container(
                                            width: 39,
                                            height: 25,
                                            padding: EdgeInsets.only(right: 15),
                                            child: _starIndex==2 ?
                                            Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                                :_starIndex==3 ?
                                            Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                                :
                                            Image(image: AssetImage('images/star2_e.png'),fit: BoxFit.fill,)
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            _starIndex=3;
                                          });
                                        },
                                        child: Container(
                                            width: 39,
                                            height: 25,
                                            padding: EdgeInsets.only(right: 15),
                                            child: _starIndex==3 ?
                                            Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                                :
                                            Image(image: AssetImage('images/star3_e.png'),fit: BoxFit.fill,)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 客户手机号
                          Container(
                            width: 335,
                            child: Text(
                              '客户手机号码：',
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
                            tipText: "请输入客户的手机号码",
                            errorTipText: "请输入格式正确的手机号码",
                            rightText: "手机号码格式正确",
                            controller: phoneNumController,
                            inputType: TextInputType.phone,
                            reg: phoneReg,
                            onChanged: (text){
                              setState(() {
                                phoneNum = text;
                                phoneBool = phoneReg.hasMatch(phoneNum);
                              });
                            },
                          ),
                          // 客户生日
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 25),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '客户生日 ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  '( 修改前日期为'+widget.item.birthday.toString().substring(0,10)+' ) ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  '：',
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
                            width: 260,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(1940),
                              lastDate: DateTime(2030, 1, 1),
                              initialDate: DateTime(1980),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedBirthdayDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),
                          // 客户性别
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '客户性别：',
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
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged,
                                  title: Text('男'),
                                  selected: _radioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged,
                                  title: Text('女'),
                                  selected: _radioGroupA == 1,
                                ),
                              ],
                            ),
                          ),
                          // 客户职业
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '客户职业（非必填）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Input(
                            hintText: "请输入客户的职业",
                            tipText: "请输入客户的职业",
                            errorTipText: "请输入客户的职业",
                            rightText: "请输入客户的职业",
                            controller: careerController,
                            inputType: TextInputType.text,
                            reg: careerReg,
                            onChanged: (text){
                              setState(() {
                                career = text;
                                careerBool = careerReg.hasMatch(career);
                              });
                            },
                          ),
                          // 客户年收入
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '客户年收入（ 修改前年收入为'+widget.item.income+'）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 120,
                            margin: EdgeInsets.only(top: 18),
                            child: WheelChooser(
                              onValueChanged: (s){
                                setState(() {
                                  incomeMinCount = s;
                                });
                              },
                              datas: ["10万以下", "10万-30万", "30万-50万", "50万-100万","100万-500万", "500万-1000万", "1000万以上","未知"],
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
                          // 客户住址
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '客户住址（非必填）：',
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
                                hintText:'请填写客户的常用住址，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // 客户爱好
                          Container(
                            width: 335,
                            child: Text(
                              '客户爱好（非必填）：',
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
                              controller: likeController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onLikeChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写客户的爱好，提供选择维护礼物的灵感',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              if(userNameController.text != '' && phoneNumController.text != '' && _starIndex != 0 ){
                                _onRefresh();
                                var addResult = await UpdateCustomerDao.updateCustomer(
                                    widget.item.mid.toString(),
                                    userData.companyId,
                                    userData.userPid,
                                    "5",
                                    userNameController.text,
                                    _radioGroupA.toString(),
                                    phoneNumController.text,
                                    _selectedBirthdayDate.toIso8601String(),
                                    _starIndex.toString(),
                                    careerController.text==null?"未知":careerController.text,
                                    incomeMinCount,
                                    likeController.text==null?"未知":likeController.text,
                                    widget.item.remark,
                                    mapController.text==null?"未知":mapController.text,
                                    [],
                                    [],
                                );
                                if (addResult.code == 200) {
                                  _onRefresh();
                                  var getItem = await GetCustomerInfoDao.getCustomerInfo(widget.item.mid.toString());
                                  if(getItem.code == 200){
                                    _onRefresh();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TradedDetailPage(
                                      item:getItem.data[0],
                                      tabIndex: 0,
                                    )));
                                  }else {
                                    _onRefresh();
                                    _onOverLoadPressed(context);
                                  }
                                } else if(addResult.code == 400){
                                  _onRefresh();
                                  _onPhoneRePressed(context);
                                }else {
                                  _onRefresh();
                                  _onOverLoadPressed(context);
                                }
                              }else{
                                // 必填信息不完整的弹窗
                                _onMsgPressed(context);
                              }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 40),
                                decoration: userNameController.text != '' && phoneNumController.text != '' && _starIndex != 0?
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
  _onMsgPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "必填信息还未填写完整",
      desc: "请确认客户姓名、重要度、手机号码是否正确填写",
      buttons: [
        DialogButton(
          child: Text(
            "知道了",
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

  _onPhoneRePressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "您的客户名单中已有客户使用此手机号码，每个手机号仅能对应一位客户，请更换手机号码后重试",
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
  _onMapChanged(String text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
      });
    }
  }
  _onLikeChanged(String text){
    if(text != null){
      setState(() {
        likeBool = likeReg.hasMatch(likeController.text);
      });
    }
  }
}


