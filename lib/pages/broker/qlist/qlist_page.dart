import 'dart:typed_data';

import 'package:ThumbSir/pages/broker/qlist/qlist_choose_add_page.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_analyze_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_list_page.dart';

class QListPage extends StatefulWidget {
  @override
  _QListPageState createState() => _QListPageState();
}

class _QListPageState extends State<QListPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 1;
            });
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
              icon: Image(image:AssetImage('images/listicon.png')),
              activeIcon:Image(image:AssetImage('images/listicon.png'),),
              title: Text('量化')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list,color: Colors.grey,),
              activeIcon:Icon(Icons.list,color:Colors.blue,),
              title: Text('新增任务'),
            ),
            BottomNavigationBarItem(
              icon: Image(image:AssetImage('images/analyze.png')),
              activeIcon:Image(image:AssetImage('images/analyze.png')),
              title: Text('分析'),
            ),
          ],
        ),
        body: _currentIndex == 1 ? QListChooseAddPage()
        :_currentIndex == 0? QListListPage()
        : QListAnalyzePage()
      );
  }
}
