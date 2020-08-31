import 'package:ThumbSir/pages/broker/qlist/qlist_choose_add_page.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_add_page.dart';
import 'package:ThumbSir/pages/manager/broker/team_traded_page.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_analyze_page.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_list_page.dart';


class SBrokerPage extends StatefulWidget {
  @override
  _SBrokerPageState createState() => _SBrokerPageState();
}

class _SBrokerPageState extends State<SBrokerPage> {
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
                title: Text('我的客户')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list,color: Colors.grey,),
              activeIcon:Icon(Icons.list,color:Colors.blue,),
              title: Text('新增客户'),
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
              title: Text('团队客户'),
            ),
          ],
          iconSize: 26,
        ),
        body: _currentIndex == 1 ? TradedAddPage()
            :_currentIndex == 0? MyTradedPage()
            : TeamTradedPage()
    );
  }
}
