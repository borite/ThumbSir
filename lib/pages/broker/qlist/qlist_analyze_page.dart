import 'package:flutter/material.dart';

class QListAnalyzePage extends StatefulWidget {
  @override
  _QListAnalyzePageState createState() => _QListAnalyzePageState();
}

class _QListAnalyzePageState extends State<QListAnalyzePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Text('量化分析')
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
