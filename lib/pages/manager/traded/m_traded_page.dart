import 'package:ThumbSir/pages/broker/traded/my_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/group_traded_page.dart';
import 'package:flutter/material.dart';


class MTradedPage extends StatefulWidget {
  @override
  _MTradedPageState createState() => _MTradedPageState();
}

class _MTradedPageState extends State<MTradedPage> {
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
                title: Text('我的老客户')
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
              title: Text('团队老客户'),
            ),
          ],
          iconSize: 26,
        ),
        body: _currentIndex == 0? MyTradedPage()
            : GroupTradedPage()
    );
  }
}
