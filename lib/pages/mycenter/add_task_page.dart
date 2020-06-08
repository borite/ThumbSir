import 'package:ThumbSir/pages/mycenter/self_defined_task_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _dateTime = DateTime.now();

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
                          Row(
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
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfDefinedTaskPage()));
                            },
                            child: Text('新增',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          ),
                        ],
                      )
                  ),
                  // 说明
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              '删除、新增任务名称与单位',
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
                  // 任务item
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 40,bottom: 50),
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      children: <Widget>[
                        Container(
                            height: 40,
                            width: 335,
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.only(top: 2),
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF93C0FB),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '带看',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10,top: 2),
                                      child: Text(
                                        '单位:组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _onDeleteAlertPressed(context),
                                  child: Container(
                                    width: 40,
                                    child: Image(image: AssetImage('images/delete_blue.png'),),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height: 40,
                            width: 335,
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.only(top: 2),
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF93C0FB),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '带看',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10,top: 2),
                                      child: Text(
                                        '单位:组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _onDeleteAlertPressed(context),
                                  child: Container(
                                    width: 40,
                                    child: Image(image: AssetImage('images/delete_blue.png'),),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height: 40,
                            width: 335,
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.only(top: 2),
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF93C0FB),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '带看',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10,top: 2),
                                      child: Text(
                                        '单位:组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _onDeleteAlertPressed(context),
                                  child: Container(
                                    width: 40,
                                    child: Image(image: AssetImage('images/delete_blue.png'),),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height: 40,
                            width: 335,
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.only(top: 2),
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF93C0FB),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '带看',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10,top: 2),
                                      child: Text(
                                        '单位:组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _onDeleteAlertPressed(context),
                                  child: Container(
                                    width: 40,
                                    child: Image(image: AssetImage('images/delete_blue.png'),),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height: 40,
                            width: 335,
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.only(top: 2),
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF93C0FB),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '带看',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10,top: 2),
                                      child: Text(
                                        '单位:组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _onDeleteAlertPressed(context),
                                  child: Container(
                                    width: 40,
                                    child: Image(image: AssetImage('images/delete_blue.png'),),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height: 40,
                            width: 335,
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: EdgeInsets.only(top: 2),
                                      margin: EdgeInsets.only(right: 10,left: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF93C0FB),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      '带看',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10,top: 2),
                                      child: Text(
                                        '单位:组',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF999999),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _onDeleteAlertPressed(context),
                                  child: Container(
                                    width: 40,
                                    child: Image(image: AssetImage('images/delete_blue.png'),),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  // 完成
                  Container(
                      width: 335,
                      height: 40,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 50,top: 20),
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
    );
  }
  _onDeleteAlertPressed(context) {
    Alert(
      context: context,
      title: "是否删除'带看'任务？",
      desc: "删除后您和您的下级将看不再有此任务选项，请慎重选择",
      buttons: [
        DialogButton(
          child: Text(
            "确认删除",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF5580EB),
          width: 120,
        )
      ],
    ).show();
  }
}
