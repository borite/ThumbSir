import 'package:ThumbSir/dao/delete_message_dao.dart';
import 'package:ThumbSir/dao/get_message_dao.dart';
import 'package:ThumbSir/dao/update_message_state_dao.dart';
import 'package:ThumbSir/pages/tips/agree_invitation_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
  var pageindex=0;
  var userID;

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID=prefs.get("userID");
    //String userId= prefs.getString("userID");
    if(userID != null){
      pageindex++;
      var msgResult = await GetMessageDao.getMessage(userID,'2',pageindex.toString(),'10');
      if (msgResult.code == 200) {
        msgList=msgResult.data;
        if (msgList.length>0) {
          setState(() {
            for (var item in msgList) {
              msgs.add(
                GestureDetector(
                  onTap: ()async{
                    await UpdateMessageStateDao.updateState(item.id.toString(), '2');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AgreeInvitationPage(
                      item:item,
                    )));
                  },
                  child: _item(item.id,'images/tie_big.png',item.sendTime.toIso8601String().substring(0,10),item.msgTitle,item.msgContent,item.state.toString()),
                ),
              );
            }
          });

        }

        print(msgs);

//        msgList = msgResult.data;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
    _scrollController.addListener(() {
      // 如果滚动位置到了可滚动的最大距离，就加载更多
      //print("1234");
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print("可以加载了");

        _load();
      }
    });

  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30),
        // 背景
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
                    padding: EdgeInsets.only(top:15,left: 15,right: 15,bottom: 5),
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
                        Container(width: 30,),
                      ],
                    )
                ),

                // 消息提醒
                Expanded(
                    child: msgs.length>0 ?
                      ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.only(top: 20,bottom: 30),
                        shrinkWrap: true,
                        itemCount: msgs.length,
                        //children: msgs,
                        itemBuilder: (BuildContext context,int index){
                          return msgs[index];
                        },
                      )
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

  _item(var id,var image,String date,String content,String tip,String state){
    //return Text(content);
    bool check = false;
    return Container(
        alignment: Alignment.center,
        child: // 提醒条目
        Container(
          child: Stack(
            children: <Widget>[
              // 消息主体
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
              // 左边的图
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
              state == '2' ?
                  // 已读显示删除按钮
              GestureDetector(
                onTap: (){
                  _onDeleteAlertPressed(id);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 290,top: 5),
                  child: Image(image: AssetImage('images/delete_blue.png'),),
                ),
              )
                  :
                  // 未读显示小红点
              Container(
                margin: EdgeInsets.only(left: 310,top: 20),
                height: 20,
                child: Image(image: AssetImage('images/red_dot.png'),),
              ),
            ],
          ),
        ),
    );
  }

  _onDeleteAlertPressed(id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否删除此条消息？",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            var deleteResult = await DeleteMessageDao.deleteMessage(id.toString());
            if(deleteResult.code == 200){
//              msgList = [];
//              msgs=[];
              _load();
              Navigator.pop(context);
            }
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
        ),
      ],
    ).show();
  }
}
