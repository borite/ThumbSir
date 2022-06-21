import 'package:ThumbSir/pages/manager/house/team_house_page.dart';
import 'package:flutter/material.dart';

import '../../broker/house/house_list_page.dart';


class SHousePage extends StatefulWidget {
  @override
  _SHousePageState createState() => _SHousePageState();
}

class _SHousePageState extends State<SHousePage> {
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
                  child: Image(image:AssetImage('images/house_a.png'),),
                ),
                activeIcon:Container(
                  height: 26,
                  child: Image(image:AssetImage('images/house_s.png'),),
                ),
                label: '公司系统房源'
            ),
            BottomNavigationBarItem(
              icon: Container(
                height:26,
                child:Image(image:AssetImage('images/houses.png')),
              ),
              activeIcon:Container(
                height:26,
                child:Image(image:AssetImage('images/houses_s.png')),
              ),
              label: '团队房源管理',
            ),
          ],
          iconSize: 26,
        ),
        body: _currentIndex == 0? HouseListPage()
            : TeamHousePage()
    );
  }
}
