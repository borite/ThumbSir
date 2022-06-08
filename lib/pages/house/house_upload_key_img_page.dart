import 'dart:convert';
import 'dart:io';
import 'package:ThumbSir/dao/get_direct_sgin_dao.dart';
import 'package:ThumbSir/dao/update_key_images_dao.dart';
import 'package:ThumbSir/dao/update_key_user_dao.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:image/image.dart' as IMG;
import 'package:ThumbSir/pages/house/house_list_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class HouseUploadKeyImgPage extends StatefulWidget {
  final houseId;
  HouseUploadKeyImgPage({Key key,
    this.houseId
  }):super(key:key);
  @override
  _HouseUploadKeyImgPageState createState() => _HouseUploadKeyImgPageState();
}

class _HouseUploadKeyImgPageState extends State<HouseUploadKeyImgPage> {
  bool _loading = false;
  DateTime _selectedSellStartDate=DateTime(2021,1,1);
  DateTime _selectedSellStopDate=DateTime(2021,1,1);

  //多选图片插件，选取的图片list
  List<Media> _listImagePaths=List();

  // 钥匙照片
  List _keyImages=[];
  // 协议照片
  List _dealImages=[];
  //传入的图片
  List inKeyImgs=[];
  List inDealImgs=[];


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

  //多选图片初始设定
  // 钥匙照片
  Future<void> selectKeyImages() async {
    try{
      _listImagePaths=await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          showGif:false,
          selectCount:10,
          showCamera:true,
          cropConfig: CropConfig(enableCrop: false,width: 1,height: 1),
          compressSize: 1536,
          uiConfig: UIConfig(uiThemeColor: Color(0xFF5580EB))   //UIConfig
      );

      setState(() {
        _listImagePaths.forEach((element) {
          print(element.path.toString());
          _keyImages.add(File(element.path));
        });
      });
    }on PlatformException{

    }
  }
  // 协议照片
  Future<void> selectDealImages() async {
    try{
      _listImagePaths=await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          showGif:false,
          selectCount:10,
          showCamera:true,
          cropConfig: CropConfig(enableCrop: false,width: 1,height: 1),
          compressSize: 1536,
          uiConfig: UIConfig(uiThemeColor: Color(0xFF5580EB))   //UIConfig
      );

      setState(() {
        _listImagePaths.forEach((element) {
          print(element.path.toString());
          _dealImages.add(File(element.path));
        });
      });
    }on PlatformException{

    }
  }

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
                                        child: Text('上传钥匙照片',style: TextStyle(
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
                            child: Text(
                              '温馨提示：为展示效果，图片均会剪辑为16:9格式',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFF24848),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          // 钥匙照片
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '钥匙照片：',
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
                                    selectKeyImages();
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
                                      child: _keyImages.length == 0 &&inKeyImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                      inKeyImgs.length >= 1?Image(image: NetworkImage(inKeyImgs[0]),fit: BoxFit.fill):
                                      _keyImages.length>=1?Image.file(_keyImages[0],fit: BoxFit.fill,)
                                          :Image.file(_keyImages[0],fit: BoxFit.fill,)
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
                                    child: _keyImages.length == 0 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        : _keyImages.length == 1 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        :_keyImages.length == 2 && _keyImages[1].toString().contains('https')?
                                    Image(image: NetworkImage(_keyImages[1]),fit:BoxFit.fill,)
                                        : _keyImages[1] is File && _keyImages.length==2 ?
                                    Image.file(_keyImages[1],fit: BoxFit.fill,)
                                        :
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          inKeyImgs.length > 1 ? Image(image: NetworkImage(inKeyImgs[1]),fit:BoxFit.fill,)
                                              : _keyImages.length>1?Image.file(_keyImages[1],fit: BoxFit.fill,)
                                              : Image(image: AssetImage('images/camera.png')),
                                          Container(width: 90,height: 90,color: Colors.black45,),
                                          Text("+"+(_keyImages.length-1).toString(),
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

                          // 协议照片
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20,bottom: 10),
                            child: Text(
                              '钥匙委托协议照片：',
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
                                    selectDealImages();
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
                                      child: _dealImages.length == 0 && inDealImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                      inDealImgs.length >= 1?Image(image: NetworkImage(inDealImgs[0]),fit: BoxFit.fill):
                                      _dealImages.length>=1?Image.file(_dealImages[0],fit: BoxFit.fill,)
                                          :Image.file(_dealImages[0],fit: BoxFit.fill,)
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
                                    child: _dealImages.length == 0 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        : _dealImages.length == 1 ?
                                    Image(image: AssetImage('images/camera.png'),)
                                        :_dealImages.length == 2 && _dealImages[1].toString().contains('https')?
                                    Image(image: NetworkImage(_dealImages[1]),fit:BoxFit.fill,)
                                        : _dealImages[1] is File && _dealImages.length==2 ?
                                    Image.file(_dealImages[1],fit: BoxFit.fill,)
                                        :
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          inDealImgs.length > 1 ? Image(image: NetworkImage(inDealImgs[1]),fit:BoxFit.fill,)
                                              : _dealImages.length>1?Image.file(_dealImages[1],fit: BoxFit.fill,)
                                              : Image(image: AssetImage('images/camera.png')),
                                          Container(width: 90,height: 90,color: Colors.black45,),
                                          Text("+"+(_dealImages.length-1).toString(),
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
                          // 协议起始时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '钥匙委托协议起始时间：',
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
                          // 协议到期时间
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              '钥匙委托协议到期时间：',
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

                          // 完成
                          GestureDetector(
                            onTap: ()async{
                              _onRefresh();
                              //获取签名
                              var sign = await GetDirectSignDao.httpGetSign('aabbcc', '4');
                              //上传成功后，存储返回的业主身份证链接。
                              String keyImgs="";
                              String dealImgs="";

                              Dio dio = new Dio();
                              //钥匙照片已选择
                              if(_keyImages.length>0) {
                                //遍历重新上传的图片
                                for (var imgFile in _keyImages) {
                                  String fName = imgFile
                                      .toString()
                                      .split('/')
                                      .last;
                                  print(fName);
                                  final tempDir = await getTemporaryDirectory();
                                  final path = tempDir.path;
                                  //压缩图片开始
                                  IMG.Image compressImg = IMG.decodeImage(imgFile.readAsBytesSync());
                                  IMG.Image smallerImg = IMG.copyResize(compressImg, height: 1280);
                                  final compressedImageFile = new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg));

                                  //压缩图片结束
                                  //文件名去除连接符
                                  fName = fName.replaceAll('-', '');
                                  //文件名去除单引号
                                  fName = fName.replaceAll("'", '');
                                  //文件名转化为小写
                                  fName = fName.toLowerCase();
                                  if (sign.code == 200) {

                                    FormData formData = new FormData.fromMap({
                                      "OSSAccessKeyId": sign.data.accessId,
                                      "policy": sign.data.policy,
                                      "signature": sign.data.signature,
                                      "key": sign.data.dir + fName,
                                      "success_action_status": "200",
                                      "file": await MultipartFile.fromFile(
                                          compressedImageFile.path,
                                          filename: fName)
                                    });
                                    try {
                                      //上传图片文件
                                      Response res = await dio.post(
                                          'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                                          data: formData);
                                      //返回为200的时候，说明成功，会返回照片链接，多张图片请组织链接数据
                                      if (res.statusCode == 200) {
                                            print("上传照片成功");
                                            print("照片链接：" + sign.data.finalUrl.split('aabbcc')[0]+fName);
                                            keyImgs+=sign.data.finalUrl.split('aabbcc')[0]+fName+"|";
                                            print("户型图上传完成！");
                                            print(keyImgs);
                                          }
                                      } on DioError catch (e) {
                                          print(e.response);
                                      }
                                  }
                                }

                              }
                              //协议照片已选择
                              if(_dealImages.length>0) {
                                //遍历重新上传的图片
                                for (var imgFile in _dealImages) {
                                  String fName = imgFile
                                      .toString()
                                      .split('/')
                                      .last;
                                  print(fName);
                                  final tempDir = await getTemporaryDirectory();
                                  final path = tempDir.path;
                                  //压缩图片开始
                                  IMG.Image compressImg = IMG.decodeImage(imgFile.readAsBytesSync());
                                  IMG.Image smallerImg = IMG.copyResize(compressImg, height: 1280);
                                  final compressedImageFile = new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg));
                                  print('压缩完的东西');
                                  print(compressedImageFile);
                                  //压缩图片结束
                                  //文件名去除连接符
                                  fName = fName.replaceAll('-', '');
                                  //文件名去除单引号
                                  fName = fName.replaceAll("'", '');
                                  //文件名转化为小写
                                  fName = fName.toLowerCase();
                                  if (sign.code == 200) {
                                    print(sign.data.accessId);
                                    FormData formData = new FormData.fromMap({
                                      "OSSAccessKeyId": sign.data.accessId,
                                      "policy": sign.data.policy,
                                      "signature": sign.data.signature,
                                      "key": sign.data.dir + fName,
                                      "success_action_status": "200",
                                      "file": await MultipartFile.fromFile(
                                          compressedImageFile.path,
                                          filename: fName)
                                    });
                                    try {
                                      //上传图片文件
                                      Response res = await dio.post(
                                          'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                                          data: formData);
                                      //返回为200的时候，说明成功，会返回照片链接，多张图片请组织链接数据
                                      if (res.statusCode == 200) {
                                        print(sign.data.finalUrl+fName);
                                        //print("照片链接：" + sign.data.finalUrl.split('aabbcc')[0]+fName);
                                        dealImgs+=sign.data.finalUrl.split('aabbcc')[0]+fName+"|";
                                        print("房本照片上传完成！");
                                        print(sign.data.finalUrl+fName);
                                        print(dealImgs);
                                      }
                                    } on DioError catch (e) {
                                      print(e.response);
                                    }
                                  }
                                }
                                print(dealImgs);
                              }

                              var allKeyImages = keyImgs+dealImgs;


                              var addImgsResult = await UpdateKeyImagesDao.updateKeyImages(
                                  widget.houseId.toString(),
                                  userData.userPid,
                                allKeyImages,
                                _selectedSellStartDate.toString(),
                                _selectedSellStopDate.toString(),
                              );
                              print(addImgsResult);
                              if (addImgsResult.code == 200) {
                                var updateKeyUserResult = await UpdateKeyUserDao
                                    .updateKeyUser(
                                  widget.houseId.toString(),
                                  userData.userPid,
                                );
                                print(updateKeyUserResult);
                                if (updateKeyUserResult.code == 200) {
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
                                };
                              } else {
                                _onRefresh();
                                // _onOverLoadPressed(context);
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


