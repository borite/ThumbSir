import 'package:ThumbSir/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/mycenter/my_center_page.dart';

class QListAddPage extends StatefulWidget {
  @override
  _QListAddPageState createState() => _QListAddPageState();
}

class _QListAddPageState extends State<QListAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Text('添加量化条目')
      ),
      appBar:AppBar(
          leading:GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.home),
          )
      ),
    );
  }
}
