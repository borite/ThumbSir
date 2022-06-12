import 'package:ThumbSir/pages/broker/client/my_client_page.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/manager/client/group_client_page.dart';
import 'package:ThumbSir/pages/manager/traded/group_traded_page.dart';
import 'package:flutter/material.dart';


class MClientPage extends StatefulWidget {
  @override
  _MClientPageState createState() => _MClientPageState();
}

class _MClientPageState extends State<MClientPage> {
  int _currentIndex = 0;
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
                  height: 26,
                  child: Image(image:AssetImage('images/my_traded.png'),),
                ),
                activeIcon:Container(
                  height: 26,
                  child: Image(image:AssetImage('images/my_traded_s.png'),),
                ),
                label: '我的客户'
            ),
            BottomNavigationBarItem(
              icon: Container(
                height:26,
                child:Image(image:AssetImage('images/team_traded.png')),
              ),
              activeIcon:Container(
                height:26,
                child:Image(image:AssetImage('images/team_traded_s.png')),
              ),
              label: '团队客户',
            ),
          ],
          iconSize: 26,
        ),
        body: _currentIndex == 0? MyClientPage()
            : GroupClientPage()
    );
  }
}
