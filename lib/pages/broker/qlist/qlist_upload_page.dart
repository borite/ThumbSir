import 'dart:convert';
import 'dart:io';
// base64库
import 'dart:convert' as convert;
import 'dart:async';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/model/record_mission_model.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/major/qlist/major_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/s_qlist_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:ThumbSir/dao/get_direct_sgin_dao.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/dao/test_vi_dao.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:image/image.dart' as IMG;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';

class QListUploadPage extends StatefulWidget {
  final String name;
  final int star;
  final double percent;
  final String currentAddress;
  final String taskId;
  final String unit;
  final String defaultId;
  final startTime;
  final endTime;
  final int planCount;
  final String uploadImgs;

  QListUploadPage({Key key,
    this.uploadImgs,
    this.name,this.star,this.defaultId,this.planCount,
    this.percent,this.currentAddress,this.taskId,this.unit,
    this.startTime,this.endTime,
  }):super(key:key);
  @override
  _QListUploadPageState createState() => _QListUploadPageState();
}

class _QListUploadPageState extends State<QListUploadPage> {
  int _starIndex=0;
  List _images=[];
  var gps_place="正在定位...";
  final _picker = ImagePicker();
  bool isApplePhone=true;
  bool isModiPics=false;
  var _defaultTaskID;
  var _taskID;

  bool _loading = false;

  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }

  //传入的图片
  List inImgs=[];

  Map<String, Object> _loationResult;
  BaiduLocation _baiduLocation; // 定位结果
  StreamSubscription<Map<String, Object>> _locationListener;

  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

  Future pickImage(bool isTakePhoto) async {
    Navigator.pop(context);
    final image = await _picker.getImage(
        source: isTakePhoto?ImageSource.camera:ImageSource.gallery
    );
    final File img=File(image.path);
    setState(() {
      _images.add(img);
    });
  }

  _pickImage(){
    showModalBottomSheet(context: context, builder: (context)=>Container(
      height: 160,
      child: Column(
        children: <Widget>[
          _item("拍照",true),
          _item("从相册选择",false),
        ],
      ),
    ));
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
    if(userData == null || userData.companyId == null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("userInfo");
//      prefs.remove("userID");
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _starIndex = widget.star;
    /// 动态申请定位权限
    _locationPlugin.requestPermission();

    _defaultTaskID=widget.defaultId;
    _taskID=widget.taskId;

    // 这里应该放在onTap里，然后在点击的时候，上传新的图片，获取链接后存入inImgs，然后再整体上传。
    for(var s in widget.uploadImgs.split('|')){
      if(s!="") {
        inImgs.add(s);
        _images.add(s);
      }
    }


    //初始化定位
    /// 设置ios端ak, android端ak可以直接在清单文件中配置
    LocationFlutterPlugin.setApiKey("I5BY1VGekuRr9M6UkBhgG9FCC29LnUcP");

    _locationListener = _locationPlugin
        .onResultCallback()
        .listen((Map<String, Object> result) {
          setState(() {
            _loationResult = result;
            try {
              _baiduLocation = BaiduLocation.fromMap(result); // 将原生端返回的定位结果信息存储在定位结果类中

              if(Platform.isIOS){
                print("这里是苹果系统");
                gps_place=_baiduLocation.city+","+_baiduLocation.street;
              }else{
                //gps_place=_baiduLocation.province+","+_baiduLocation.city+","+_baiduLocation.district+_baiduLocation.locationDetail;
                gps_place=_baiduLocation.district+","+_baiduLocation.locationDetail;
              }
            } catch (e) {
              print("出特么错啦");
              print(e);
            }
          });
    });
    _startLocation();
  }

  _item(String title,bool isTakePhoto){
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: ()=>pickImage(isTakePhoto),
      ),
    );
  }

  // 防止页面销毁时内存泄漏造成性能问题
  @override
  void dispose(){
    super.dispose();
    if (null != _locationListener) {
      _locationListener.cancel(); // 停止定位
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loading: _loading,
        msg:"加载中...",
      child:Container(
        // 背景
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image:AssetImage('images/circle_middle.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                  children: <Widget>[
                    // 导航栏
                    Container(
                      padding: EdgeInsets.all(15),
                      child:Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('上传任务交付物照片',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        ],
                      ),
                    ),
                    // 完成百分比
                    Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.only(top: 30),
                      child: SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            startAngle: 280,
                            angleRange: 360,
                            customWidths: CustomSliderWidths(progressBarWidth: 12),
                            customColors: CustomSliderColors(
                              progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                              trackColor: Color(0x20CCCCCC),
                              dotColor: Colors.transparent,
                            ),
                            infoProperties: InfoProperties(
                                mainLabelStyle: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xFF2692FD),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                )
                            )
                        ),
                        min: 0,
                        max: 100,
                        initialValue: widget.percent*100,
                      ),
                    ),
                    // 重要度星星
                    Container(
                      width:175,
                      margin: EdgeInsets.only(left: 10,top: 20,bottom: 35),
                      child: Row(
                        children: <Widget>[
                          Container(
                              width:35,
                              height: 20,
                              padding: EdgeInsets.only(right: 15),
                              child: _starIndex ==0 ?
                              Image(image: AssetImage('images/star1_e.png'),fit: BoxFit.fill,):
                              Image(image: AssetImage('images/star1_big.png'),fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 35,
                              height: 20,
                              padding: EdgeInsets.only(right: 15),
                              child: _starIndex==2 ?
                              Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                  :_starIndex==3 ?
                              Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                  :_starIndex==4 ?
                              Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                  :_starIndex==5 ?
                              Image(image: AssetImage('images/star2_big.png'),fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star2_e.png'),fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 35,
                              height: 20,
                              padding: EdgeInsets.only(right: 15),
                              child: _starIndex==3 ?
                              Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                  :_starIndex==4 ?
                              Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                  :_starIndex==5 ?
                              Image(image: AssetImage('images/star3_big.png'),fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star3_e.png'),fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 35,
                              height: 20,
                              padding: EdgeInsets.only(right: 15),
                              child: _starIndex==4 ?
                              Image(image: AssetImage('images/star4_big.png'),fit: BoxFit.fill,)
                                  :_starIndex==5 ?
                              Image(image: AssetImage('images/star4_big.png'),fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star4_e.png'),fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 35,
                              height: 20,
                              padding: EdgeInsets.only(right: 15),
                              child: _starIndex==5 ?
                              Image(image: AssetImage('images/star5_big.png'),fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star5_e.png'),fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                    ),
                    // 任务名称
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(widget.name,style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF0E7AE6),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                          Container(
                            padding: EdgeInsets.only(left: 10,top: 5),
                            child: Text(
                              widget.planCount.toString()+widget.unit,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                          )
                        ],
                      ),
                    ),
                    // 时间
                    Container(
                        padding: EdgeInsets.only(left: 20,top: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              widget.startTime.toString().substring(10,16)+' -'+widget.endTime.toString().substring(10,16),
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.left,),
                          ],
                        )
                    ),
                    // 上传
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 24,
                                padding: EdgeInsets.only(right: 5,top: 3),
                                child: Image(image: AssetImage(
                                    'images/site_small.png'),),
                              ),
                              Expanded(
                                child: Text(
                                  //widget.currentAddress != null ? widget.currentAddress : '暂未识别地点',
                                  gps_place,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0E7AE6),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Text('图片上传',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              ],
                            )
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap:() {
                                  //_pickImage(),
                                  widget.defaultId == "1" ||
                                      widget.defaultId == "3" || widget
                                      .defaultId == "4" ?
                                  // 是打电话相关先判断机型是否为苹果
                                  _onChooseIsIPhonePressed(context)
                                      :
                                  _pickImage();
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
                                      Text('拍照上传',style: TextStyle(
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
                                    child: _images.length == 0 && inImgs.length==0 ? Image(image: AssetImage('images/camera.png'),) :
                                    inImgs.length >= 1?Image(image: NetworkImage(inImgs[0]),fit: BoxFit.fill):
                                    _images.length>=1?Image.file(_images[0],fit: BoxFit.fill,)
                                        :Image.file(_images[0],fit: BoxFit.fill,)
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
                                  child: _images.length == 0 ?
                                  Image(image: AssetImage('images/camera.png'),)
                                      : _images.length == 1 ?
                                  Image(image: AssetImage('images/camera.png'),)
                                      :_images.length == 2 && _images[1].toString().contains('https')?
                                  Image(image: NetworkImage(_images[1]),fit:BoxFit.fill,)
                                      : _images[1] is File && _images.length==2 ?
                                  Image.file(_images[1],fit: BoxFit.fill,)
                                      :
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        inImgs.length > 1 ? Image(image: NetworkImage(inImgs[1]),fit:BoxFit.fill,)
                                            : _images.length>1?Image.file(_images[1],fit: BoxFit.fill,)
                                            : Image(image: AssetImage('images/camera.png')),
                                        Container(width: 90,height: 90,color: Colors.black45,),
                                        Text("+"+(_images.length-1).toString(),
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
                      ],
                    ),
                    // 备注
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Text('注意!',style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text('拍摄或上传任务交付物的照片，系统会自动审核任务完成百分比；请在任务时间内完成任务并在任务结束后60分钟内上传或拍摄交付物照片，超时视为未完成，不可修改！',style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                    // 完成
                    GestureDetector(
                      onTap: () async{
                        if(gps_place=="正在定位..."){
                          _onNotGPS(context);
                          return;
                        }
                        var upTime=DateTime.now();
                        String picTime=upTime.toString().split('.')[0];

                        //传入的图片个数大于0,说明是编辑状态
                        if(inImgs.length>0){
                          _onRefresh();
                          List newAdd=[];
                          for(var newAddImg in _images){
                            if(newAddImg is File){
                              newAdd.add(newAddImg);
                            }
                          }

                          List<RecordMission> recordMission = new List();
                          //新加入的图片数组
                          if(newAdd.length>0){
                            Dio dio = new Dio();
                            //遍历重新上传的图片
                            for (var imgFile in newAdd) {
                              String fName = imgFile
                                  .toString()
                                  .split('/')
                                  .last;
                              print(fName);

                              final tempDir=await getTemporaryDirectory();
                              final path=tempDir.path;

                              //压缩图片开始

                              IMG.Image compressImg=IMG.decodeImage(imgFile.readAsBytesSync());
                              IMG.Image smallerImg=IMG.copyResize(compressImg,height: 1280);
                              final compressedImageFile=new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg,quality: 85));
                              print(compressedImageFile);
                              //压缩图片结束

                              //文件名去除连接符
                              fName = fName.replaceAll('-', '');
                              //文件名去除单引号
                              fName = fName.replaceAll("'", '');
                              //文件名转化为小写
                              fName = fName.toLowerCase();
                              var sign = await GetDirectSignDao.httpGetSign(
                                  fName, '2');
                              print("获取上传签名");
                              print(sign);
                              if (sign.code == 200) {
                                FormData formData = new FormData.fromMap({
                                  "OSSAccessKeyId": sign.data.accessId,
                                  "policy": sign.data.policy,
                                  "signature": sign.data.signature,
                                  "key": sign.data.dir + fName,
                                  "success_action_status": "200",
                                  "file": await MultipartFile.fromFile(
                                      imgFile.path, filename: fName)
                                });
                                try {
                                  Response res = await dio.post(
                                      'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                                      data: formData);
                                  if (res.statusCode == 200) {
                                    print("上传照片成功");
                                    print("照片链接：" + sign.data.finalUrl);
                                    print(_defaultTaskID);
                                    //默认打电话任务
                                    if (_defaultTaskID == "1" ||
                                        _defaultTaskID == "3" ||
                                        _defaultTaskID == "4") {
                                      print("正在进行AI分析");
                                      //进行VI识别，并传入是否为Iphone截图
                                      var vi_result = await TestVIDao.doVI(
                                          sign.data.finalUrl, isApplePhone);
                                      //识别成功
                                      if (vi_result.code == 200) {
                                        SharedPreferences prefs = await SharedPreferences
                                            .getInstance();
                                        //var userId= prefs.getString("userID");
                                        var userinfo = prefs.getString(
                                            "userInfo");
                                        var uinfo = loginResultDataFromJson(
                                            userinfo);
                                        print("电话识别成功，组织上传数据");
                                        //var recordBody=json.encode();
                                        RecordMission r = new RecordMission(
                                            userLevels: uinfo.userLevel.substring(0, 1),
                                            userPid: uinfo.userPid,
                                            img: imgUrlWithLocation(sign.data.finalUrl, gps_place, _baiduLocation.longitude.toString(), _baiduLocation.latitude.toString(), picTime),
                                            phoneNum: uinfo.phone,
                                            selectMissionId: widget.taskId,
                                            gpsLocation: gps_place
                                        );
                                        print("向数组中加入元素");
                                        recordMission.add(r);
                                      } else {
                                        print("没有什么能够阻挡,没有识别成功！");
                                      }
                                    } else { //非打电话任务
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      //var userId= prefs.getString("userID");
                                      var userinfo = prefs.getString("userInfo");
                                      var uinfo = loginResultDataFromJson(
                                          userinfo);
                                      print("非电话类任务，组织上传数据");
                                      //var recordBody=json.encode();
                                      RecordMission r = new RecordMission(
                                          userLevels: uinfo.userLevel.substring(0, 1),
                                          userPid: uinfo.userPid,
                                          img: imgUrlWithLocation(sign.data.finalUrl, gps_place, _baiduLocation.longitude.toString(), _baiduLocation.latitude.toString(), picTime),
                                          phoneNum: '-1',
                                          selectMissionId: widget.taskId,
                                          gpsLocation: gps_place
                                      );
                                      print("向数组中加入元素");
                                      recordMission.add(r);
                                    }
                                  }

                                } on DioError catch (e) {
                                  print(e);
                                }
                              }
                            }//for循环完成

                            print(recordMission);
                            if (recordMission.length > 0) {
                              var recordBody = convert.json.encode(recordMission);
                              var recordMissionImg = await dio.post(
                                  "http://47.104.20.6:10086/api/api/mission/UploadPhone",
                                  data: recordBody);
                              var rrr = commonResultFromJson(
                                  recordMissionImg.toString());
                              if (rrr.code == 200) {
                                _onRefresh();
                                print("完成一个任务记录更新");
//                               Navigator.pop(context);
                                if(userData.userLevel.substring(0,1)=="6"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                                }
                                if(userData.userLevel.substring(0,1)=="5"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                                }
                                if(userData.userLevel.substring(0,1)=="4"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                                }
                                if(userData.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                                }
                              }else{
                                _onRefresh();
                              }
                            }

                          }
                          else{
                            _onRefresh();
                            print("完成一个任务记录更新");
//                               Navigator.pop(context);
                            if(userData.userLevel.substring(0,1)=="6"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                            }
                            if(userData.userLevel.substring(0,1)=="5"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                            }
                            if(userData.userLevel.substring(0,1)=="4"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                            }
                            if(userData.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                            }
                          }
                        }
                        //初次加入图片
                        else {
                          List<RecordMission> recordMission = new List();
                          if (_images.length > 0) {
                            _onRefresh();
                            Dio dio = new Dio();
                            for (var imgFile in _images) {

                              String fName = imgFile
                                  .toString()
                                  .split('/')
                                  .last;

                              final tempDir=await getTemporaryDirectory();
                              final path=tempDir.path;

                              //压缩图片开始

                              IMG.Image compressImg=IMG.decodeImage(imgFile.readAsBytesSync());
                              IMG.Image smallerImg=IMG.copyResize(compressImg,height: 1280);
                              final compressedImageFile=new File("$path/$fName")..writeAsBytesSync(IMG.encodeJpg(smallerImg,quality: 85));
                              print(compressedImageFile);
                              //压缩图片结束


                              //文件名去除连接符
                              fName = fName.replaceAll('-', '');
                              //文件名去除单引号
                              fName = fName.replaceAll("'", '');
                              //文件名转化为小写
                              fName = fName.toLowerCase();
                              var sign = await GetDirectSignDao.httpGetSign(fName, '2');
                              print("获取上传签名");
                              print(sign);
                              if (sign.code == 200) {
                                FormData formData = new FormData.fromMap({
                                  "OSSAccessKeyId": sign.data.accessId,
                                  "policy": sign.data.policy,
                                  "signature": sign.data.signature,
                                  "key": sign.data.dir + fName,
                                  "success_action_status": "200",
                                  "file": await MultipartFile.fromFile(
                                      compressedImageFile.path, filename: fName)
                                });
                                try {
                                  Response res = await dio.post(
                                      'http://thumb-sir.oss-cn-shanghai.aliyuncs.com',
                                      data: formData);
                                  if (res.statusCode == 200) {
                                    print("上传照片成功");
                                    print("照片链接：" + sign.data.finalUrl);
                                    print(_defaultTaskID);
                                    //默认打电话任务
                                    if (_defaultTaskID == "1" ||
                                        _defaultTaskID == "3" ||
                                        _defaultTaskID == "4") {
                                      print("正在进行AI分析");
                                      //进行VI识别，并传入是否为Iphone截图
                                      var vi_result = await TestVIDao.doVI(
                                          sign.data.finalUrl, isApplePhone);
                                      //识别成功
                                      if (vi_result.code == 200) {
                                        SharedPreferences prefs = await SharedPreferences
                                            .getInstance();
                                        //var userId= prefs.getString("userID");
                                        var userinfo = prefs.getString(
                                            "userInfo");
                                        var uinfo = loginResultDataFromJson(
                                            userinfo);
                                        print("电话识别成功，组织上传数据");
                                        //var recordBody=json.encode();
                                        RecordMission r = new RecordMission(
                                            userLevels: uinfo.userLevel.substring(
                                                0, 1),
                                            userPid: uinfo.userPid,
                                            img: imgUrlWithLocation(sign.data.finalUrl, gps_place, _baiduLocation.longitude.toString(), _baiduLocation.latitude.toString(), picTime),
                                            phoneNum: uinfo.phone,
                                            selectMissionId: widget.taskId,
                                            gpsLocation: gps_place
                                        );
                                        print("向数组中加入元素");
                                        recordMission.add(r);
                                      } else {
                                        print("没有什么能够阻挡,没有识别成功！");
                                        _onNotPhoneImgPressed(context);
                                        _onRefresh();
                                      }
                                    }
                                    //非打电话任务
                                    else {


                                      SharedPreferences prefs = await SharedPreferences
                                          .getInstance();
                                      //var userId= prefs.getString("userID");
                                      var userinfo = prefs.getString("userInfo");
                                      var uinfo = loginResultDataFromJson(
                                          userinfo);
                                      print("非电话类任务，组织上传数据");
                                      print(sign.data.finalUrl);
                                      //var recordBody=json.encode();
                                      RecordMission r = new RecordMission(
                                          userLevels: uinfo.userLevel.substring(
                                              0, 1),
                                          userPid: uinfo.userPid,
                                          img: imgUrlWithLocation(sign.data.finalUrl, gps_place, _baiduLocation.longitude.toString(), _baiduLocation.latitude.toString(), picTime),
                                          phoneNum: '-1',
                                          selectMissionId: widget.taskId,
                                          gpsLocation: gps_place
                                      );
                                      print("向数组中加入元素");
                                      recordMission.add(r);
                                    }
                                  }
                                } on DioError catch (e) {
                                  print(e);
                                }
                              }
                            }
                            print(recordMission);
                            if (recordMission.length > 0) {
                              var recordBody = convert.json.encode(recordMission);
                              var recordMissionImg = await dio.post(
                                  "http://47.104.20.6:10086/api/api/mission/UploadPhone",
                                  data: recordBody);
                              var rrr = commonResultFromJson(
                                  recordMissionImg.toString());
                              if (rrr.code == 200) {
                                _onRefresh();
                                print("完成一个任务记录");
//                               Navigator.pop(context);
                                if(userData.userLevel.substring(0,1)=="6"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                                }
                                if(userData.userLevel.substring(0,1)=="5"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                                }
                                if(userData.userLevel.substring(0,1)=="4"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                                }
                                if(userData.userLevel.substring(0,1)=="1"||result.userLevel.substring(0,1)=="2"||result.userLevel.substring(0,1)=="3"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                                }
                              } else{
                                _onRefresh();
                              }
                            }
                          } else {}
                        }

                      },
                      child: Container(
                        width: 200,
                        height: 32,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 80),
                        decoration: BoxDecoration(
                          color: _images.length==0 ? Colors.transparent: Color(0xFF5580EB),
                          border: _images.length==0 ? Border.all(width: 1,color: Color(0xFF93C0FB)):Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('完成',style: TextStyle(
                          fontSize: 16,
                          color: _images.length==0 ? Color(0xFF93C0FB):Colors.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),textAlign: TextAlign.center,),
                      ),
                    ),

                  ]
              )
            ],
          )
      )
    );

  }
  _onChooseIsIPhonePressed(context) {
    Alert(
      context: context,
      title: "您打电话使用的手机是否为苹果手机？",
      desc:"温馨提示：请逐页上传通话详情页（示例见下图）",
      content: Column(
        children: <Widget>[
          Text(
            "需要包含的信息有：电话号码、拨打时间、呼入或呼出的标识、通话时长。以上信息均不可涂抹。",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF999999)
            ),
          ),
          Text(
            "识别规则：电话接通记为有效，电话号码如有重复仅计算一次。如遇识别不准的情况请在个人中心-客服中心反馈。我们将不断优化，感谢您的配合~",
            style: TextStyle(
                fontSize: 12,
                color: Color(0xFF999999)
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 300,
            height: 400,
            child: Image(image: AssetImage('images/phone_ex.jpg'),fit: BoxFit.fitHeight,),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "是苹果手机",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            isApplePhone=true;
            Navigator.pop(context);
            _pickImage();
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "不是苹果手机",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            isApplePhone=false;
            Navigator.pop(context);
            _pickImage();
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }

  _onNotGPS(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "还没有获取到定位信息",
      desc:"请确认GPS定位服务已开启。如果没有开启，请在设置中开启。如果已开启，请稍等或返回上一页后重新进入此页面...",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }

  _onNotPhoneImgPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "您上传的部分图片不符合识别规则",
      desc:"温馨提示：请逐页上传通话详情页（示例见下图）",
      content: Column(
        children: <Widget>[
          Text(
            "需要包含的信息有：电话号码、拨打时间、呼入或呼出的标识、通话时长。以上信息均不可涂抹。",
            style: TextStyle(
                fontSize: 12,
                color: Color(0xFF999999)
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 300,
            height: 400,
            child: Image(image: AssetImage('images/phone_ex.jpg'),fit: BoxFit.fitHeight,),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }

  /*
  * Base64加密
  */
  static String base64Encode(String data){
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    digest=digest.replaceAll('+', '-');
    digest=digest.replaceAll('/', '_');
    print(digest);
    return digest;
  }


  //设置图片后缀水印
 String imgUrlWithLocation(String imgUrl,String gpsLocation,String longitude,String latitude,String picTime){
      String base64GPS=base64Encode(gpsLocation);
      String base64JingDu=base64Encode("经度："+longitude);
      String base64WeiDu=base64Encode("纬度："+latitude);
      String base64PicTime=base64Encode(picTime);
      String newUrl="${imgUrl}?x-oss-process=image/watermark,image_aW1ncy9vdGhlcnMvd2F0ZXJsb2dvLnBuZw==,g_se,x_40,y_40,P_20/watermark,text_${base64GPS},color_ffffff,size_25,g_sw,x_50,y_135,shadow_80/watermark,text_${base64PicTime},color_ffffff,size_25,g_sw,x_50,y_105,shadow_80/watermark,text_${base64JingDu},color_ffffff,size_25,g_sw,x_50,y_75,shadow_80/watermark,text_${base64WeiDu},color_ffffff,size_25,g_sw,x_50,y_45,shadow_80";
      return newUrl;
  }


  /// 设置android端和ios端定位参数
  void _setLocOption() {
    /// android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(false); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(false); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(0); // 设置发起定位请求时间间隔

    Map androidMap = androidOption.getMap();

    /// ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType("BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest");  // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  /// 启动定位
  void _startLocation() {
    if (null != _locationPlugin) {
      _setLocOption();
      _locationPlugin.startLocation();
    }
  }

  /// 停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }

}



