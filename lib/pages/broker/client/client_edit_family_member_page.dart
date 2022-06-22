import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_family_member_info_dao.dart';
import 'package:ThumbSir/dao/delete_family_member_info_dao.dart';
import 'package:ThumbSir/dao/get_user_detail_by_id_dao.dart';
import 'package:ThumbSir/model/get_customer_list_model.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/client_detail_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClientEditFamilyMemberPage extends StatefulWidget {
  final item;

  ClientEditFamilyMemberPage({Key? key,
    this.item
  }):super(key:key);
  @override
  _ClientEditFamilyMemberPageState createState() => _ClientEditFamilyMemberPageState();
}

class _ClientEditFamilyMemberPageState extends State<ClientEditFamilyMemberPage> {
  bool _loading = false;
  ScrollController _scrollController = ScrollController();

  final TextEditingController memberController=TextEditingController();
  late RegExp memberReg;
  bool memberBool = false;

  String memberMinCount = "妻子";

  List member=[];

  LoginResultData? userData;
  late String uInfo;

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uInfo= prefs.getString("userInfo")!;
    setState(() {
      userData=LoginResultData.fromJson(json.decode(uInfo));
    });
  }

  @override
  void initState() {
    memberReg = TextReg;
    member = widget.item.familyMember;
    _getUserInfo();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    memberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
            child:Container(
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
                              padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // 首页和标题
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: ()async{
                                          var getItem = await GetUserDetailBByIDDao.getUserDetailBByID(widget.item.mid.toString());
                                          if(getItem.code == 200){
                                            _onRefresh();
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                                              item:getItem.data![0],
                                              tabIndex: 0,
                                            )));
                                          }else {
                                            _onRefresh();
                                            _onOverLoadPressed(context);
                                          }
                                        },
                                        child: Container(
                                          width: 28,
                                          padding: EdgeInsets.only(top: 3),
                                          child: Image(image: AssetImage('images/back.png'),),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('修改'+widget.item.userName+"的家庭成员信息",style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),),
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ),
                          // 家庭成员
                          Container(
                            width: 335,
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              '客户的家庭成员（非必填）：',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemCount: member.length,
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                                              decoration: BoxDecoration(
                                                border: Border(right: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFCCCCCC),
                                                ))
                                              ),
                                              child: Text(
                                                member[index].memberRole,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF5580EB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              width: 210,
                                              padding: EdgeInsets.fromLTRB(20, 0, 10, 3),
                                              child: Text(
                                                member[index].memberHobby,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF5580EB),
                                                  decoration: TextDecoration.none,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                _deleteMemberAlertPressed(context,member[index].id);
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 20,
                                                child: Image(image: AssetImage("images/delete_blue.png"),),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                  ],
                                );
                              },

                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _addMemberAlertPressed(context);
                              setState(() {
                                memberController.text = "";
                              });
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 20),
                              width: 335,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Color(0xFF93C0FB)
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "+ 添加家庭成员",
                                  style: TextStyle(
                                      color: Color(0xFF93C0FB),
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    )
                  ],
                )
            )
        )
    );
  }
  _addMemberAlertPressed(context) {
    Alert(
      context: context,
      title: "添加家庭成员",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("选择成员：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            width: 80,
            height: 120,
            margin: EdgeInsets.only(top: 18),
            child: WheelChooser(
              onValueChanged: (s){
                setState(() {
                  memberMinCount = s;
                });
              },
              datas: ["妻子", "丈夫","儿子", "女儿", "父亲", "母亲","哥哥", "姐姐","弟弟", "妹妹", "宠物","其他"],
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
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("家庭成员的描述：",style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666)
                ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 30),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Color(0xFF5580EB)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextField(
              controller: memberController,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              onChanged: _onMemberChanged,
              maxLines: null,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                hintText:'爱好、习惯等……',
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),
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
            print('bbb');
            setState(() {
              var m=new FamilyMember(memberRole: memberMinCount,memberHobby: memberController.text);
              member.add(m);
            });
            var addResult = await AddFamilyMemberInfoDao.addFamilyMemberInfo(widget.item.mid.toString(), memberMinCount, memberController.text);
            if(addResult.code == 200){
              Navigator.pop(context);
            }else{
              _onOverLoadPressed(context);
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
  _deleteMemberAlertPressed(context,id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "是否确定删除当前家庭成员？",
      desc: "删除后信息无法找回，请谨慎操作",
      buttons: [
        DialogButton(
          child: Text(
            "确定删除",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            var deleteResult = await DeleteFamilyMemberInfoDao.deleteFamilyMemberInfo(id.toString());
            if(deleteResult.code == 200){
              var getItem = await GetUserDetailBByIDDao.getUserDetailBByID(widget.item.mid.toString());
              if(getItem.code == 200){
                _onRefresh();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                  item:getItem.data![0],
                  tabIndex: 0,
                )));
              }else {
                _onRefresh();
                _onOverLoadPressed(context);
              }
            }else{
              _onOverLoadPressed(context);
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
  _onOverLoadPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "请检查网络后重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
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
  _onMemberChanged(dynamic text){
    if(text != null){
      setState(() {
        memberBool = memberReg.hasMatch(memberController.text);
      });
    }
  }
}


