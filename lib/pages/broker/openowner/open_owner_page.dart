import 'package:flutter/material.dart';

class OpenOwnerPage extends StatefulWidget {
  @override
  _OpenOwnerPageState createState() => _OpenOwnerPageState();
}

class _OpenOwnerPageState extends State<OpenOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child:Text('未成交业主暂未开放，敬请期待')
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
