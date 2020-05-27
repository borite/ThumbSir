import 'package:ThumbSir/pages/mycenter/broker_center_group_page.dart';
import 'package:ThumbSir/pages/mycenter/s_center_group_page.dart';
import 'package:flutter/material.dart';

import 'm_center_group_page.dart';

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
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1,-1),
                        margin: EdgeInsets.only(top: 8,left: 35),
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
                                      color: Color(0xFFcccccc),
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
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: Text(
                                '张三丰',
                                style:TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 145,left: 30,bottom: 50),
                        child: Text(
                          '已付费至2021年3月15日，查看详情',
                          style:TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 108,
                        left: 125,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.only(top:2,bottom: 2,left: 5,right: 5),
                          decoration: BoxDecoration(
//                            border: Border.all(color: Color(0xFF0E7AE6),width: 1), // 经纪人蓝色
//                            border: Border.all(color: Color(0xFF24CC8E),width: 1), // 店长绿色
//                            border: Border.all(color: Color(0xFFFF9600),width: 1), // 商圈经理橘色
                            border: Border.all(color: Color(0xFF9149EC),width: 1), // 总监浅紫色
//                            border: Border.all(color: Color(0xFF7412F2),width: 1), // 副总经理深紫色
//                            border: Border.all(color: Color(0xFF003273),width: 1), // 总经理深蓝色
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
//                            '经纪人',
//                            '店长',
//                            '商圈经理',
                            '总监',
//                            '副总经理',
//                            '总经理',
                            style:TextStyle(
                              fontSize: 14,
//                              color: Color(0xFF0E7AE6), // 经纪人蓝色
//                              color: Color(0xFF24CC8E), // 店长绿色
//                              color: Color(0xFFFF9600), // 商圈经理橘色
                              color: Color(0xFF9149EC), // 总监浅紫色
//                              color: Color(0xFF7412F2), // 副总经理深紫色
//                              color: Color(0xFF003273), // 总经理深蓝色
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      )
                    ],
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
                                    color: Color(0xFF333333),
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
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20,right: 20),
                          child: GestureDetector(
                            onTap: (){
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BrokerCenterGroupPage()));
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MCenterGroupPage()));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SCenterGroupPage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image(image: AssetImage('images/group.png')),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
//                                      '长河湾北门店买卖A组成员',
//                                      '白石桥大区长河湾北门店成员',
                                        '白石桥大区成员',
                                        style:TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image(image: AssetImage('images/next.png'),)
                              ],
                            ),
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
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 32,
                                    height: 32,
                                    child: Image(image: AssetImage('images/vip.png'),fit: BoxFit.fill,),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '会员中心',
                                      style:TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Image(image: AssetImage('images/next.png'),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image(image: AssetImage('images/service.png')),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '客服中心',
                                      style:TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Image(image: AssetImage('images/next.png'),)
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
