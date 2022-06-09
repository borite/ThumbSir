import 'package:ThumbSir/pages/manager/qlist/team_analyze_page.dart';
import 'package:ThumbSir/pages/manager/qlist/team_list_page.dart';
import 'package:flutter/material.dart';

class MajorQListPage extends StatefulWidget {
  @override
  _MajorQListPageState createState() => _MajorQListPageState();
}

class _MajorQListPageState extends State<MajorQListPage> with SingleTickerProviderStateMixin{
  int _currentIndex = 0;
  final _defaultColor = Color(0xFF999999);
  final _activeColor = Color(0xFF0E7AE6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 29,
                  child: Image(image:AssetImage('images/teamlisticon.png')),
                ),
                activeIcon:Container(
                  height: 29,
                  child: Image(image:AssetImage('images/teamlisticon_s.png'),),
                ),
                // title: Text('团队量化',style: TextStyle(color:_currentIndex != 0? _defaultColor : _activeColor,))
              label: '团队量化'
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 29,
                child: Image(image:AssetImage('images/teamanalyze.png')),
              ),
              activeIcon:Container(
                height: 29,
                child: Image(image:AssetImage('images/teamanalyze_s.png')),
              ),
              // title: Text('团队分析',style: TextStyle(color:_currentIndex != 1? _defaultColor : _activeColor,)),
              label: '团队分析'
            ),
          ],
        ),
        body: _currentIndex == 0? TeamListPage():TeamAnalyzePage()
        
      );
  }
}
