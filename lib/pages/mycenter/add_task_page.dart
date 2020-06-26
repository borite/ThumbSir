import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/pages/mycenter/self_defined_task_page.dart';
import 'package:ThumbSir/widget/input.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';
class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  bool _loading = false;

  var taskMsg;

  List<Datum> tasks = [];
  List<Widget> tasksShowList = [];

  final TextEditingController taskNameController = TextEditingController();
  String taskName;
  RegExp taskNameReg;
  bool taskNameBool;
  final TextEditingController taskUnitController = TextEditingController();
  String taskUnit;
  RegExp taskUnitReg;
  bool taskUnitBool;

  _load() async {
    var taskList = await GetDefaultTaskDao.httpGetDefaultTask();
    if (taskList.code == 200) {
      setState(() {
        tasks = taskList.data;
        _loading = false;
      });
    } else {
      _onLoadAlert(context);
    }
  }

  @override
  void initState() {
    _load();
    _onRefresh();
    taskNameReg = taskReg;
    taskUnitReg = taskReg;
    super.initState();
  }

  Widget taskItem() {
    Widget content;
    if (tasks != null) {
      for (var item in tasks) {
        tasksShowList.add(
          Container(
              height: 40,
              width: 335,
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF93C0FB)),
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
                        margin: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFF93C0FB),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          ((tasksShowList.length) + 1).toString(),
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
                        item.taskName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          '单位:' + item.taskUnit,
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
                    onTap: () => _onDeleteAlertPressed(context, item),
                    child: Container(
                      width: 40,
                      child: Image(
                        image: AssetImage('images/delete_blue.png'),),
                    ),
                  ),
                ],
              )
          ),
        );
      }
    }
    content = Wrap(
      spacing: 15,
      runSpacing: 10,
      children: tasksShowList,
    );

    return content;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg: "加载中...",
            child: Container(
              // 背景
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('images/circle.png'),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Image(image: AssetImage(
                                            'images/back.png'),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          '为下级设置任务名称', style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF0E7AE6),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
//                                  Navigator.push(
//                                      context, MaterialPageRoute(builder: (context)=>SelfDefinedTaskPage())
//                                  ).then((msg){
////                                    print(msg);
////                                    tasks.add(msg);
////                                    var addT=tasks;
//                                    //print(tasks);
//                                    //tasks.add(msg);
//                                    //print(tasks);
////                                    tasks = [];
//                                    setState(() {
//                                      tasks.add(msg);
////                                      tasks=addT;
//                                    });
//                                  });
                                      _onNewTaskAlertPressed(context);
                                    },
                                    child: Text('新增', style: TextStyle(
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
                              padding: EdgeInsets.only(top: 40, bottom: 50),
                              child: taskItem()
                          ),
                          // 完成
                          Container(
                              width: 335,
                              height: 40,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(bottom: 50, top: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF5580EB)
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: GestureDetector(
                                    onTap: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninChooseCompanyPage()));
                                    },
                                    child: Text('完成', style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ), textAlign: TextAlign.center,),
                                  )
                              )
                          ),
                        ]
                    )
                  ],
                )
            )
        )
    );
  }

  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }

  _onDeleteAlertPressed(context, item) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: '是否删除"' + item.taskName + '"任务？',
      desc: '删除后您的下级将看不能再以"' + item.taskName + '"作为量化任务选项，请慎重选择',
      buttons: [
        DialogButton(
          child: Text(
            "确认删除",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            var removedBool = tasksShowList.remove(item);
            print(removedBool);
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "再想想",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        )
      ],
    ).show();
  }

  _onLoadAlert(context) {
    Alert(
      context: context,
      title: "加载任务失败",
      desc: "请检查网络连接情况",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _loading = false;
            });
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }

  // 新增任务弹窗
  _onNewTaskAlertPressed(context) {
    Alert(
      context: context,
      title: "新增任务",
      content: Column(
        children: <Widget>[
          // 名称
          Input(
            hintText: "任务名称",
            errorTipText: "请输入任务名称，1~5个汉字或字母",
            tipText: "请输入任务名称，1~5个汉字或字母",
            rightText: "任务名称格式正确",
            controller: taskNameController,
            inputType: TextInputType.text,
            reg: taskNameReg,
            onChanged: (text) {
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
            onChanged: (text) {
              setState(() {
                taskUnit = text;
                taskUnitBool = taskUnitReg.hasMatch(taskUnit);
              });
            },
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            taskMsg=new Datum(id: 0,taskName: taskNameController.text,taskDesc: null,taskUnit: taskUnitController.text);
            tasks.add(taskMsg);
            print(tasks);
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFFCCCCCC),
        )
      ],
    ).show();
  }
}
