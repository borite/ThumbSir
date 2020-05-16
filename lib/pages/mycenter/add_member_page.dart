import 'package:ThumbSir/pages/mycenter/member_seach_result_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 背景
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image:AssetImage('images/circle.png'),
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
                              padding: EdgeInsets.only(left: 10),
                              child: Text('添加成员',style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),),
                            )
                          ],
                        )
                    ),
                    Input(defaultText: '输入下级姓名或手机号',),
                    // 搜索结果
                    Container(
                      width: 335,
                      padding: EdgeInsets.fromLTRB(10,20,15,0),
                      margin: EdgeInsets.only(top: 20,bottom: 30),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberSeachResultPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(45)),
                                            color: Colors.white,
                                            border: Border.all(color: Color(0xFF93C0FB),width: 1)
                                        ),
                                        child:Image(
                                          image: AssetImage('images/my_big.png'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        width: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '马思维',
                                                  style:TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF333333),
                                                    fontWeight: FontWeight.normal,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10),
                                                  child: Image(image: AssetImage('images/vip_yellow.png'),),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                '18612345678',
                                                style:TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF999999),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('学院派物美店',style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(45)),
                                          color: Colors.white,
                                          border: Border.all(color: Color(0xFF93C0FB),width: 1)
                                      ),
                                      child:Image(
                                        image: AssetImage('images/my_big.png'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '马思维1',
                                                style:TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF333333),
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Image(image: AssetImage('images/vip_yellow.png'),),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              '18612345678',
                                              style:TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF999999),
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text('时代之光南门店',style: TextStyle(color: Color(0xFF999999),fontSize: 14),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 发送邀请码
                    Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('您还可以向下级发送职位邀请，马上去分享链接',style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5580EB),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.left,),
                            ],
                          ),
                          Image(image: AssetImage('images/next_blue.png'),)
                        ],
                      ),
                    ),
                  ]
              )
            ],
          )
      ),
    );
  }
}
