import 'dart:convert';
import 'package:ThumbSir/dao/creat_mission_dao.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/mycenter/choose_mini_task_number_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ThumbSir/model/set_kpimission_item_model.dart';

class ChooseMiniTaskPage extends StatefulWidget {
  @override
  _ChooseMiniTaskPageState createState() => _ChooseMiniTaskPageState();
}

class _ChooseMiniTaskPageState extends State<ChooseMiniTaskPage> {
  String minCount = "1";
  List missionContent=new List();
  List idList = [];
  String selectTaskIDs="";
  int itemLength = 0;

  List<String> tags = [];

  var taskMsg;
  List<Datum> tasks = [];
  List<Widget> tasksShowList = [];

  bool _loading = false;

  LoginResultData userData;
  String uinfo;
  var result;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uinfo= prefs.getString("userInfo");
    if(uinfo != null){
      result =loginResultDataFromJson(uinfo);
      this.setState(() {
        userData=LoginResultData.fromJson(json.decode(uinfo));
      });
    }
  }
  _load() async {
    var taskList = await GetDefaultTaskDao.httpGetDefaultTask();
    if (taskList.code == 200) {

      List<Datum> filteredList=new List();

      taskList.data.forEach((element) {
        if(element.id!=12 && element.id!=13 && element.id!=14){
          filteredList.add(element);
        }
      });

      setState(() {
        tasks = filteredList;
        _loading = false;
      });
    } else {
      _onLoadAlert(context);
    }
  }

  @override
  void initState() {
    _getUserInfo();
    _load();
    _onRefresh();
    super.initState();
  }

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
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              },
                            child: Image(image: AssetImage('images/back.png'),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text('为下级设置最低任务量',style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        ],
                      ),
                  ),
                  // 选择任务
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              '选择核心任务(2~8项)',
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
                  Content(
                    title: '可选的任务名称（ 多选 ）',
                    child: FormField<List<String>>(
                      initialValue: tags,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '请选择核心任务的名称';
                        }
                        if (value.length > 8) {
                          return "选择不可多于8项";
                        }
                        return null;
                      },
                      builder: (state) {
                      return Column(
                        children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ChipsChoice<String>.multiple(
                              value: state.value,
                              options:  ChipsChoiceOption.listFrom<String,Datum>(
                                source: tasks,
                                // 存储形式
                                value:(index,item)=>'{"ID":"'+item.id.toString()+'","TaskTitle":"'+item.taskName+'","TaskUnit":"'+item.taskUnit+'"}',
                                // 展示形式
                                label: (index,item)=>item.taskName
                            ),
                              onChanged: (val) {
                                state.didChange(val);
                                missionContent = val;
                                String ids="";
                                val.forEach((element) {
                                  var item=selectItemFromJson(element);
                                  print(item);
                                  ids+=item.id+',';
                                  selectTaskIDs = ids;
                                  print(selectTaskIDs);
                                  if(state.value != null){
                                    setState(() {
                                      itemLength = state.value.length;
                                    });
                                  }
                                });
                              },
                              itemConfig: ChipsChoiceItemConfig(
                                selectedColor: Color(0xFF5580EB),
                                selectedBrightness: Brightness.dark,
                                unselectedColor: Color(0xFF5580EB),
                                unselectedBorderOpacity: .3,
                              ),
                              isWrapped: true,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.errorText ?? state.value.length.toString() + '/8 可选',
                            style: TextStyle(
                              color: state.hasError
                              ? Colors.redAccent
                              : Colors.green
                            ),
                          )
                        )
                      ]);}
                    )
                  ),
                  // 最低完成量
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '最低完成量',
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
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '设置每日最低完成任务数量：',
                            style: TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 120,
                          margin: EdgeInsets.only(top: 28),
                          child: WheelChooser(
                            onValueChanged: (s){
                              setState(() {
                                minCount = s;
                              });
                            },
                            datas: ["1", "2", "3", "4", "5","6","7","8"],
                            selectTextStyle: TextStyle(
                                color: Color(0xFF0E7AE6),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: 12
                            ),
                            unSelectTextStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: 12
                            ),
                          ),
                        ),
                        Text('项',style: TextStyle(
                          color: Color(0xFF0E7AE6),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),)
                      ],
                    ),
                  ),
                  // 说明
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Container(
                        child: Text(
                            '说明：每日最少完成上面所选的任务中的任意几项任务就算下级的今日任务量达标。',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.left,
                          ),
                      )
                  ),
                  // 下一步
                  GestureDetector(
                    onTap: ()async{
                      if(userData != null && itemLength>1 && itemLength<=8){
                        var creatMissionResult = await CreatMissionDao.creatMission(
                            userData.companyId,
                            userData.userPid,
                            selectTaskIDs,
                            minCount,
                            userData.userLevel.substring(0,1),
                            missionContent
                        );
                        print(creatMissionResult.code);
                        if(creatMissionResult.code == 200){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseMiniTaskNumberPage()));
                        }
                      }else{}
                    },
                    child: Container(
                        width: 335,
                        height: 40,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(bottom: 50,top: 100),
                        decoration: itemLength>1 && itemLength<=8 ?
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
                            child: Text('下一步',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),textAlign: TextAlign.center,),
                        )
                    ),
                  ),
                ]
            )
          ],
        )
    );
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
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
}


class Content extends StatelessWidget {

  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Color(0x205580EB),
            child: Text(
              title,
              style: TextStyle(
                  color: Color(0xFF5580EB),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

