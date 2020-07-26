import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:ThumbSir/dao/get_direct_sgin_dao.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  QListUploadPage({Key key,
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
  final _picker = ImagePicker();
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

  @override
  void initState() {
    super.initState();
    _starIndex = widget.star;
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Padding(
                      padding: EdgeInsets.all(15),
                      child:Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Padding(
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
                      initialValue: widget.percent,
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
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children: <Widget>[
                        Text(widget.name,style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF0E7AE6),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),),
                        Padding(
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
                          widget.startTime.toString().substring(10,16)+'-'+widget.endTime.toString().substring(10,16),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Image(image: AssetImage('images/site_small.png'),),
                            ),
                            Text(
                              widget.currentAddress != null ? widget.currentAddress : '暂未识别地点',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                          ],
                        ),
                      ),
                      Padding(
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap:widget.defaultId == "1" || widget.defaultId == "3" || widget.defaultId == "4" ?
                              // 是打电话相关先判断机型是否为苹果
                              _onChooseIsIPhonePressed(context)
                                  :
                                  _pickImage,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/imgbg.png'))
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
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
                                child: _images.length == 0 ? Image(image: AssetImage('images/camera.png'),) : Image.file(_images[0],width: 90,height: 90,fit: BoxFit.fill,),
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
                                  :_images.length == 2 ?
                                  Image.file(_images[1],width: 90,height: 90,fit: BoxFit.fill,)
                                  :
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Image.file(_images[1],width: 90,height: 90,fit: BoxFit.fill,),
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
                  Padding(
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
                      print(_images);

                      if(_images.length>0) {
                        Dio dio=new Dio();
                        // dio.options.contentType="multipart/form-data";
                        //dio.options.responseType=ResponseType.plain;
                        _images.forEach((imgFile) async {
                            String fName=imgFile.toString().split('/').last;
                            print(fName);
                            //文件名去除连接符
                            fName=fName.replaceAll('-', '');
                            //文件名去除单引号
                            fName=fName.replaceAll("'", '');
                            //文件名转化为小写
                            fName=fName.toLowerCase();
                            var sign= await GetDirectSignDao.httpGetSign(fName, '2');
                            print(sign);
                            if(sign.code==200){
                              FormData formData=new FormData.fromMap({
                                "OSSAccessKeyId":sign.data.accessId,
                                "policy":sign.data.policy,
                                "signature":sign.data.signature,
                                "key":sign.data.dir+fName,
                                "success_action_status":"200",
                                "file":await MultipartFile.fromFile(imgFile.path,filename: fName)
                              });
                              try{
                                  Response res = await dio.post('http://thumb-sir.oss-cn-shanghai.aliyuncs.com',data: formData);
                                  if(res.statusCode==200){
                                    print(sign.data.finalUrl);
                                    //Response myres=await dio.post('')
                                  }
  //                                if(res.statusCode==200){
  //                                  SharedPreferences prefs = await SharedPreferences.getInstance();
  //                                  var userId= prefs.getString("userID");
  //                                  var modifyHeadResult = await ModifyHeadDao.modifyHead(sign.data.finalUrl, userId);
  //                                  if(modifyHeadResult.code == 200){
  //                                    // 更新token
  //                                    var tokenResult = await TokenCheckDao.tokenCheck(userData.token);
  //                                    if(tokenResult.code == 200){
  //                                      String dataStr=json.encode(tokenResult.data);
  //                                      prefs.setString("userInfo", dataStr);
  //                                      Navigator.of(context).pop(portrait);
  //                                    }
  //                                  }else{_onNetAlertPressed(context);}
  //                                }else{_onNetAlertPressed(context);}
  //                              } on DioError catch(e){
  //                                print(e.message);
  //                                print(e.response.data);
  //                                print(e.response.headers);
  //                                print(e.response.request);
  //                              }
                                }on DioError catch(e){

                                }
                            }
                        });
//                        String fName=portrait.toString().split('/').last;
//                        //文件名去除连接符
//                        fName=fName.replaceAll('-', '');
//                        //文件名去除单引号
//                        fName=fName.replaceAll("'", '');
//                        //文件名转化为小写
//                        fName=fName.toLowerCase();
                      }

                    },
                    child: Container(
                      width: 200,
                      height: 32,
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 80),

                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('完成',style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF93C0FB),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),textAlign: TextAlign.center,),
                    ),
                  ),

                ]
            )
          ],
        )
    );
  }
  _onChooseIsIPhonePressed(context) {
    Alert(
      context: context,
      title: "您打电话使用的手机是否为苹果手机？",
      buttons: [
        DialogButton(
          child: Text(
            "是的",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _pickImage,
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "不是",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _pickImage,
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
