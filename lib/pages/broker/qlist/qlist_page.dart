import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_add_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_analyze_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_morning_page.dart';

class QListPage extends StatefulWidget {
  @override
  _QListPageState createState() => _QListPageState();
}

class _QListPageState extends State<QListPage> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
          },
          child: Image(image:AssetImage('images/add.png'),),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image(image:AssetImage('images/home.png')),
                activeIcon:Icon(Icons.home,color:Colors.blue,),
                title: Text('主页')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list,color: Colors.grey,),
                activeIcon:Icon(Icons.list,color:Colors.blue,),
              title: Text('新增计划')
            ),
            BottomNavigationBarItem(
                icon: Image(image:AssetImage('images/analyze.png')),
                activeIcon:Icon(Icons.pie_chart,color:Colors.blue,),
                title: Text('分析')
            ),
          ],
        ),
        body: _currentIndex == 1 ? QListMorningPage()
        :_currentIndex == 0? Navigator.pop(context)
        : QListAnalyzePage()));
  }
}
