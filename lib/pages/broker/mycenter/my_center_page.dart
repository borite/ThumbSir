import 'package:flutter/material.dart';

class MyCenterPage extends StatefulWidget {
  @override
  _MyCenterPageState createState() => _MyCenterPageState();
}

class _MyCenterPageState extends State<MyCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Image(image: AssetImage('images/set.png')),
                        ],
                      )
                  ),
                  // 头像按钮
                  Container(
                    alignment: Alignment(-1,-1),
                    margin: EdgeInsets.only(top: 20,left: 35,bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFcccccc),width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                                color: Colors.white
                            ),
                            child:Image(
                              image: AssetImage('images/my_big.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text(
                            '张三',
                            style:TextStyle(
                              fontSize: 20,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Text(
                            '20246917',
                            style:TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 详情菜单
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/company.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '北京链家房地产经纪有限公司',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/site.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '北京市 海淀区',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/group.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '长河湾北门店',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/phone.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '商圈经理',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/phone.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '13812345678',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/phone.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '维护人：李四 13887654321',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/company.png')),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  '意见反馈',
                                  style:TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
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
                  )
                ]
            )
          ],
        )

    );
  }
}
