import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetMyMsgPage extends StatefulWidget {
  @override
  _SetMyMsgPageState createState() => _SetMyMsgPageState();
}

class _SetMyMsgPageState extends State<SetMyMsgPage> {
  final TextEditingController textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            // 内容
            Container(
              color: Color(0xFFF2F2F2),
              child: ListView(
                children: <Widget>[
                  // 头像
                  Container(
                    color:Colors.white,
                    height:80,
                    margin: EdgeInsets.only(top: 65),
                    padding:EdgeInsets.only(left: 25,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // 头像
                        Container(
                          width:100,
                          child: Text(
                            '头像',
                            style:TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              height: 70,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(color: Color(0xFFF2F2F2),width: 1)
                              ),
                              child: Image(image: AssetImage("images/my_big.png"),),
                            ),
                            Image(image: AssetImage('images/next.png'),)
                          ],
                        )
                      ],
                    )

                  ),
                  // 姓名
                  Container(
                      color:Colors.white,
                      height: 60,
                      margin: EdgeInsets.only(top: 2),
                      padding:EdgeInsets.only(left: 25,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              '姓名',
                              style:TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin:EdgeInsets.only(right: 15),
                                child: Text(
                                  '马思唯',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          )
                        ],
                      )

                  ),
                  // 公司
                  Container(
                      color:Colors.white,
                      height: 60,
                      margin: EdgeInsets.only(top: 2),
                      padding:EdgeInsets.only(left: 25,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 330,
                                    padding: EdgeInsets.only(top: 8,bottom: 5),
                                    child: Text(
                                      '公司',
                                      style:TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: 330,
                                    child: Text(
                                      '北京链家房地产经纪有限责任公司',
                                      style:TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Image(image: AssetImage('images/next.png'),)
                        ],
                      )
                  ),
                  // 区域
                  Container(
                      color:Colors.white,
                      height: 60,
                      margin: EdgeInsets.only(top: 2),
                      padding:EdgeInsets.only(left: 25,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 330,
                                    padding: EdgeInsets.only(top: 8,bottom: 5),
                                    child: Text(
                                      '区域',
                                      style:TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: 330,
                                    child: Text(
                                      '北京-京中大部-白石桥大区-长河湾北门店-买卖1组',
                                      style:TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF999999),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Image(image: AssetImage('images/next.png'),)
                        ],
                      )
                  ),
                ],
              ),
            ),
            // 顶部导航区域
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF5580EB),
                image: DecorationImage(
                  image:AssetImage('images/circle.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child:Container(
                height: 80,
                padding: EdgeInsets.only(top: 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Image(image: AssetImage('images/back_w_arrow.png'),),
                      ),
                    ),
                    Text(
                      '个人信息',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Container(
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
