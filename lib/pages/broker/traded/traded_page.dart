import 'package:flutter/material.dart';

class TradedPage extends StatefulWidget {
  @override
  _TradedPageState createState() => _TradedPageState();
}

class _TradedPageState extends State<TradedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child:Text('已成交客户/业主暂未开放，敬请期待')
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
