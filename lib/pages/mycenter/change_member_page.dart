import 'package:ThumbSir/pages/mycenter/add_member_page.dart';
import 'package:ThumbSir/pages/mycenter/change_member_search_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangeMemberPage extends StatefulWidget {
  final msg;
  ChangeMemberPage({this.msg});
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
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image(
                          image: widget.msg== null?
                          AssetImage('images/my_big.png')
                              :widget.msg != null && widget.msg.headImg == null?
                          AssetImage('images/my_big.png')
                              :NetworkImage(widget.msg.headImg),
                        ),
                      )
                    ),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 30,bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Color(0xFF93C0FB)))
                    ),
                    child: Text(widget.msg!= null ? widget.msg.userName:'',style: TextStyle(
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
                    child: Text(widget.msg!= null ? widget.msg.phone:'',style: TextStyle(
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
                    child: Text('更换成员成功后会将当前成员移出您所属的区域，并添加一位新的成员顶替该职位并获得当前成员的所有组织关系。确认更换后将解除当前成员的所有组织关系。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 确认移出
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeMemberSearchPage(
                        oldMemberId : widget.msg.userPid
                      )));
                    },
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
}
