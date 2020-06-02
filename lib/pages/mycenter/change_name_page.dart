import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 背景
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image:AssetImage('images/circle_middle.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                  children: <Widget>[
                    // 导航栏
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Text('设置姓名',style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0E7AE6),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                          Container(width: 20,)
                        ],
                      ),
                    ),
                    // 头像
                    Input(
                      hintText: '马思唯',
                      tipText: '为了便于您的同事找到您，建议使用真实姓名',
                    ),
                    // 相册中选取
                    Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.fromLTRB(0, 60, 0, 80),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF5580EB)
                      ),
                      child: Text('确认更换',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),textAlign: TextAlign.center,),
                    ),
                  ]
              )
            ],
          )
      ),
    );
  }
}
