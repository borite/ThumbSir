import 'package:ThumbSir/dao/change_old_and_undeal_dao.dart';
import 'package:ThumbSir/dao/delete_customer_need_dao.dart';
import 'package:ThumbSir/dao/get_needs_detail_dao.dart';
import 'package:ThumbSir/pages/broker/client/client_edit_basic_msg_page.dart';
import 'package:ThumbSir/pages/broker/client/client_edit_family_member_page.dart';
import 'package:ThumbSir/pages/broker/client/client_edit_remark_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_edit_basic_msg_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_edit_family_member_page.dart';
import 'package:ThumbSir/pages/broker/traded/traded_edit_remark_page.dart';
import 'package:ThumbSir/pages/home.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/common/alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class ClientBasicMsg extends StatefulWidget {
  final item;

  ClientBasicMsg({Key key,
    this.item
  }):super(key:key);
  @override
  _ClientBasicMsgState createState()=> _ClientBasicMsgState();
}

class _ClientBasicMsgState extends State<ClientBasicMsg> with SingleTickerProviderStateMixin{
  int star=1;
  List member=new List();
  var deleteNeed;
  bool _loading = false;

  @override
  void initState(){
    star = widget.item.starslevel;
    member = widget.item.familyMember;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressDialog(
        loading: _loading,
        msg:"加载中...",
        child:Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:100,bottom:50),
                child: Column(
                  children: <Widget>[
                    // 姓名
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                              margin: EdgeInsets.only(left: 20,right: 10),
                              child: Image.asset("images/my_3.png"),
                            ),
                            Text(
                              widget.item.userName,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            _changeStateAlertPressed(context);
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
                              "转为老客户",
                              style: TextStyle(
                                  color: Color(0xFF93C0FB),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 基本信息
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "基本信息：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5580EB),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientEditBasicMsgPage(
                                item: widget.item,
                              )));
                            },
                            child: Container(
                              width: 50,
                              height: 20,
                              color: Colors.transparent,
                              child: Image.asset("images/editor.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 星级
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "重要度：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: star == 0 ?
                              Image(image: AssetImage('images/star1_e.png'),
                                fit: BoxFit.fill,) :
                              Image(image: AssetImage('images/star1_big.png'),
                                fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: star == 2 ?
                              Image(image: AssetImage('images/star2_big.png'),
                                fit: BoxFit.fill,)
                                  : star == 3 ?
                              Image(image: AssetImage('images/star2_big.png'),
                                fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star2_e.png'),
                                fit: BoxFit.fill,)
                          ),
                          Container(
                              width: 20,
                              height: 16,
                              padding: EdgeInsets.only(right: 3),
                              child: star == 3 ?
                              Image(image: AssetImage('images/star3_big.png'),
                                fit: BoxFit.fill,)
                                  :
                              Image(image: AssetImage('images/star3_e.png'),
                                fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                    ),
                    // 电话
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "电话：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.item.phone,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 生日
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "生日：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.item.birthday.toString().substring(0,10),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 年龄
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "年龄：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.item.age.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 性别
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "性别：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.item.sex == 0?"男":"女",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 职业
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "职业：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.item.occupation == null || widget.item.occupation == ""?"未知":widget.item.occupation,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 年收入
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "年收入：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.item.income,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 住址
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "住址：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.item.address == "" ? "未知":widget.item.address,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 个人爱好
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "个人爱好：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666666),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.item.hobby == "" ? "未知":widget.item.hobby,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 描述
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "客户描述：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5580EB),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientEditRemarkPage(
                                item: widget.item,
                              )));
                            },
                            child: Container(
                              width: 50,
                              height: 20,
                              color: Colors.transparent,
                              child: Image.asset("images/editor.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 描述详情
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 10),
                      child: Text(
                        widget.item.remark == "" ? "无":widget.item.remark,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // 家庭成员
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "家庭成员：",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF5580EB),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientEditFamilyMemberPage(
                                item: widget.item,
                              )));
                            },
                            child: Container(
                              width: 50,
                              height: 20,
                              color: Colors.transparent,
                              child: Image.asset("images/editor.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    member.length != 0?
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 150,
                      child: ListView.builder(
                        itemCount: member.length,
                        itemBuilder: (BuildContext context,int index){
                          return Column(
                            children: <Widget>[
                              // 家庭成员
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      member[index].memberRole + " — ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        member[index].memberHobby,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                        :
                    Container(
                      child: Text(
                        "无",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      )
      )
    );
  }
  _changeStateAlertPressed(context) {
    Alert(
      context: context,
      title: "转为老客户",
      type: AlertType.warning,
      content: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text("修改状态后该用户的所有需求将被一同删除，是否确定执行此操作？",style: TextStyle(
                fontSize: 18,
                color: Color(0xFF666666)
            ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text("修改状态完成后请到老客户维护模块查看该客户的信息",style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666)
            ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            _onRefresh();
            // 转为老客户并删除需求，完成后跳转至首页
            // 转为老客户，完成后跳转到首页
            var changeState = await ChangeOldAndUndealDao.changeOldAndUndeal(widget.item.mid, "true");
            // 获取需求信息
            var needResult = await GetNeedsDetailDao.httpGetNeedsDetail(widget.item.mid.toString());
            if (needResult.code == 200) {
              var needsList = needResult.data;
              if (needsList.length>0) {
                var need = needsList;
                setState(() async {
                  for (var item in need) {
                    // 循环删除需求
                    deleteNeed = await DeleteCustomerNeedDao.deleteCustomerNeed(item.id.toString());
                  }
                });
              }
            }
            if(changeState.code == 200 && deleteNeed.code == 200){
              _onRefresh();
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new Home( )
                  ), (route) => route == null);
            }else{
              _onRefresh();
              onOverLoadPressed(context);
            }
          },
          color: Color(0xFF5580EB),
        ),
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
        ),
      ],
    ).show();
  }
  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }
}
