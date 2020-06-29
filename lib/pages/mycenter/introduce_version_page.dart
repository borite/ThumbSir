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
                          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: Text(
                            versionMsg != null ? versionMsg.versionDes :'',
                            style: TextStyle(
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
