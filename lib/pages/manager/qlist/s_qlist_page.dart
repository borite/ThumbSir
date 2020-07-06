import 'package:ThumbSir/pages/broker/qlist/qlist_choose_add_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_analyze_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_list_page.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_analyze_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_list_page.dart';

class SQListPage extends StatefulWidget {
  @override
  _SQListPageState createState() => _SQListPageState();
}

class _SQListPageState extends State<SQListPage> with SingleTickerProviderStateMixin{
  int _currentIndex = 0;
  final _defaultColor = Color(0xFF999999);
  final _activeColor = Color(0xFF0E7AE6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 2;
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
              icon: Image(image:AssetImage('images/listicon.png')),
              activeIcon:Image(image:AssetImage('images/listicon_s.png'),),
              title: Text('个人量化',style: TextStyle(color:_currentIndex != 0? _defaultColor : _activeColor,))
            ),
            BottomNavigationBarItem(
              icon: Image(image:AssetImage('images/analyze.png')),
              activeIcon:Image(image:AssetImage('images/analyze_s.png')),
              title: Text('个人分析',style: TextStyle(color:_currentIndex != 1? _defaultColor : _activeColor,)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list,color: Colors.grey,),
              activeIcon:Icon(Icons.list,color:Colors.blue,),
              title: Text('新增任务',style: TextStyle(color:_currentIndex != 2? _defaultColor : _activeColor,)),
            ),
            BottomNavigationBarItem(
                icon: Image(image:AssetImage('images/teamlisticon.png')),
                activeIcon:Image(image:AssetImage('images/teamlisticon_s.png'),),
                title: Text('团队量化',style: TextStyle(color:_currentIndex != 3? _defaultColor : _activeColor,))
            ),
            BottomNavigationBarItem(
              icon: Image(image:AssetImage('images/teamanalyze.png')),
              activeIcon:Image(image:AssetImage('images/teamanalyze_s.png')),
              title: Text('团队分析',style: TextStyle(color:_currentIndex != 4? _defaultColor : _activeColor,)),
            ),
          ],
        ),
        body: _currentIndex == 0? QListListPage()
        : _currentIndex == 1? QListAnalyzePage()
        :_currentIndex == 2? QListChooseAddPage()
        :_currentIndex == 3? TeamListPage()
        :TeamAnalyzePage()
      );
  }
}
