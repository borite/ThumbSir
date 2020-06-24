import 'dart:io';

import 'package:ThumbSir/pages/broker/qlist/img_view_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:image_picker/image_picker.dart';

class QListUploadPage extends StatefulWidget {
  @override
  _QListUploadPageState createState() => _QListUploadPageState();
}

class _QListUploadPageState extends State<QListUploadPage> {
  int _starIndex=3;
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
                      initialValue: 70,
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
                        Text('带看',style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF0E7AE6),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),),
                        Padding(
                          padding: EdgeInsets.only(left: 10,top: 5),
                          child: Text('3套',style: TextStyle(
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
                        Text('10:00-11:00',style: TextStyle(
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
                            Text('惠明小区4号楼',style: TextStyle(
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
                              onTap: _pickImage,
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
                            Text('惠明小区4号楼',style: TextStyle(
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
                              onTap: _pickImage,
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
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ImgViewPage()));
                              },
                              child: Container(
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
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ImgViewPage()));
                              },
                              child: Container(
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            Text('惠明小区4号楼',style: TextStyle(
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
                              onTap: _pickImage,
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
                    child: Text('拍摄或上传任务交付物的照片，系统会自动审核任务完成百分比；请在任务时间内完成任务并在任务结束后30分钟内上传或拍摄交付物照片，超时视为未完成，不可修改！',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 完成
                  Container(
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
                ]
            )
          ],
        )
    );
  }
}
