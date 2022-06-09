import 'package:ThumbSir/pages/broker/qlist/qlist_choose_add_page.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_analyze_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_list_page.dart';


class MajorClientPage extends StatefulWidget {
  @override
  _MajorClientPageState createState() => _MajorClientPageState();
}

class _MajorClientPageState extends State<MajorClientPage> {
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
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                height: 26,
                child: Image(image:AssetImage('images/listicon.png'),),
              ),
              activeIcon:Container(
                height: 26,
                child: Image(image:AssetImage('images/listicon_s.png'),),
              ),
              label: '量化'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list,color: Colors.grey,),
              activeIcon:Icon(Icons.list,color:Colors.blue,),
              label: '新增任务',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height:26,
                child:Image(image:AssetImage('images/analyze.png')),
              ),
              activeIcon:Container(
                height:26,
                child:Image(image:AssetImage('images/analyze_s.png')),
              ),
              label: '分析',
            ),
          ],
          iconSize: 26,
        ),
        body: _currentIndex == 1 ? QListChooseAddPage()
        :_currentIndex == 0? QListListPage()
        : QListAnalyzePage()
      );
  }
}
