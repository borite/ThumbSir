import 'package:ThumbSir/dao/check_lates_version_dao.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class IntroduceVersionPage extends StatefulWidget {
  @override
  _IntroduceVersionPageState createState() => _IntroduceVersionPageState();
}

class _IntroduceVersionPageState extends State<IntroduceVersionPage> {
  bool _loading = false;
  var versionMsg;

  _load() async {
    var versionResult = await CheckLatestVersionDao.checkVersion();
    if (versionResult.code == 200) {
      setState(() {
        versionMsg = versionResult.data;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
          loading: _loading,
          msg: "加载中...",
          child:Container(
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
                                child: Text('新版本介绍',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                        ),
                        // 头像
                        Container(
                          margin: EdgeInsets.only(top: 43),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Color(0xFFcccccc),
                                  offset: Offset(0.0, 3.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0
                              )],
                            ),
                            child:Image(
                              image: AssetImage('images/tie.png'),
                            ),
                          ),
                        ),
                        // 标题
                        Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('拇指先生',style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                                Text(
                                  versionMsg != null ? versionMsg.version :'',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF5580EB),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                ),),
                                Text('版',style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              ],
                            )
                        ),
                        // 内容
                        Container(
                          padding: EdgeInsets.only(top:40),
                          width: 335,
                          child:
//                          Text(
//                            versionMsg != null ? versionMsg.versionDes :'',
//                            style: TextStyle(
//                              fontSize: 14,
//                              color: Color(0xFF666666),
//                              fontWeight: FontWeight.normal,
//                              decoration: TextDecoration.none,
//                          ),textAlign: TextAlign.left,),
                          Column(
                            children: <Widget>[
                              Text(
                                '量化工具主要功能包括：添加个人量化任务，个人量化任务列表，个人量化分析，团队量化任务列表，团队量化分析，根据注册时选择的职级开放其中的2~5个功能。',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                              ),textAlign: TextAlign.left,),
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '产品亮点：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                              ),
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '（1）量化任务完成度根据上传或拍摄的交付物由系统智能分析，实时体现在个人量化分析和团队量化分析中，结果准确且方便查询；',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                              ),
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '（2）拍摄照片自动添加时间和地点水印，并将拍摄照片时的地点体现在量化任务列表中，降低作弊成本且结果直观显示；',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                              ),
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '（3）上级可以为下级设置最低任务量，协助上级找准KPI并准确下达；',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                              ),
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '（4）时间分布分析，根据任务规划，分析工作时间各个量化任务的时间占比，准确把握时间流向，快速找到影响业绩的关键指标。',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                              ),
                              Container(
                                width: 335,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '如果您在使用过程中有任何的意见或者建议，请在个人中心的客服中心进行留言，拇指先生客服会尽快与您联系，我们将持续更新和改进，感谢您对拇指先生的支持，祝您使用愉快！',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),textAlign: TextAlign.left,),
                              ),
                            ],
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
