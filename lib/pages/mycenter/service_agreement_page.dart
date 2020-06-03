import 'package:flutter/material.dart';

class ServiceAgreementPage extends StatefulWidget {
  @override
  _ServiceAgreementPageState createState() => _ServiceAgreementPageState();
}

class _ServiceAgreementPageState extends State<ServiceAgreementPage> {
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
                                child: Text('服务协议',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                  ),
                  // 标题
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('服务协议',style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 内容
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Text('拇指先生MZXS2.01版本是拇指先生上线后的第一版，感谢您的支持！',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text('本版本主要为量化功能，经纪人、组长、商圈经理可以添加、修改、删除、查看每日量化详情和分析。通过上传或拍摄照片，系统会自动判断完成情况。组长及以上职位还可以查看下级的量化详情和分析。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Text('为方便用户寻找上下级，注册后须先选择公司、职位、区域，如果所在公司不存在须先创建公司。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                ]
            )
          ],
        )
    );
  }
}
