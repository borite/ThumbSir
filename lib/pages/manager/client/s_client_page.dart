import 'package:ThumbSir/pages/broker/client/my_client_page.dart';
import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/manager/client/team_client_page.dart';
import 'package:ThumbSir/pages/manager/traded/team_traded_page.dart';
import 'package:flutter/material.dart';


class SClientPage extends StatefulWidget {
  @override
  _SClientPageState createState() => _SClientPageState();
}

class _SClientPageState extends State<SClientPage> {
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
                title: Text('我的客户')
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
              title: Text('团队客户'),
            ),
          ],
          iconSize: 26,
        ),
        body: _currentIndex == 0? MyClientPage()
            : TeamClientPage()
    );
  }
}
