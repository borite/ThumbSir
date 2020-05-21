import 'package:ThumbSir/dao/login_dao.dart';
import 'package:ThumbSir/model/login_model.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/pages/login/find_key_phone_page.dart';
import 'package:ThumbSir/pages/login/signin_nameandphone_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/input.dart';

class InvitationPage extends StatefulWidget {
  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final TextEditingController phoneNumController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                        height: 375,
                        decoration: BoxDecoration(
                          color: Color(0xFF5580EB),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                            image:AssetImage('images/circle_s.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child:Column(
                          children: <Widget>[
                            // 背景与导航
                            Container(
                              height: 100,
                              padding: EdgeInsets.only(top:30),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 15,top: 3),
                                          child: Image(image: AssetImage('images/back_white.png'),),
                                        ),
                                      ),
                                      Container(
                                        margin:EdgeInsets.only(left:10),
                                        child: Text(
                                          '邀请成员',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment(-1,-1),
                              margin: EdgeInsets.only(top: 15,left: 37),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(45)),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(
                                            color: Color(0xFF666666),
                                            offset: Offset(0.0, 3.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0
                                        )],
                                      ),
                                      child:Image(
                                        image: AssetImage('images/my_big.png'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10,bottom: 30),
                                    child: Text(
                                      '创建职位邀请',
                                      style:TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  )
                ]
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  width: 335,
                  height: 350,
                  margin: EdgeInsets.only(top: 120),
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                      color: Color(0xFFcccccc),
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
                    )],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '1.职位邀请功能只能添加直属下级，您正在添加对方为北京链家房地产经纪有限公司，北京市-京中大部-白石桥大区-长河湾北门店-买卖A组经纪人。',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        '2.分享邀请后会生成一个口令链接，您可将其发送至微信、QQ聊天等；他人打开链接并同意加入小组后会在您的消息中心有反馈，双向同意后才能建立上下级关系，请注意查看。',
                        style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    // 登录
                    GestureDetector(
//                      onTap:() async{
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
//                      },
                      child: Container(
                        width: 295,
                        height: 40,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(top: 60),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xFF5580EB)),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF5580EB)
                        ),
                        child: Padding(
                        padding: EdgeInsets.only(top: 4),
                          child: Text('分享我的邀请',style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),textAlign: TextAlign.center,),
                        )
                      ),
                    ),],
                  ),
                ),
              ),
          ],
        )
      );
  }
}
