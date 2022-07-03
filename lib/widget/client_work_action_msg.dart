import 'package:ThumbSir/common/alert.dart';
import 'package:ThumbSir/dao/get_combin_customer_info_dao.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';
import 'package:ThumbSir/pages/major/qlist/major_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/s_qlist_page.dart';
import 'package:flutter/material.dart';

class ClientWorkActionMsg extends StatefulWidget {
  final item;
  final result;

  ClientWorkActionMsg({Key? key,
    this.item,this.result
  }):super(key:key);
  @override
  _ClientWorkActionMsgState createState()=> _ClientWorkActionMsgState();
}

class _ClientWorkActionMsgState extends State<ClientWorkActionMsg> with SingleTickerProviderStateMixin{
  ScrollController _kehuScrollController = ScrollController();
  ScrollController _yezhuScrollController = ScrollController();
  var pageIndex=0;
  var msgList;
  List<Widget> kehuShowList = [];
  List<Widget> kehuMsgs=[];
  List<Widget> yezhuShowList = [];
  List<Widget> yezhuMsgs=[];
  late List yezhuAction=[];
  late List kehuAction=[];
  bool _loading = false;

  bool kehuEx = true;
  bool yezhuEx = true;

  _loadActive()async{
    // 获取客户和业主的任务列表 widget.item.mid
    dynamic activeList = await GetCombinCustomerInfoDao.httpGetCombinCustomerInfo(widget.item.mid.toString());
    if(activeList.code==200){
      if(activeList.data.yezhuList.length>0){
        for(dynamic item in activeList.data.yezhuList){
          yezhuAction.add(item);
        }
      }
      if(activeList.data.kehuResult.length>0){
        for(dynamic item in activeList.data.kehuResult){
          kehuAction.add(item);
        }
      }
      if(kehuAction.length>0){
        setState(() {
          if (kehuAction.length>0) {
            for (var item in kehuAction) {
              kehuMsgs.add(
                  Container(
                    width: 335,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 335,
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              color: Colors.transparent
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 335,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [BoxShadow(
                                        color: Color(0xFFcccccc),
                                        offset: Offset(0.0, 3.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0
                                    )
                                    ],
                                    color: Colors.white
                                ),
                                child: Column(
                                  children: <Widget>[
                                    // 项目和数量
                                    Container(
                                      width: 335,
                                      padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(right: 6),
                                                  child: Container(
                                                    width:20,
                                                    child: Icon(Icons.access_alarm,color: Color(0xFF0E7AE6),)
                                                    // Image(image: AssetImage('images/time.png'),),
                                                  ),
                                                ),
                                                Text(
                                                  item.selectedMissionName??"未知任务",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF0E7AE6),
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // GestureDetector(
                                          //   child: Container(
                                          //     width: 24,
                                          //     child: Image(
                                          //         image: AssetImage('images/editor.png')),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // 时间
                                    Container(
                                        width: 335,
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                '时间：',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF666666),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // item.actionTime.toString().substring(0,16)??"-",
                                              item.mlist[0].planningStartTime.toString().substring(0,16)+"~"+item.mlist[0].planningEndTime.toString().substring(11,16),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF666666),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    // 任务描述
                                    Container(
                                      margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "任务描述：",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.mlist[0].remark??"无",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF999999),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // 关联房源
                                    Container(
                                      margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '关联房源：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 22,
                                                  padding: EdgeInsets.only(right: 5,top: 2),
                                                  child: Image(image: AssetImage(
                                                      'images/site_small.png'),),
                                                ),
                                                Container(
                                                  child: Expanded(
                                                    child: Text(
                                                      item.mlist[0].houseCommunity+item.mlist[0].houseAddress??"未关联",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF0E7AE6),
                                                        decoration: TextDecoration.none,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                  )

              );
            }
          } else {
            onLoadAlert(context);
            _onRefresh();
          }
        });
      }
      if(yezhuAction.length>0){
        setState(() {
          if (yezhuAction.length>0) {
            for (var item in yezhuAction) {
              yezhuMsgs.add(
                  Container(
                    width: 335,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 335,
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              color: Colors.transparent
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 335,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [BoxShadow(
                                        color: Color(0xFFcccccc),
                                        offset: Offset(0.0, 3.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0
                                    )
                                    ],
                                    color: Colors.white
                                ),
                                child: Column(
                                  children: <Widget>[
                                    // 项目和数量
                                    Container(
                                      width: 335,
                                      padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(right: 6),
                                                  child: Container(
                                                      width:20,
                                                      child: Icon(Icons.access_alarm,color: Color(0xFF24CC8E),)
                                                    // Image(image: AssetImage('images/time.png'),),
                                                  ),
                                                ),
                                                Text(
                                                  item.missionName??"未知任务",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF24CC8E),
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // GestureDetector(
                                          //   child: Container(
                                          //     width: 24,
                                          //     child: Image(
                                          //         image: AssetImage('images/editor.png')),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // 时间
                                    Container(
                                        width: 335,
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                '时间：',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF666666),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // item.actionTime.toString().substring(0,16)??"-",
                                              item.mlist[0].planningStartTime.toString().substring(0,16)+"~"+item.mlist[0].planningEndTime.toString().substring(11,16),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF666666),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    // 任务描述
                                    Container(
                                      margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "任务描述：",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.missionDescription??"暂无描述",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF999999),
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // 关联房源
                                    Container(
                                      margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '房源：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 22,
                                                  padding: EdgeInsets.only(right: 5,top: 2),
                                                  child: Image(image: AssetImage(
                                                      'images/site_small.png'),),
                                                ),
                                                Container(
                                                  child: Expanded(
                                                    child: Text(
                                                      item.houseCommunity+item.houseAddress??"未关联",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF24CC8E),
                                                        decoration: TextDecoration.none,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                  )

              );
            }
          } else {
            onLoadAlert(context);
            _onRefresh();
          }
        });
      }
    }
  }

  @override
  void initState(){
    super.initState();
    _loadActive();
    // _load();
    // _scrollController.addListener(() {
    //   // 如果滚动位置到了可滚动的最大距离，就加载更多
    //   if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
    //     // _load();
    //   }
    // });

  }

  @override
  void dispose(){
    // _kehuScrollController.dispose();
    // _yezhuScrollController.dispose();
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
                        // 跳转按钮
                        GestureDetector(
                          onTap: (){
                            if(widget.result.userLevel.substring(0,1)=="6"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                            }
                            if(widget.result.userLevel.substring(0,1)=="5"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                            }
                            if(widget.result.userLevel.substring(0,1)=="4"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                            }
                            if(widget.result.userLevel.substring(0,1)=="1"||widget.result.userLevel.substring(0,1)=="2"||widget.result.userLevel.substring(0,1)=="3"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                            }
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
                              "前往业务量化模块",
                              style: TextStyle(
                                  color: Color(0xFF93C0FB),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 客户维护记录列表
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              kehuEx=!kehuEx;
                            });
                          },
                          child: Container(
                              width:335,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("作为客户的业务动作：",
                                    style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  kehuEx == false?
                                  Icon(Icons.arrow_drop_up,color: Color(0xFF93C0FB),size: 26,)
                                  :Icon(Icons.arrow_drop_down,color: Color(0xFF93C0FB),size: 26,),
                                ],
                              )
                          ),
                        ),
                        kehuMsgs.length>0 && kehuEx==true?
                        ListView.builder(
                          controller: _kehuScrollController,
                          padding: EdgeInsets.only(bottom: 30),
                          shrinkWrap: true,
                          itemCount: kehuMsgs.length,
                          itemBuilder: (BuildContext context,int index){
                            return kehuMsgs[index];
                          },
                        )
                            :kehuEx==false?Container(width: 0,)
                            :
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text("暂无此类业务动作",
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 业主维护记录列表
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              yezhuEx=!yezhuEx;
                            });
                          },
                          child: Container(
                              width:335,
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("作为业主的业务动作：",
                                    style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 16,
                                    ),
                                  ),
                                  yezhuEx == false?
                                  Icon(Icons.arrow_drop_up,color: Color(0xFF93C0FB),size: 26,)
                                      :Icon(Icons.arrow_drop_down,color: Color(0xFF93C0FB),size: 26,),
                                ],
                              )
                          ),
                        ),
                        yezhuMsgs.length>0 && yezhuEx==true?
                        ListView.builder(
                          controller: _yezhuScrollController,
                          padding: EdgeInsets.only(bottom: 30),
                          shrinkWrap: true,
                          itemCount: yezhuMsgs.length,
                          itemBuilder: (BuildContext context,int index){
                            return yezhuMsgs[index];
                          },
                        )
                            :yezhuEx==false?Container(width: 0,)
                            :
                            Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: Text("暂无此类业务动作",
                                style: TextStyle(
                                  color: Color(0xFFCCCCCC),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                      ],
                    ),
                ]),
              )
            ],
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
}
