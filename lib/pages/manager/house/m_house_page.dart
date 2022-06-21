import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/manager/house/group_house_page.dart';
import 'package:ThumbSir/pages/manager/traded/group_traded_page.dart';
import 'package:flutter/material.dart';

import '../../broker/house/house_list_page.dart';


class MHousePage extends StatefulWidget {
  @override
  _MHousePageState createState() => _MHousePageState();
}

class _MHousePageState extends State<MHousePage> {
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
                label: '公司房源系统'
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
            : GroupHousePage()
    );
  }
}
