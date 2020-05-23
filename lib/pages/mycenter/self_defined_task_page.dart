import 'package:flutter/material.dart';

class SelfDefinedTaskPage extends StatefulWidget {
  @override
  _SelfDefinedTaskPageState createState() => _SelfDefinedTaskPageState();
}

class _SelfDefinedTaskPageState extends State<SelfDefinedTaskPage> {
  final TextEditingController taskNameController=TextEditingController();
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('为下级设置任务名称',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        ],
                      ),
                    ),
                    // 说明
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '自定义任务',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                    ),
                    // 填写
                    Container(
                      width: 335,
                      height: 40,
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF2692FD)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: taskNameController,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "任务名称"
                        ),
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 40,
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF2692FD)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: taskNameController,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "任务单位"
                        ),
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 40,
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xFF2692FD)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: taskNameController,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 10, 10),
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "任务说明"
                        ),
                      ),
                    ),
                    // 完成
                    Container(
                        width: 335,
                        height: 40,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(bottom: 50,top: 100),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF5580EB)),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF5580EB)
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: GestureDetector(
                              onTap: (){
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
                              },
                              child: Text('完成',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                            )
                        )
                    ),
                  ]
              )
            ],
          )
      ),
    );
  }
}
