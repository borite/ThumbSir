import 'dart:convert';
import 'dart:io';
import 'package:ThumbSir/dao/modify_head_dao.dart';
import 'package:ThumbSir/dao/token_check_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ThumbSir/dao/get_direct_sgin_dao.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ThumbSir/utils/common_vars.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChoosePortraitPage extends StatefulWidget {
  @override
  _ChoosePortraitPageState createState() => _ChoosePortraitPageState();
}

class _ChoosePortraitPageState extends State<ChoosePortraitPage> {
  final _picker = ImagePicker();
  File portrait;
  File _image;
  Future pickImage() async {
    final image = await _picker.getImage(
        source: ImageSource.gallery
    );
    final File img=File(image.path);
    setState(() {
      _image = img;
    });
    _image == null ?
    Navigator.of(context).pop()
        :
        // 用.then接收子页面传递来的参数
    Navigator.of(context).pushNamed('crop_page', arguments: {'image': _image}).then((croppedFile){
      setState(() {
        portrait = croppedFile;
      });
    });
  }

  LoginResultData userData;
  int _dateTime = DateTime.now().millisecondsSinceEpoch; // 当前时间转时间戳
  int exT;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      exT = result.exTokenTime.millisecondsSinceEpoch; // token时间转时间戳
      if(exT >= _dateTime){
        this.setState(() {
          userData=LoginResultData.fromJson(json.decode(uinfo));
        });
      }else{
        _onLogoutAlertPressed(context);
      }
    }
  }
  _onLogoutAlertPressed(context) {
    Alert(
      context: context,
      title: "需要重新登录",
      desc: "长时间未进行登录操作，需要重新登录验证",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("userInfo");
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Home()
                ), (route) => route == null
            );
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async{
                                  if(portrait != null){
                                    Dio dio=new Dio();
                                    // dio.options.contentType="multipart/form-data";
                                    dio.options.responseType=ResponseType.plain;
                                    //获取文件名
                                    String fName=portrait.toString().split('/').last;
                                    //文件名去除连接符
                                    fName=fName.replaceAll('-', '');
                                    //文件名去除单引号
                                    fName=fName.replaceAll("'", '');
                                    //文件名转化为小写
                                    fName=fName.toLowerCase();
                                    var sign= await GetDirectSignDao.httpGetSign(fName, '1');
                                    if(sign.code==200){
                                      FormData formData=new FormData.fromMap({
                                        "OSSAccessKeyId":sign.data.accessId,
                                        "policy":sign.data.policy,
                                        "signature":sign.data.signature,
                                        "key":sign.data.dir+fName,
                                        "success_action_status":"200",
                                        "file":await MultipartFile.fromFile(portrait.path,filename: fName)
                                      });
                                      try {
                                        Response res = await dio.post('http://thumbsir.oss-cn-beijing.aliyuncs.com',data: formData);
                                        if(res.statusCode==200){
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          var userId= prefs.getString("userID");
                                          var modifyHeadResult = await ModifyHeadDao.modifyHead(sign.data.finalUrl, userId);
                                          if(modifyHeadResult.code == 200){
                                            // 更新token
                                            var tokenResult = await TokenCheckDao.tokenCheck(userData.token);
                                            if(tokenResult.code == 200){
                                              String dataStr=json.encode(tokenResult.data);
                                              prefs.setString("userInfo", dataStr);
                                              Navigator.of(context).pop(portrait);
                                            }
                                          }else{_onNetAlertPressed(context);}
                                        }else{_onNetAlertPressed(context);}
                                      } on DioError catch(e){
                                        print(e.message);
                                        print(e.response.data);
                                        print(e.response.headers);
                                        print(e.response.request);
                                      }
                                    }
                                  }else{
                                    Navigator.of(context).pop();
                                  }

                                },
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                              Text('个人头像',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                              Container(width: 20,)
                            ],
                          ),
                  ),
                  // 头像
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(105)),
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                            color: Color(0xFFcccccc),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0
                        )],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: userData == null && portrait == null?
                        Image(image: AssetImage('images/my_big.png'),)
                        :portrait != null && userData != null && userData.headImg != portrait?
                        Image.file(portrait,fit: BoxFit.fill,)
                            :userData.headImg != null ?
                        Image(image:NetworkImage(userData.headImg))
                            :Image(image: AssetImage('images/my_big.png'),),
                      ),
                    ),
                  ),
                  // 相册中选取
                  GestureDetector(
                    onTap: (){pickImage();},
                    child: Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.fromLTRB(0, 60, 0, 80),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF5580EB)
                      ),
                      child: Text('从相册中选取',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
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
  _onNetAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "操作失败",
      desc: "请检查网络连接",
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

