import 'package:flutter/material.dart';

class OpenClientPage extends StatefulWidget {
  @override
  _OpenClientPageState createState() => _OpenClientPageState();
}

class _OpenClientPageState extends State<OpenClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child:Text('未成交客户暂未开放，敬请期待')
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
