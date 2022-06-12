import 'dart:convert';
import 'dart:io';
import 'package:ThumbSir/dao/get_direct_sgin_dao.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class HouseEditOwnerMsgPage extends StatefulWidget {
  final houseId;
  final houseDetail;
  HouseEditOwnerMsgPage({Key? key,
    this.houseId,this.houseDetail
  }):super(key:key);
  @override
  _HouseEditOwnerMsgPageState createState() => _HouseEditOwnerMsgPageState();
}

class _HouseEditOwnerMsgPageState extends State<HouseEditOwnerMsgPage> {
  bool _loading = false;

  DateTime _selectedSellStartDate=DateTime(2021,1,1);
  DateTime _selectedSellStopDate=DateTime(2021,1,1);
  DateTime _selectedOnlySellStartDate=DateTime(2021,1,1);
  DateTime _selectedOnlySellStopDate=DateTime(2021,1,1);

  int _radioGroupA = 0;


  // 身份证照片
  List _idCardImages=[];
  //传入的图片
  List inIdCardImgs=[];

  // 房本照片
  List _houseImages=[];
  //传入的图片
  List inHouseImgs=[];

  // 出售委托协议照片
  List _sellImages=[];
  //传入的图片
  List inSellImgs=[];

  // 独家出售委托协议照片
  List _onlySellImages=[];
  //传入的图片
  List inOnlySellImgs=[];

  _handleRadioValueChanged(int value) {
    setState(() {
      _radioGroupA = value;
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

  //多选图片插件，选取的图片list
  // List<Media> _listImagePaths=List();

  //多选图片初始设定
  // 身份证照片
  // Future<void> selectIdCardImages() async {
    // try{
    //   _listImagePaths=await ImagePickers.pickerPaths(
    //       galleryMode: GalleryMode.image,
    //       showGif:false,
    //       selectCount:10,
    //       showCamera:true,
    //       cropConfig: CropConfig(enableCrop: false,width: 1,height: 1),
    //       compressSize: 1536,
    //       uiConfig: UIConfig(uiThemeColor: Color(0xFF5580EB))   //UIConfig
    //   );
    //
    //   setState(() {
    //     _listImagePaths.forEach((element) {
    //       print(element.path.toString());
    //       _idCardImages.add(File(element.path));
    //     });
    //   });
    // }on PlatformException{
    //
    // }
  // }
  // 房本照片
  // Future<void> selectHouseImages() async {
  //   try{
  //     _listImagePaths=await ImagePickers.pickerPaths(
  //         galleryMode: GalleryMode.image,
  //         showGif:false,
  //         selectCount:10,
  //         showCamera:true,
  //         cropConfig: CropConfig(enableCrop: false,width: 1,height: 1),
  //         compressSize: 1536,
  //         uiConfig: UIConfig(uiThemeColor: Color(0xFF5580EB))   //UIConfig
  //     );
  //
  //     setState(() {
  //       _listImagePaths.forEach((element) {
  //         print(element.path.toString());
  //         _houseImages.add(File(element.path));
  //       });
  //     });
  //   }on PlatformException{
  //
  //   }
  // }
  // // 出售委托协议照片
  // Future<void> selectSellImages() async {
  //   try{
  //     _listImagePaths=await ImagePickers.pickerPaths(
  //         galleryMode: GalleryMode.image,
  //         showGif:false,
  //         selectCount:10,
  //         showCamera:true,
  //         cropConfig: CropConfig(enableCrop: false,width: 1,height: 1),
  //         compressSize: 1536,
  //         uiConfig: UIConfig(uiThemeColor: Color(0xFF5580EB))   //UIConfig
  //     );
  //
  //     setState(() {
  //       _listImagePaths.forEach((element) {
  //         print(element.path.toString());
  //         _sellImages.add(File(element.path));
  //       });
  //     });
  //   }on PlatformException{
  //
  //   }
  // }
  // // 独家委托协议照片
  // Future<void> selectOnlySellImages() async {
  //   try{
  //     _listImagePaths=await ImagePickers.pickerPaths(
  //         galleryMode: GalleryMode.image,
  //         showGif:false,
  //         selectCount:10,
  //         showCamera:true,
  //         cropConfig: CropConfig(enableCrop: false,width: 1,height: 1),
  //         compressSize: 1536,
  //         uiConfig: UIConfig(uiThemeColor: Color(0xFF5580EB))   //UIConfig
  //     );
  //
  //     setState(() {
  //       _listImagePaths.forEach((element) {
  //         print(element.path.toString());
  //         _onlySellImages.add(File(element.path));
  //       });
  //     });
  //   }on PlatformException{
  //
  //   }
  // }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  void dispose(){
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
                                        child: Text('完善业主隐私信息',style: TextStyle(
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

                          // 温馨提示
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '以下信息仅维护人可编辑，且仅对维护人及其直属上级可见',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFF24848),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          // 业主身份证照片
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '业主身份证照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 335,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap:() {
                                    // selectIdCardImages();
                                    //_pickImage();
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 25,bottom: 5),
                                          child: Image(image: AssetImage('images/camera.png'),),
                                        ),
                                        Text('点击上传',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _idCardImages.length == 0 &&inIdCardImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                      inIdCardImgs.length >= 1?Image(image: NetworkImage(inIdCardImgs[0]),fit: BoxFit.fill):
                                      _idCardImages.length>=1?Image.file(_idCardImages[0],fit: BoxFit.fill,)
                                          :Image.file(_idCardImages[0],fit: BoxFit.fill,)
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: _idCardImages.length == 0 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        : _idCardImages.length == 1 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        :_idCardImages.length == 2 && _idCardImages[1].toString().contains('https')?
                                    Image(image: NetworkImage(_idCardImages[1]),fit:BoxFit.fill,)
                                        : _idCardImages[1] is File && _idCardImages.length==2 ?
                                    Image.file(_idCardImages[1],fit: BoxFit.fill,)
                                        :
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          inIdCardImgs.length > 1 ? Image(image: NetworkImage(inIdCardImgs[1]),fit:BoxFit.fill,)
                                              : _idCardImages.length>1?Image.file(_idCardImages[1],fit: BoxFit.fill,)
                                              : Image(image: AssetImage('images/camera.png')),
                                          Container(width: 90,height: 90,color: Colors.black45,),
                                          Text("+"+(_idCardImages.length-1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                            textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 房本照片
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '房本照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 335,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap:() {
                                    // selectHouseImages();
                                    //_pickImage();
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 25,bottom: 5),
                                          child: Image(image: AssetImage('images/camera.png'),),
                                        ),
                                        Text('点击上传',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _houseImages.length == 0 && inHouseImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                      inHouseImgs.length >= 1?Image(image: NetworkImage(inHouseImgs[0]),fit: BoxFit.fill):
                                      _houseImages.length>=1?Image.file(_houseImages[0],fit: BoxFit.fill,)
                                          :Image.file(_houseImages[0],fit: BoxFit.fill,)
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: _houseImages.length == 0 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        : _houseImages.length == 1 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        :_houseImages.length == 2 && _houseImages[1].toString().contains('https')?
                                    Image(image: NetworkImage(_houseImages[1]),fit:BoxFit.fill,)
                                        : _houseImages[1] is File && _houseImages.length==2 ?
                                    Image.file(_houseImages[1],fit: BoxFit.fill,)
                                        :
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          inHouseImgs.length > 1 ? Image(image: NetworkImage(inHouseImgs[1]),fit:BoxFit.fill,)
                                              : _houseImages.length>1?Image.file(_houseImages[1],fit: BoxFit.fill,)
                                              : Image(image: AssetImage('images/camera.png')),
                                          Container(width: 90,height: 90,color: Colors.black45,),
                                          Text("+"+(_houseImages.length-1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                            textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 是否签署了出售委托协议
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '出售委托协议签署情况：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 335,
                            padding: EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioListTile(
                                  value: 0,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged(0),
                                  title: Text('暂未签署出售委托协议'),
                                  selected: _radioGroupA == 0,
                                ),
                                RadioListTile(
                                  value: 1,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged(1),
                                  title: Text('已签署出售委托协议'),
                                  selected: _radioGroupA == 1,
                                ),
                                RadioListTile(
                                  value: 2,
                                  groupValue: _radioGroupA,
                                  onChanged: _handleRadioValueChanged(2),
                                  title: Text('已签署独家出售委托协议'),
                                  selected: _radioGroupA == 2,
                                ),
                              ],
                            ),
                          ),
                          // 出售委托协议
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '出售委托协议照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 335,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap:() {
                                    // selectSellImages();
                                    //_pickImage();
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 25,bottom: 5),
                                          child: Image(image: AssetImage('images/camera.png'),),
                                        ),
                                        Text('点击上传',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _sellImages.length == 0 && inSellImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                      inSellImgs.length >= 1?Image(image: NetworkImage(inSellImgs[0]),fit: BoxFit.fill):
                                      _sellImages.length>=1?Image.file(_sellImages[0],fit: BoxFit.fill,)
                                          :Image.file(_sellImages[0],fit: BoxFit.fill,)
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: _sellImages.length == 0 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        : _sellImages.length == 1 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        :_sellImages.length == 2 && _sellImages[1].toString().contains('https')?
                                    Image(image: NetworkImage(_sellImages[1]),fit:BoxFit.fill,)
                                        : _sellImages[1] is File && _sellImages.length==2 ?
                                    Image.file(_sellImages[1],fit: BoxFit.fill,)
                                        :
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          inSellImgs.length > 1 ? Image(image: NetworkImage(inSellImgs[1]),fit:BoxFit.fill,)
                                              : _sellImages.length>1?Image.file(_sellImages[1],fit: BoxFit.fill,)
                                              : Image(image: AssetImage('images/camera.png')),
                                          Container(width: 90,height: 90,color: Colors.black45,),
                                          Text("+"+(_sellImages.length-1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                            textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 出售委托协议起始时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '出售委托协议起始时间：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2040, 1, 1),
                              initialDate: DateTime(2021),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedSellStartDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),
                          // 出售委托协议到期时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '出售委托协议到期时间：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2040, 1, 1),
                              initialDate: DateTime(2021),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedSellStopDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),

                          // 独家委托协议
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '独家委托协议照片：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 335,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap:() {
                                    // selectOnlySellImages();
                                    //_pickImage();
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 25,bottom: 5),
                                          child: Image(image: AssetImage('images/camera.png'),),
                                        ),
                                        Text('点击上传',style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _onlySellImages.length == 0 && inOnlySellImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                      inOnlySellImgs.length >= 1?Image(image: NetworkImage(inOnlySellImgs[0]),fit: BoxFit.fill):
                                      _onlySellImages.length>=1?Image.file(_onlySellImages[0],fit: BoxFit.fill,)
                                          :Image.file(_onlySellImages[0],fit: BoxFit.fill,)
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: _onlySellImages.length == 0 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        : _onlySellImages.length == 1 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        :_onlySellImages.length == 2 && _onlySellImages[1].toString().contains('https')?
                                    Image(image: NetworkImage(_onlySellImages[1]),fit:BoxFit.fill,)
                                        : _onlySellImages[1] is File && _onlySellImages.length==2 ?
                                    Image.file(_onlySellImages[1],fit: BoxFit.fill,)
                                        :
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          inOnlySellImgs.length > 1 ? Image(image: NetworkImage(inOnlySellImgs[1]),fit:BoxFit.fill,)
                                              : _onlySellImages.length>1?Image.file(_onlySellImages[1],fit: BoxFit.fill,)
                                              : Image(image: AssetImage('images/camera.png')),
                                          Container(width: 90,height: 90,color: Colors.black45,),
                                          Text("+"+(_onlySellImages.length-1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              decoration: TextDecoration.none,
                                            ),
                                            textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 独家委托协议起始时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '独家委托协议起始时间：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2040, 1, 1),
                              initialDate: DateTime(2021),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedOnlySellStartDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),
                          // 独家委托协议到期时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '独家委托协议到期时间：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            child: DatePickerWidget(
                              looping: true, // default is not looping
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2040, 1, 1),
                              initialDate: DateTime(2021),
                              dateFormat: "yyyy年-MMMM月-dd日",
                              locale: DatePicker.localeFromString('zh'),
                              onChange: (DateTime newDate, _) => _selectedOnlySellStopDate = newDate,
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: TextStyle(color: Color(0xFF5580EB), fontSize: 18),
                                dividerColor: Color(0xFF5580EB),
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              //获取签名
                              var sign = await GetDirectSignDao.httpGetSign('aabbcc', '4');
                              //上传成功后，存储返回的业主身份证链接。
                              String idImgs="";
                              String houseImgs="";
                              String sellImgs="";
                              String onlySellImgs = "";



                              Dio dio = new Dio();
                              //业主身份证照片已选择
                              if(_idCardImages.length>0) {
                                //遍历重新上传的图片
                                for (var imgFile in _idCardImages) {
                                  String fName = imgFile
                                      .toString()
                                      .split('/')
                                      .last;
                              //     print(fName);
                              //     final tempDir = await getTemporaryDirectory();
                              //     final path = tempDir.path;
                              //     //压缩图片开始
                              //     IMG.Image compressImg = IMG.decodeImage(imgFile.readAsBytesSync());
                              //     IMG.Image smallerImg = IMG.copyResize(compressImg, height: 1280);
                              //     final compressedImageFile = new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg));
                              //     print('压缩完的东西');
                              //     print(compressedImageFile);
                              //     //压缩图片结束
                              //     //文件名去除连接符
                              //     fName = fName.replaceAll('-', '');
                              //     //文件名去除单引号
                              //     fName = fName.replaceAll("'", '');
                              //     //文件名转化为小写
                              //     fName = fName.toLowerCase();
                              //     if (sign.code == 200) {
                              //       print(sign.data.accessId);
                              //       FormData formData = new FormData.fromMap({
                              //         "OSSAccessKeyId": sign.data.accessId,
                              //         "policy": sign.data.policy,
                              //         "signature": sign.data.signature,
                              //         "key": sign.data.dir + fName,
                              //         "success_action_status": "200",
                              //         "file": await MultipartFile.fromFile(
                              //             compressedImageFile.path,
                              //             filename: fName)
                              //       });
                              //       try {
                              //         //上传图片文件
                              //         Response res = await dio.post(
                              //             'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                              //             data: formData);
                              //         //返回为200的时候，说明成功，会返回照片链接，多张图片请组织链接数据
                              //         if (res.statusCode == 200) {
                              //               print("上传照片成功");
                              //               print("照片链接：" + sign.data.finalUrl.split('aabbcc')[0]+fName);
                              //               idImgs+=sign.data.finalUrl.split('aabbcc')[0]+fName+"|";
                              //             }
                              //         } on DioError catch (e) {
                              //             print(e.response);
                              //         }
                              //     }
                              //   }
                              //   print(idImgs);
                              // }
                              // //房本照片已选择
                              // if(_houseImages.length>0) {
                              //   //遍历重新上传的图片
                              //   for (var imgFile in _houseImages) {
                              //     String fName = imgFile
                              //         .toString()
                              //         .split('/')
                              //         .last;
                              //     print(fName);
                              //     final tempDir = await getTemporaryDirectory();
                              //     final path = tempDir.path;
                              //     //压缩图片开始
                              //     IMG.Image compressImg = IMG.decodeImage(imgFile.readAsBytesSync());
                              //     IMG.Image smallerImg = IMG.copyResize(compressImg, height: 1280);
                              //     final compressedImageFile = new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg));
                              //     print('压缩完的东西');
                              //     print(compressedImageFile);
                              //     //压缩图片结束
                              //     //文件名去除连接符
                              //     fName = fName.replaceAll('-', '');
                              //     //文件名去除单引号
                              //     fName = fName.replaceAll("'", '');
                              //     //文件名转化为小写
                              //     fName = fName.toLowerCase();
                              //     if (sign.code == 200) {
                              //       print(sign.data.accessId);
                              //       FormData formData = new FormData.fromMap({
                              //         "OSSAccessKeyId": sign.data.accessId,
                              //         "policy": sign.data.policy,
                              //         "signature": sign.data.signature,
                              //         "key": sign.data.dir + fName,
                              //         "success_action_status": "200",
                              //         "file": await MultipartFile.fromFile(
                              //             compressedImageFile.path,
                              //             filename: fName)
                              //       });
                              //       try {
                              //         //上传图片文件
                              //         Response res = await dio.post(
                              //             'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                              //             data: formData);
                              //         //返回为200的时候，说明成功，会返回照片链接，多张图片请组织链接数据
                              //         if (res.statusCode == 200) {
                              //           print("上传照片成功");
                              //           print("照片链接：" + sign.data.finalUrl.split('aabbcc')[0]+fName);
                              //           houseImgs+=sign.data.finalUrl.split('aabbcc')[0]+fName+"|";
                              //         }
                              //       } on DioError catch (e) {
                              //         print(e.response);
                              //       }
                              //     }
                              //   }
                              //   print(houseImgs);
                              // }
                              // //出售委托协议照片已选择
                              // if(_sellImages.length>0) {
                              //   //遍历重新上传的图片
                              //   for (var imgFile in _sellImages) {
                              //     String fName = imgFile
                              //         .toString()
                              //         .split('/')
                              //         .last;
                              //     print(fName);
                              //     final tempDir = await getTemporaryDirectory();
                              //     final path = tempDir.path;
                              //     //压缩图片开始
                              //     IMG.Image compressImg = IMG.decodeImage(imgFile.readAsBytesSync());
                              //     IMG.Image smallerImg = IMG.copyResize(compressImg, height: 1280);
                              //     final compressedImageFile = new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg));
                              //     print('压缩完的东西');
                              //     print(compressedImageFile);
                              //     //压缩图片结束
                              //     //文件名去除连接符
                              //     fName = fName.replaceAll('-', '');
                              //     //文件名去除单引号
                              //     fName = fName.replaceAll("'", '');
                              //     //文件名转化为小写
                              //     fName = fName.toLowerCase();
                              //     if (sign.code == 200) {
                              //       print(sign.data.accessId);
                              //       FormData formData = new FormData.fromMap({
                              //         "OSSAccessKeyId": sign.data.accessId,
                              //         "policy": sign.data.policy,
                              //         "signature": sign.data.signature,
                              //         "key": sign.data.dir + fName,
                              //         "success_action_status": "200",
                              //         "file": await MultipartFile.fromFile(
                              //             compressedImageFile.path,
                              //             filename: fName)
                              //       });
                              //       try {
                              //         //上传图片文件
                              //         Response res = await dio.post(
                              //             'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                              //             data: formData);
                              //         //返回为200的时候，说明成功，会返回照片链接，多张图片请组织链接数据
                              //         if (res.statusCode == 200) {
                              //           print("上传照片成功");
                              //           print("照片链接：" + sign.data.finalUrl.split('aabbcc')[0]+fName);
                              //           sellImgs+=sign.data.finalUrl.split('aabbcc')[0]+fName+"|";
                              //         }
                              //       } on DioError catch (e) {
                              //         print(e.response);
                              //       }
                              //     }
                              //   }
                              //   print(sellImgs);
                              // }
                              // //独家出售委托协议照片已选择
                              // if(_onlySellImages.length>0) {
                              //   //遍历重新上传的图片
                              //   for (var imgFile in _onlySellImages) {
                              //     String fName = imgFile
                              //         .toString()
                              //         .split('/')
                              //         .last;
                              //     print(fName);
                              //     final tempDir = await getTemporaryDirectory();
                              //     final path = tempDir.path;
                              //     //压缩图片开始
                              //     IMG.Image compressImg = IMG.decodeImage(imgFile.readAsBytesSync());
                              //     IMG.Image smallerImg = IMG.copyResize(compressImg, height: 1280);
                              //     final compressedImageFile = new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg));
                              //     print('压缩完的东西');
                              //     print(compressedImageFile);
                              //     //压缩图片结束
                              //     //文件名去除连接符
                              //     fName = fName.replaceAll('-', '');
                              //     //文件名去除单引号
                              //     fName = fName.replaceAll("'", '');
                              //     //文件名转化为小写
                              //     fName = fName.toLowerCase();
                              //     if (sign.code == 200) {
                              //       print(sign.data.accessId);
                              //       FormData formData = new FormData.fromMap({
                              //         "OSSAccessKeyId": sign.data.accessId,
                              //         "policy": sign.data.policy,
                              //         "signature": sign.data.signature,
                              //         "key": sign.data.dir + fName,
                              //         "success_action_status": "200",
                              //         "file": await MultipartFile.fromFile(
                              //             compressedImageFile.path,
                              //             filename: fName)
                              //       });
                              //       try {
                              //         //上传图片文件
                              //         Response res = await dio.post(
                              //             'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                              //             data: formData);
                              //         //返回为200的时候，说明成功，会返回照片链接，多张图片请组织链接数据
                              //         if (res.statusCode == 200) {
                              //           print("上传照片成功");
                              //           print("照片链接：" + sign.data.finalUrl.split('aabbcc')[0]+fName);
                              //           onlySellImgs+=sign.data.finalUrl.split('aabbcc')[0]+fName+"|";
                              //         }
                              //       } on DioError catch (e) {
                              //         print(e.response);
                              //       }
                              //     }
                              //   }
                              //   print(onlySellImgs);
                              // }
                              //
                              // _onRefresh();
                              // var addResult = await AddHouseStep4Dao
                              //     .addHouseStep4(
                              //     widget.houseId,
                              //     idImgs,  // _idCardImages.toString(),
                              //     houseImgs,
                              //     sellImgs,
                              //     _selectedSellStartDate.toString(),
                              //     _selectedSellStopDate.toString(),
                              //     onlySellImgs,
                              //     _selectedOnlySellStartDate.toString(),
                              //     _selectedOnlySellStopDate.toString(),
                              // );
                              // print(addResult);
                              // if (addResult.code == 200 ||
                              //     addResult.code == 201) {
                              //   _onRefresh();
                              //   if (userData.userLevel.substring(0, 1) == "6") {
                              //     Navigator.push(context, MaterialPageRoute(
                              //         builder: (context) => HouseListPage()));
                              //   }
                              //   if (userData.userLevel.substring(0, 1) == "4") {
                              //     Navigator.push(context, MaterialPageRoute(
                              //         builder: (context) => STradedPage()));
                              //   }
                              //   if (userData.userLevel.substring(0, 1) == "5") {
                              //     Navigator.push(context, MaterialPageRoute(
                              //         builder: (context) => MTradedPage()));
                              //   }
                              // } else {
                              //   _onRefresh();
                              //   // _onOverLoadPressed(context);
                              //   // }
                              //   // }else{
                              //   //   // 必填信息不完整的弹窗
                              //   //   _onMsgPressed(context);
                              }
                              }
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
                                // )
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
}


