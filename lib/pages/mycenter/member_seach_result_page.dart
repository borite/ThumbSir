import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MemberSeachResultPage extends StatefulWidget {
  @override
  _MemberSeachResultPageState createState() => _MemberSeachResultPageState();
}

class _MemberSeachResultPageState extends State<MemberSeachResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle_middle.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
                children: <Widget>[
                  // 导航栏
                  Padding(
                      padding: EdgeInsets.all(15),
                      child:Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('添加成员',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                  ),
                  // 头像
                  Container(
                    margin: EdgeInsets.only(top: 43),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFF93C0FB),width: 1)
                      ),
                      child:Image(
                        image: AssetImage('images/my_big.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 30,bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF93C0FB)))
                    ),
                    child: Text('马思唯',style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5580EB),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 30,bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF93C0FB)))
                    ),
                    child: Text('13812345678',style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5580EB),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 备注
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text('温馨提示',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text('添加成员功能只能添加直属下级，您正在添加对方为',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text('北京链家房地产经纪有限公司——北京市——京中大部——白石桥大区——长河湾北门店——买卖A组——经纪人',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5580EB),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Text('确认添加后，对方的消息中心会收到提醒，需对方同意后才能建立上下级连接，请提醒对方注意查看消息中心。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.center,),
                  ),
                  // 完成
                  Container(
                    width: 335,
                    height: 40,
                    padding: EdgeInsets.all(7),
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 80),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF5580EB)),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF5580EB)
                    ),
                    child: Text('确认添加',style: TextStyle(
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
    );
  }
}
