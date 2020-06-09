import 'package:ThumbSir/pages/broker/qlist/qlist_change_page.dart';
import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/pages/mycenter/s_center_group_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangeMemberPage extends StatefulWidget {
  @override
  _ChangeMemberPageState createState() => _ChangeMemberPageState();
}

class _ChangeMemberPageState extends State<ChangeMemberPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                child: Text('更换成员',style: TextStyle(
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
                    child: Text('更换成员功能会将当前成员移出您所属的区域，并添加一位新的成员顶替该职位。确认更换后将解除当前成员的所有上下级关系，且该成员须重新填写区域，请慎重操作。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 确认移出
                  GestureDetector(
                    onTap: () => _onDeleteAlertPressed(context),
                    child: Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 80),
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
                  ),
                ]
            )
          ],
        )
    );
  }
  _onDeleteAlertPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否移出成员？",
      desc: "移出成员后该成员将被解除所有组织关系，请慎重选择！",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMemberPage())),
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        )
      ],
    ).show();
  }
}