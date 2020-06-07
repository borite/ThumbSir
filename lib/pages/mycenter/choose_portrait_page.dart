import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChoosePortraitPage extends StatefulWidget {
  @override
  _ChoosePortraitPageState createState() => _ChoosePortraitPageState();
}

class _ChoosePortraitPageState extends State<ChoosePortraitPage> {
  final _picker = ImagePicker();
  var portrait;
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
                                onTap: (){
                                  Navigator.of(context).pop(portrait);
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
                      width: 210,
                      height: 210,
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
                        borderRadius: BorderRadius.circular(105),
                        child: portrait == null ?
                        Image(image: AssetImage('images/my_big.png'),)
                            :
                        Image.file(portrait,fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  // 相册中选取
                  GestureDetector(
                    onTap: ()=>pickImage(),
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
}

