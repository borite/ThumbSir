import 'package:ThumbSir/dao/get_care_action_dao.dart';
import 'package:ThumbSir/pages/broker/client/client_add_gift_page.dart';
import 'package:ThumbSir/widget/client_gift_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';


class ClientActionMsg extends StatefulWidget {
  final item;

  ClientActionMsg({Key? key,
    this.item
  }):super(key:key);
  @override
  _ClientActionMsgState createState()=> _ClientActionMsgState();
}

class _ClientActionMsgState extends State<ClientActionMsg> with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  var pageIndex=0;
  var msgList;
  List<Widget> msgShowList = [];
  List<Widget> msgs=[];
  _load() async {
      pageIndex++;
      var msgResult = await GetCareActionDao.httpGetCareAction(
      widget.item.mid.toString(), pageIndex.toString(), '50');
      if (msgResult.code == 200) {
        msgList=msgResult.data;
        if (msgList.length>0) {
          setState(() {
            for (var item in msgList) {
              msgs.add(
                ClientGiftItem(
                  date:item.addTime.toString().substring(0,10),
                  giftMsg:item.giftName != null || item.giftName != ""? item.giftName:"未知",
                  price:item.giftPrice != null || item.giftPrice !=0.0 ? item.giftPrice.toString():"0",
                  dec:item.giftRemark != null || item.giftRemark != ""?item.giftRemark:"未填写",
                  type:item.giftReason != null || item.giftReason !=""?item.giftReason:"未知",
                  id:item.id.toString(),
                  item: widget.item,
                ),
              );
          }
          });
        }
      }
  }

  @override
  void initState(){
    super.initState();
    _load();
    _scrollController.addListener(() {
      // 如果滚动位置到了可滚动的最大距离，就加载更多
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
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
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:100,bottom:40),
                child: Column(
                  children: <Widget>[
                    // 姓名
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              margin: EdgeInsets.only(left: 20,right: 10,bottom: 10),
                              child: Image.asset("images/my_3.png"),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.item.userName,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )

                          ],
                        ),
                        // 新增按钮
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientAddGiftPage(
                              item: widget.item,
                            )));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                            margin: EdgeInsets.only(right: 20,top: 2,bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xFF93C0FB)
                                ),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text(
                              "+ 新增维护动作",
                              style: TextStyle(
                                  color: Color(0xFF93C0FB),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 维护记录列表
                    Container(
                        child: msgs.length>0 ?
                        ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(bottom: 30),
                          shrinkWrap: true,
                          itemCount: msgs.length,
                          itemBuilder: (BuildContext context,int index){
                            return msgs[index];
                          },
                        )
                            :
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            '暂无维护记录',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF999999)
                            ),
                          ),
                        )
                    ),

                  ],
                ),
              )
            ],
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
          },
          color: Color(0xFF5580EB),
        )
      ],
    ).show();
  }
}
