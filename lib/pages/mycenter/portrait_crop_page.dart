import 'package:flutter/material.dart';
import 'package:simple_image_cropper/simple_image_cropper.dart';

class PortraitCropPage extends StatefulWidget {
  @override
  _PortraitCropPageState createState() => _PortraitCropPageState();
}

class _PortraitCropPageState extends State<PortraitCropPage> {
  final GlobalKey<SimpleImageCropperState> cropKey = GlobalKey();
  late ImageProvider _image;

  @override
  Widget build(BuildContext context) {
    // 获取上一页传来的_image
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    final portrait = FileImage(args['image']);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '裁剪照片',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon:
            new Icon(Icons.navigate_before, color: Colors.black, size: 40),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: SimpleImageCropper(
            key: cropKey,
            height: 300,
            image: portrait,
            width: 300,
          )
          // ImgCrop(
          //   key: cropKey,
          //   //chipRadius: 100,
          //   // chipShape: 'rect',
          //   maximumScale: 3,
          //   image: portrait,
          // ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final crop = cropKey.currentState;
            // final croppedFile = await crop.cropCompleted(args['image'], pictureQuality: 800);
            // // 把裁剪结果传给上一页
            // Navigator.of(context).pop(croppedFile);
            Image? image = await cropKey.currentState?.cropImage();
            if(image!=null){
              setState(() {
                // portrait = image.image;
              });
            }
          },
          tooltip: 'Increment',
          child: Text('确认'),
        ));
  }
}