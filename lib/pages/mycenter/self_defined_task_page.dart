import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/pages/mycenter/add_task_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';

class SelfDefinedTaskPage extends StatefulWidget {
  @override
  _SelfDefinedTaskPageState createState() => _SelfDefinedTaskPageState();
}

class _SelfDefinedTaskPageState extends State<SelfDefinedTaskPage> {
  final TextEditingController taskNameController = TextEditingController();
  String taskName;
  RegExp taskNameReg;
  bool taskNameBool;
  final TextEditingController taskUnitController=TextEditingController();
  String taskUnit;
  RegExp taskUnitReg;
  bool taskUnitBool;

  var taskMsg;

  @override
  void initState() {
    taskNameReg = taskReg;
    taskUnitReg = taskReg;
    super.initState();
  }

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
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '新增自定义任务',
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
                    // 名称
                    Input(
                      hintText: "任务名称",
                      errorTipText: "请输入任务名称，1~5个汉字或字母",
                      tipText: "请输入任务名称，1~5个汉字或字母",
                      rightText: "任务名称格式正确",
                      controller: taskNameController,
                      inputType: TextInputType.text,
                      reg: taskNameReg,
                      onChanged: (text){
                        setState(() {
                          taskName = text;
                          taskNameBool = taskNameReg.hasMatch(taskName);
                        });
                      },
                    ),
                    // 单位
                    Input(
                      hintText: "任务单位",
                      tipText: "请输入任务单位，1~5个汉字或字母",
                      errorTipText: "请输入任务单位，1~5个汉字或字母",
                      rightText: "任务单位格式正确",
                      controller: taskUnitController,
                      inputType: TextInputType.phone,
                      reg: taskUnitReg,
                      onChanged: (text){
                        setState(() {
                          taskUnit = text;
                          taskUnitBool = taskUnitReg.hasMatch(taskUnit);
                        });
                      },
                    ),
                    // 完成
                    GestureDetector(
                      onTap: (){
                        if(taskNameBool == true && taskUnitBool == true){
                          setState(() {
                            taskMsg=new Datum(id: 0,taskName: taskNameController.text,taskDesc: null,taskUnit: taskUnitController.text);
                          });
                          Navigator.of(context).pop(
                            taskMsg
                          );
                        }else{}
                      },
                      child: Container(
                          width: 335,
                          height: 40,
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(bottom: 50,top: 100),
                          decoration: taskNameBool == true && taskUnitBool == true ?
                          BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF5580EB)),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF5580EB)
                          )
                          :
                          BoxDecoration(
                            border: Border.all(width: 1,color: Color(0xFF93C0FB)),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF93C0FB)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text('完成',style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),textAlign: TextAlign.center,),
                          )
                      ),
                    )
                  ]
              )
            ],
          )
      ),
    );
  }
}
