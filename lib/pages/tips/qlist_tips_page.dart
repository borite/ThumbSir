import 'package:ThumbSir/dao/get_message_dao.dart';
import 'package:ThumbSir/dao/update_message_state_dao.dart';
import 'package:ThumbSir/pages/tips/agree_invitation_page.dart';
import 'package:ThumbSir/widget/auto_complete_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QListTipsPage extends StatefulWidget {
  @override
  _QListTipsPageState createState() => _QListTipsPageState();
}

class _QListTipsPageState extends State<QListTipsPage> with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  var msgList;
  List<Widget> msgShowList = [];
  List<Widget> msgs=[];


  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId= prefs.getString("userID");
    if(userId != null){
      var msgResult = await GetMessageDao.getMessage(userId,'2','1','20');
      if (msgResult.code == 200) {
        msgList=msgResult.data;
        if (msgList.length>0) {
          for (var item in msgList) {
            msgShowList.add(
              _item('images/tie_big.png',item.sendTime.toIso8601String().substring(0,10),item.msgTitle,item.msgContent,item.state.toString()),
            );
          }
        }
        setState(() {
          msgs=msgShowList;
        });
//        msgList = msgResult.data;
      }
    }
  }

  _loadMore()async{
    // 延迟200毫秒
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      // 复制数组
      List<String>list = List<String>.from(msgList);
      list.addAll(msgList);
      msgList = list;
    });
  }

  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  bool isCheck = false; // 复选框是否被选中
  int checkBoxState = 0;  // 复选框是否出现，0为未出现，1为出现

  @override
  void initState() {
    _load();
    super.initState();
    controller = AnimationController(vsync:this,duration: Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0,end:30).animate(
        CurvedAnimation(parent: controller,curve: Curves.easeInOut)
          ..addListener(() {
            setState(() {
              animationValue = animation.value;
            });
          })
          ..addStatusListener((AnimationStatus state) {
            setState(() {
              animationStatus = state;
            });
          })
    );
    _scrollController.addListener(() {
      // 如果滚动位置到了可滚动的最大距离，就加载更多
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _loadMore();
      }
    });
  }

  @override
  void dispose(){
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

//  ListView msgItem() {
//    Widget content;
//    if (msgs != null) {
//      for (var item in msgs) {
//        msgShowList.add(
//          GestureDetector(
//            onTap: ()async{
//              await UpdateMessageStateDao.updateState(item.id.toString(), '2');
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>AgreeInvitationPage(
//                item:item,
//              )));
//            },
//            child: _item('images/tie_big.png',item.sendTime.toIso8601String().substring(0,10),item.msgTitle,item.msgContent,item.state.toString()),
//          ),
//        );
//      }
//    }
//    content = Column(
//      children: msgShowList,
//    );
//
//    return content;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 背景
        padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image:AssetImage('images/circle.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Column(
              children: <Widget>[
                // 导航栏
                Padding(
                    padding: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image(image: AssetImage('images/back.png'),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Row(
                            children: <Widget>[
                              Image(image: AssetImage('images/bell.png')),
                              Text(
                                '消息中心',
                                style:TextStyle(
                                  color: Color(0xFF0E7AE6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ],
                          ),
                        ),
                        isCheck == true && checkBoxState == 1?
                        GestureDetector(
                          onTap: (){
                            controller.reverse();
                            setState(() {
                              checkBoxState = 0;
                            });
                          },
                          child: Text(
                            '删除',
                            style:TextStyle(
                              color: Color(0xFFF24848),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                            :
                        isCheck == false && checkBoxState == 1?
                        GestureDetector(
                          onTap: (){
                            controller.reverse();
                            setState(() {
                              checkBoxState = 0;
                            });
                          },
                          child: Text(
                            '取消',
                            style:TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                            :
                        GestureDetector(
                          onTap: (){
                            controller.forward();
                            setState(() {
                              checkBoxState = 1;
                            });
                          },
                          child: Text(
                            '编辑',
                            style:TextStyle(
                              color: Color(0xFF0E7AE6),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                        ,
                      ],
                    )
                ),

                // 消息提醒
                Expanded(
                    child: msgs != [] ?
                      new ListView(
                        padding: EdgeInsets.only(top: 20),
                        shrinkWrap: true,
                        children: msgs,
                      )
//                    ListView.builder(
////                      shrinkWrap: true,
////                      children:msgs,
//                         itemCount: 3,
//                        itemBuilder: (BuildContext context,int index){
//                           return Text("aaa $index");
//                        },
//                    )
                        :Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        '暂无消息',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF999999)
                        ),
                      ),
                    )
//                      Column(
//                        children: <Widget>[
//                          _item('images/morning_tip.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!','1'),
//                          _item('images/noon_tip.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!','1'),
//                          _item('images/evening_tip.png','2020年3月24日','今天是章鱼哥的生日','记得送祝福!','1'),
//                        ],
//                      )

                )
              ]
          )
      ),
    );
  }

  _item(var image,String date,String content,String tip,String state){
    //return Text(content);
    bool check = false;
    return Container(
        width: 335,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 2,top: 25),
              child: Checkbox(
                value: check,
                activeColor: Color(0xFF0E7AE6),
                onChanged: (bool val) {
                  // val 是布尔值
                  setState(() {
                    check = !check;
                  });
                  if(check == true){
                    setState(() {
                      isCheck = true;
                    });
                  }else{
                    setState(() {
                      isCheck = false;
                    });
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: animation.value),
              child: Stack(
                children: <Widget>[
                  Container(
                      height: 102,
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Container(
                        height: 80,
                        width: 335,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(
                              color: Color(0xFFcccccc),
                              offset: Offset(0.0, 3.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0
                          )],
                        ),
                        child:Container(
                            padding: EdgeInsets.only(left: 100),
                            child:Column(
                              children: <Widget>[
                                Container(
                                  width: 220,
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    date,
                                    style:TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                      height: 2,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  child: Text(
                                    content,
                                    style:TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFF67419),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  child: Text(
                                    tip,
                                    style:TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFF67419),
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                  ),
                  Positioned(
                    left: 5,
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Image(
                        image:AssetImage(image),fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  state == '2' ?Container(width: 1,)
                      :Positioned(
                    top: -15,
                    left: 320,
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.red,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        )
    );
}
}
