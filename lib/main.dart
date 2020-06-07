import 'package:ThumbSir/pages/mycenter/choose_portrait_page.dart';
import 'package:ThumbSir/pages/mycenter/portrait_crop_page.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        "crop_page":(context) => PortraitCropPage(),
        "choose_portrait":(context) => ChoosePortraitPage(),
      },
    );
  }
}
