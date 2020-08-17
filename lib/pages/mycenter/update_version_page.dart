import 'package:ThumbSir/dao/check_lates_version_dao.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateVersionPage extends StatefulWidget {
  @override
  _UpdateVersionPageState createState() => _UpdateVersionPageState();
}

class _UpdateVersionPageState extends State<UpdateVersionPage> {
  var versionMsg;
  bool _loading = false;
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

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _load();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle ?? 'Not set'),
    );
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
                              child: Text('检查与更新',style: TextStyle(
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
                        child: Text(
                          versionMsg != null && _packageInfo != null && _packageInfo.version != versionMsg.version ?
                          '请更新最新版本：':'当前已经是最新版本：',
//                        '已更新至最新版本：',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                      ),
                      // 副标题
                      Padding(
                          padding: EdgeInsets.only(top: 5),
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
                                versionMsg != null ? versionMsg.version:'',
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
                      // 更新
                      versionMsg != null && _packageInfo != null && _packageInfo.version != versionMsg.version ?
                     // 更新按钮
//                      Container(
//                        width: 335,
//                        height: 40,
//                        padding: EdgeInsets.all(7),
//                        margin: EdgeInsets.fromLTRB(0, 60, 0, 80),
//                        decoration: BoxDecoration(
//                            border: Border.all(width: 1,color: Color(0xFF5580EB)),
//                            borderRadius: BorderRadius.circular(8),
//                            color: Color(0xFF5580EB)
//                        ),
//                        child: Text('更新',style: TextStyle(
//                          fontSize: 16,
//                          color: Colors.white,
//                          fontWeight: FontWeight.normal,
//                          decoration: TextDecoration.none,
//                        ),textAlign: TextAlign.center,),
//                      )
                      Container(
                        width: 335,
                        height: 40,
                        padding: EdgeInsets.all(7),
                        margin: EdgeInsets.fromLTRB(0, 60, 0, 80),
                        child: Text('请前往应用商店进行更新',style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF5580EB),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),textAlign: TextAlign.center,),
                      )
                      :Container(width: 1,),
                    ]
                )
              ],
            )
        )
        )
    );
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
