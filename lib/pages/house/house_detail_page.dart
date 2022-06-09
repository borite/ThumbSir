import 'dart:convert';
import 'package:ThumbSir/dao/get_house_info_dao.dart';
import 'package:ThumbSir/dao/get_leader_and_team_member_dao.dart';
import 'package:ThumbSir/dao/get_user_detail_by_id_dao.dart';
import 'package:ThumbSir/dao/get_user_info_dao.dart';
import 'package:ThumbSir/dao/update_user_confirm_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/house/change_maintenance_member_page.dart';
import 'package:ThumbSir/pages/house/house_edit_basic_msg_page.dart';
import 'package:ThumbSir/pages/house/house_edit_owner_msg_page.dart';
import 'package:ThumbSir/pages/house/house_upload_only_entrust_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'house_edit_around_msg_page.dart';
import 'house_upload_house_img_page.dart';
import 'house_upload_key_img_page.dart';

// 滚动到100的时候顶部导航栏显示成白色
const APPBAR_SCROLL_OFFSET = 100;

class HouseDetailPage extends StatefulWidget {
  final houseId;
  final tags;
  final houseNum;
  HouseDetailPage({Key key,
    this.houseId,this.tags,this.houseNum
  }):super(key:key);
  @override
  _HouseDetailPageState createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  ScrollController _dealScrollController = ScrollController();
  String roleMinCount = "成交人";
  bool _loading = false;
  List roles=[];
  List _imageUrls=[
        'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];
  var houseDetail;
  List<Widget> tagsTips=[];

  // 录入人
  var inputUserData;
  String inputUserName="暂无";
  String inputUserPhone = "";

  // 维护人
  var maintenanceUserData;
  String maintenanceUserName="暂无";
  String maintenanceUserPhone = "";

  // 实勘人
  var fieldUserData;
  String fieldUserName="暂无";
  String fieldUserPhone = "";

  // 钥匙人
  var keyUserData;
  String keyUserName="暂无";
  String keyUserPhone = "";

  // 成交人
  var dealUserData;
  String dealUserName="暂无";
  String dealUserPhone = "";

  // 独家委托人
  var exclusiveUserData;
  String exclusiveUserName="暂无";
  String exclusiveUserPhone = "";

  // 业主
  var ownerData;
  String ownerName="暂无";
  String ownerPhone = "-";

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
      _load();
    }
  }

  @override
  void initState() {
    _getUserInfo();
    if(widget.tags.length>0){

      for (var item1 in widget.tags) {
        tagsTips.add(
          Container(
            margin: EdgeInsets.only(right: 5,bottom: 5),
            padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
            color: Color(0xFF93C0FB),
            child: Text(
              item1.replaceAll('"', '').replaceAll('[', '').replaceAll(']', ''),
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      };
    }

    super.initState();
  }

  _load() async {
    _onRefresh();
    if(widget.houseId != null ){
      var getHouseDetail = await GetHouseInfoDao.getHouseInfo(
          widget.houseId
      );

      if (getHouseDetail.code == 200) {

        houseDetail = getHouseDetail.data[0];
        _onRefresh();
        // 房源照片
        // if(houseDetail.houseBasicInfo.length>0 && houseDetail.houseBasicInfo[0].housePlan!=null && houseDetail.houseBasicInfo[0].housePlan!=""){
        //   _imageUrls=houseDetail.houseBasicInfo[0].housePlan.split("|");
        //   if(houseDetail.houseBasicInfo[0].houseImages!=null && houseDetail.houseBasicInfo[0].houseImages!=""){
        //     _imageUrls.add(houseDetail.houseBasicInfo[0].houseImages);
        //   }
        //   print(_imageUrls);
        // }
        // 各角色人
        // 成交人
        if(houseDetail.dealUser !=null){
          var dealUserResult = await GetUserInfoDao.getUserInfo(
              houseDetail.dealUser
          );
          if(dealUserResult.code == 200){
            setState(() {
              dealUserData = dealUserResult.data[0];
              dealUserName=dealUserData.userName;
              dealUserPhone = dealUserData.phone;
            });
          }
        }else{
          roles.add("成交人");
        }
        // 录入人
        if(houseDetail.inputUser !=null){
          var inputUserResult = await GetUserInfoDao.getUserInfo(
              houseDetail.inputUser
          );
          if(inputUserResult.code == 200){
            setState(() {
              inputUserData = inputUserResult.data[0];
              inputUserName=inputUserData.userName;
              inputUserPhone = inputUserData.phone;
            });
          }
        }
        // 维护人
        if(houseDetail.maintenanceUser !=null){
          if(houseDetail.maintenanceUser==userData.userPid){
            roles.add("维护人");
          }
          var maintenanceUserResult = await GetUserInfoDao.getUserInfo(
              houseDetail.maintenanceUser
          );
          if(maintenanceUserResult.code == 200){
            setState(() {
              maintenanceUserData = maintenanceUserResult.data[0];
              maintenanceUserName=maintenanceUserData.userName;
              maintenanceUserPhone = maintenanceUserData.phone;
            });
          }
        }
        // 实勘人
        if(houseDetail.fieldUser !=null){
          var fieldUserResult = await GetUserInfoDao.getUserInfo(
              houseDetail.fieldUser
          );
          if(fieldUserResult.code == 200){
            setState(() {
              fieldUserData = fieldUserResult.data[0];
              fieldUserName=fieldUserData.userName;
              fieldUserPhone = fieldUserData.phone;
            });
          }
        }else{
          roles.add("实勘人");
        }
        // 钥匙人
        if(houseDetail.keyUser !=null){
          var keyUserResult = await GetUserInfoDao.getUserInfo(
              houseDetail.keyUser
          );
          if(keyUserResult.code == 200){
            setState(() {
              keyUserData = keyUserResult.data[0];
              keyUserName=keyUserData.userName;
              keyUserPhone = keyUserData.phone;
            });
          }
        }else{
          roles.add("钥匙人");
        }

        // 独家委托人
        if(houseDetail.exclusiveUser !=null){
          var exclusiveUserResult = await GetUserInfoDao.getUserInfo(
              houseDetail.exclusiveUser
          );
          if(exclusiveUserResult.code == 200){
            setState(() {
              exclusiveUserData = exclusiveUserResult.data[0];
              exclusiveUserName=exclusiveUserData.userName;
              exclusiveUserPhone = exclusiveUserData.phone;
            });
          }
        }else{
          roles.add("独家委托人");
        }

        // 获取业主信息
        if(houseDetail.ownerId != null){
          var ownerResult = await GetUserDetailBByIDDao.getUserDetailBByID(
              houseDetail.ownerId.toString()
          );
          if(ownerResult.code == 200){
            setState(() {
              ownerData = ownerResult.data[0];
              ownerName=ownerData.userName;
              ownerPhone = ownerData.phone;
            });
          }
        }

      } else {
        // _onLoadAlert(context);
        _onRefresh();
      }
    }

  }

  @override
  void dispose(){
    _dealScrollController.dispose();
    super.dispose();
  }

  _onScroll(offset){
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha = 0;
    }else if(alpha>1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
  double appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
            child:Stack(
              children: [
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  // 监听列表组件的滚动
                  child: NotificationListener(
                    onNotification: (scrollNotification){
                      if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth==0){
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height:250,
                              child: Swiper(
                                itemCount: _imageUrls.length,
                                autoplay: true,
                                itemBuilder: (BuildContext context,int index){
                                  return Image.network(
                                    _imageUrls[index],
                                    fit: BoxFit.fill,
                                  );
                                },
                                // pagination: SwiperPagination(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 30,left: 10,right: 10),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BackButton(),
                                    IconButton(
                                        icon: Icon(Icons.share),
                                        onPressed: null,
                                        disabledColor: Colors.black,
                                        color:Colors.black,
                                    )
                                  ],
                              )

                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // Container(
                                    //   width: 70,
                                    //   height: 30,
                                    //   margin: EdgeInsets.only(top: 210,left: 10),
                                    //   padding: EdgeInsets.only(top: 4),
                                    //   decoration: BoxDecoration(
                                    //       color: Color(0xFF5580EB),
                                    //       borderRadius: BorderRadius.circular(15)
                                    //   ),
                                    //   child: Text("图片",style: TextStyle(
                                    //     color: Colors.white,
                                    //   ),textAlign: TextAlign.center,),
                                    // ),
                                    // Container(
                                    //   width: 70,
                                    //   height: 30,
                                    //   margin: EdgeInsets.only(top: 210),
                                    //   padding: EdgeInsets.only(top: 4),
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.black45,
                                    //       borderRadius: BorderRadius.circular(15)
                                    //   ),
                                    //   child: Text("视频",style: TextStyle(
                                    //     color: Colors.white,
                                    //   ),textAlign: TextAlign.center,),
                                    // ),
                                    // Container(
                                    //   width: 70,
                                    //   height: 30,
                                    //   margin: EdgeInsets.only(top: 210),
                                    //   padding: EdgeInsets.only(top: 4),
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.black45,
                                    //       borderRadius: BorderRadius.circular(15)
                                    //   ),
                                    //   child: Text("户型",style: TextStyle(
                                    //     color: Colors.white,
                                    //   ),textAlign: TextAlign.center,),
                                    // ),
                                  ],
                                ),

                                Container(
                                  width: 130,
                                  height: 30,
                                  margin: EdgeInsets.only(top: 210,right: 10),
                                  padding: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF93C0FB),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Text("第"+_imageUrls.length.toString()+"张 / 共"+_imageUrls.length.toString()+"张",style: TextStyle(
                                    color: Colors.white,
                                  ),textAlign: TextAlign.center,),
                                ),
                              ],
                            )
                          ],
                        ),
                        // 房源特色
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                          child:Wrap(
                            children: tagsTips,
                          )
                        ),
                        // 地址和紧急标志
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 20,top: 5),
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              houseDetail!=null && houseDetail.tradeLevel=="着急"
                                  || houseDetail!=null && houseDetail.tradeLevel=="诚心"
                                  || houseDetail!=null && houseDetail.tradeLevel=="一般"?
                              Container(
                                width: 26,
                                height: 26,
                                margin: EdgeInsets.only(right: 10),
                                child: Image(image:
                                houseDetail!=null && houseDetail.tradeLevel=="着急"?
                                AssetImage('images/urgent1.png')
                                    :houseDetail!=null && houseDetail.tradeLevel=="诚心"?
                                AssetImage('images/urgent2.png')
                                    :AssetImage('images/urgent3.png'),
                                ),
                              ):Container(width: 1,),
                              Expanded(
                                child: Text(
                                    // '长河湾小区1号楼2单元401室长河湾小区1号楼2单元401室',
                                  houseDetail!=null?(houseDetail.houseCommunity+houseDetail.houseAddress):'未知地址',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),

                        // 房源信息分割线
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 15),
                                  padding: EdgeInsets.only(left: 20),
                                  color: Color(0xFF93C0FB),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '房源信息',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // IconButton(icon: Icon(Icons.edit), onPressed: null,color: Colors.white,)
                                    ],
                                  )

                              ),
                            ),
                            Positioned(
                              right:20,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HouseEditBasicMsgPage(
                                          houseId:widget.houseId,
                                          houseDetail : houseDetail
                                      )));
                                  },
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: null,
                                  color: Colors.white,
                                  disabledColor: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),


                        // 房源信息
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // 第一列
                              Container(
                                width: 140,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '总价：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            (houseDetail!=null?(houseDetail.housePrice.toString().split(".")[0].toString()):'-')+"万",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFF24848),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '单价：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1|| houseDetail.houseBasicInfo.length<1 || houseDetail.houseBasicInfo[0].area==null || houseDetail.houseBasicInfo[0].area==""?"-元/平"
                                                    :(houseDetail.housePrice*10000/houseDetail.houseBasicInfo[0].area).toString().split(".")[0].toString()+"元/平"
                                            ):'-元/平',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '朝向：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1 || houseDetail.houseBasicInfo[0].orientation==null || houseDetail.houseBasicInfo[0].orientation==""?"-"
                                                    :houseDetail.houseBasicInfo[0].orientation.toString()
                                            ):'-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '装修：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1||houseDetail.houseBasicInfo[0].decoration==null ||houseDetail.houseBasicInfo[0].decoration==""?"-"
                                                    :houseDetail.houseBasicInfo[0].decoration.toString()
                                            ):'-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '电梯：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1 || houseDetail.houseBasicInfo[0].haveElevator==null || houseDetail.houseBasicInfo[0].haveElevator==""?"-"
                                                    :houseDetail.houseBasicInfo[0].haveElevator
                                            ):'-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // 第二列
                              Container(
                                width: 185,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '居室：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1|| houseDetail.houseBasicInfo[0].structure==""|| houseDetail.houseBasicInfo[0].structure==null?"-"
                                                    :houseDetail.houseBasicInfo[0].structure
                                            ):'-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFF24848),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '面积：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1|| houseDetail.houseBasicInfo.length<1 || houseDetail.houseBasicInfo[0].area==null || houseDetail.houseBasicInfo[0].area==""?"-平"
                                                    :(houseDetail.houseBasicInfo[0].area.toString()+"平")
                                            ):'-平',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '楼层：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?
                                            houseDetail.houseBasicInfo.length<1 || houseDetail.houseBasicInfo[0].floor==null || houseDetail.houseBasicInfo[0].floor==""
                                                || houseDetail.houseBasicInfo[0].totalFloor==null || houseDetail.houseBasicInfo[0].totalFloor==""?"-层"
                                                :(houseDetail.houseBasicInfo[0].floor.toString()+"/"+houseDetail.houseBasicInfo[0].totalFloor.toString()+"层")
                                            :"-层",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '楼龄：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(
                                                houseDetail.houseBasicInfo.length<1|| houseDetail.houseBasicInfo[0].houseAge==null || houseDetail.houseBasicInfo[0].houseAge==""?"-"
                                                    :houseDetail.houseBasicInfo[0].houseAge.toString()
                                            ):'-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '报盘：',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            houseDetail!=null?(houseDetail.addTime.toString().substring(0,10)):'-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF333333),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 物业信息
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '物业：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  houseDetail!=null?(
                                      houseDetail.houseBasicInfo.length<1|| houseDetail.houseBasicInfo[0].managementCompany==null || houseDetail.houseBasicInfo[0].managementCompany==""
                                          || houseDetail.houseBasicInfo[0].managementPrice==""|| houseDetail.houseBasicInfo[0].managementPrice==null?"-"
                                          :(houseDetail.houseBasicInfo[0].managementCompany.toString().split(",")[0].toString()+"-"+houseDetail.houseBasicInfo[0].managementPrice.toString()+"元/平米/天")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 房源编号
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '房源编号：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(text: widget.houseNum));
                                  _onPasteAlertPressed(context);
                                },
                                 child: Container(
                                   child: Text(
                                     widget.houseNum.toString()+'（点击复制）',
                                     style: TextStyle(
                                       fontSize: 14,
                                       color: Color(0xFFF24848),
                                       decoration: TextDecoration.none,
                                       fontWeight: FontWeight.normal,
                                     ),
                                   ),
                                 ),
                              ),
                            ],
                          ),
                        ),
                        // 定位信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '定位信息：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '点击打开百度地图',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 配套信息分割线
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 15),
                                  padding: EdgeInsets.only(left: 20),
                                  color: Color(0xFF93C0FB),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '配套与优势',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // IconButton(icon: Icon(Icons.edit), onPressed: null,color: Colors.white,)
                                    ],
                                  )

                              ),
                            ),

                            Positioned(
                              right:20,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HouseEditAroundMsgPage(
                                          houseId:widget.houseId,
                                          houseDetail : houseDetail
                                      )));
                                },
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: null,
                                  color: Colors.white,
                                  disabledColor: Colors.white,
                                ),
                              ),
                            )

                          ],
                        ),

                        // 学校信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '学校：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '学区房，北京交通大学附属小学（200m）、北京交通大学附属中学（300m）、北京交通大学（150m）',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :((houseDetail.houseAroundInfo[0].isInSchoolArea==true?"学区房":"非学区房")+"，"+ returnItem(houseDetail.houseAroundInfo[0].school).substring(0,returnItem(houseDetail.houseAroundInfo[0].school).lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", ""))
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 交通信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '交通：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '地铁2、4、13号线西直门站（100m），公交5、18、32、56路交通大学南口（50m）',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :returnItem(houseDetail.houseAroundInfo[0].traffic).substring(0,returnItem(houseDetail.houseAroundInfo[0].traffic).lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", "")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 商场信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '商场：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '凯德Mall（200m）',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :returnItem(houseDetail.houseAroundInfo[0].entertainment).substring(0,returnItem(houseDetail.houseAroundInfo[0].entertainment).lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", "")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 医院信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '医院：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '北京协和医院（800m）、北大人民医院（1200m）',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :returnItem(houseDetail.houseAroundInfo[0].hospital).substring(0,returnItem(houseDetail.houseAroundInfo[0].hospital).lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", "")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 银行信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '银行：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '交通银行（100m）、中国银行（50m）、农业银行（100m）',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :returnItem(houseDetail.houseAroundInfo[0].bank).substring(0,returnItem(houseDetail.houseAroundInfo[0].bank).lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", "")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 公园信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '公园：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '人民公园(200m)',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :returnItem(houseDetail.houseAroundInfo[0].park).substring(0,returnItem(houseDetail.houseAroundInfo[0].park).lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", "")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 其他优势信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '其他优势：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '绿化率高、容积率低、人车分流、安静、视野好、底层板楼',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :houseDetail.houseAroundInfo[0].otherLabel.substring(0,houseDetail.houseAroundInfo[0].otherLabel.lastIndexOf(',')).split(',').toString()
                                          .replaceAll("[", "").replaceAll("]", "")
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 综合描述
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '综合描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '长河湾小区是一个巴拉巴拉巴拉巴拉，希望大家多多给客户推荐，成交有礼',
                                  houseDetail!=null?(
                                      houseDetail.houseAroundInfo.length<1?"-"
                                          :houseDetail.houseAroundInfo[0].otherIntro
                                  ):'-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 角色人信息分割线
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 15),
                                  padding: EdgeInsets.only(left: 20),
                                  color: Color(0xFF93C0FB),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '角色人信息',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // IconButton(icon: Icon(Icons.edit), onPressed: null,color: Colors.white,)
                                    ],
                                  )

                              ),
                            ),
                            Positioned(
                                 right:20,
                                 child: GestureDetector(
                                   onTap: (){
                                     _onChooseRolePressed(context);
                                   },
                                     child: IconButton(
                                       icon: Icon(Icons.edit),
                                       onPressed: null,
                                       color: Colors.white,
                                       disabledColor: Colors.white,
                                     ),
                               ),
                            ),
                          ],
                        ),

                        // 录入人信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '录入人：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  inputUserName+"  "+inputUserPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 录入时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '挂牌时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null?houseDetail.addTime.toString().substring(0,10):"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 维护人信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '维护人：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  maintenanceUserName+'  '+maintenanceUserPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 委托时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '委托时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '2020-12-26至2021-12-26',
                                  houseDetail!=null && houseDetail.housePrivateInformation.length>0
                                      && houseDetail.housePrivateInformation[0].consignmentAgreementStart!=null
                                    && houseDetail.housePrivateInformation[0].consignmentAgreementStart!=""
                                      && houseDetail.housePrivateInformation[0].consignmentAgreementExpr!=null
                                      && houseDetail.housePrivateInformation[0].consignmentAgreementExpr!=""?
                                  (houseDetail.housePrivateInformation[0].consignmentAgreementStart.toString().substring(0,10)+"-"
                                      +houseDetail.housePrivateInformation[0].consignmentAgreementExpr.toString().substring(0,10)):"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 实勘人信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '实勘人：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  fieldUserName+"  "+fieldUserPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              houseDetail!=null &&houseDetail.confirmFieldUser==false?
                              GestureDetector(
                                onTap: ()async{
                                  var leaderAndMemberResult = await GetLeaderAndTeamMemberDao.getLeaderAndTeamMember(
                                      houseDetail.fieldUser
                                  );
                                  if(leaderAndMemberResult.code==200){
                                    if(leaderAndMemberResult.data.leader.userPid == userData.userPid){
                                      // 是上级弹出
                                      _onConfirmRolePressed(context,fieldUserName,2,"实勘人");
                                    }else{
                                      _onConfirmRoleAlertPressed(context,dealUserName);
                                    }
                                  }else{
                                    // 不是上级弹出
                                    _onConfirmRoleAlertPressed(context,dealUserName);
                                  }
                                },
                                child: IconButton(
                                  icon: Icon(Icons.error),
                                  onPressed: null,
                                  color: Colors.redAccent,
                                  disabledColor: Colors.redAccent,
                                ),
                              ):Container(width: 1,),
                            ],
                          ),
                        ),
                        // 实勘时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '实勘时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null && houseDetail.houseBasicInfo.length>0
                                      && houseDetail.houseBasicInfo[0].uploadTime!=null
                                      && houseDetail.houseBasicInfo[0].uploadTime!=""?
                                  houseDetail.houseBasicInfo[0].uploadTime.toString().substring(0,10):"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 钥匙人信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '收钥匙人：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  keyUserName+"  "+keyUserPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              houseDetail!=null &&houseDetail.confirmKeyUser==false?
                              GestureDetector(
                                onTap: ()async{
                                  if(houseDetail.fieldUser!=null){
                                    var leaderAndMemberResult = await GetLeaderAndTeamMemberDao.getLeaderAndTeamMember(
                                        houseDetail.fieldUser
                                    );
                                    if(leaderAndMemberResult.code==200){
                                      if(leaderAndMemberResult.data.leader.userPid == userData.userPid){
                                        // 是上级弹出
                                        _onConfirmRolePressed(context,keyUserName,3,"钥匙人");
                                      }else{
                                        _onConfirmRoleAlertPressed(context,dealUserName);
                                      }
                                    }else{
                                      // 不是上级弹出
                                      _onConfirmRoleAlertPressed(context,dealUserName);
                                    }
                                  }else{
                                    // 不是上级弹出
                                    _onConfirmRoleAlertPressed(context,dealUserName);
                                  }

                                },
                                child: IconButton(
                                  icon: Icon(Icons.error),
                                  onPressed: null,
                                  color: Colors.redAccent,
                                  disabledColor: Colors.redAccent,
                                ),
                              ):Container(width: 1,),
                            ],
                          ),
                        ),
                        // 收钥匙时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '收钥匙时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null && houseDetail.houseImages.length>0
                                      && houseDetail.houseImages[0].keyStartDate!=null
                                      && houseDetail.houseImages[0].keyStartDate!=""
                                      && houseDetail.houseImages[0].keyEndDate!=null
                                      && houseDetail.houseImages[0].keyEndDate!=""?
                                  (houseDetail.houseImages[0].keyStartDate.toString().substring(0,10)+"-"
                                      +houseDetail.houseImages[0].keyEndDate.toString().substring(0,10)):"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 独家委托人信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '独家委托人：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  exclusiveUserName+"  "+exclusiveUserPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              houseDetail!=null &&houseDetail.confirmExclusiveUser==false?
                              GestureDetector(
                                onTap: (){
                                  // 是上级弹出
                                  _onConfirmRolePressed(context,exclusiveUserName,1,"独家委托人");
                                  // 不是上级弹出
                                  // _onConfirmRoleAlertPressed(context,dealUserName);
                                },
                                child: IconButton(
                                  icon: Icon(Icons.error),
                                  onPressed: null,
                                  color: Colors.redAccent,
                                  disabledColor: Colors.redAccent,
                                ),
                              ):Container(width: 1,),
                            ],
                          ),
                        ),
                        // 独家委托时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '签独家委托协议时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null && houseDetail.housePrivateInformation.length>0
                                      && houseDetail.housePrivateInformation[0].exclusiveConsignmentAgreementStart!=null
                                      && houseDetail.housePrivateInformation[0].exclusiveConsignmentAgreementStart!=""
                                      && houseDetail.housePrivateInformation[0].exclusiveConsignmentAgreementExpr!=null
                                      && houseDetail.housePrivateInformation[0].exclusiveConsignmentAgreementExpr!=""?
                                  (houseDetail.housePrivateInformation[0].exclusiveConsignmentAgreementStart.toString().substring(0,10)+"-"
                                      +houseDetail.housePrivateInformation[0].exclusiveConsignmentAgreementExpr.toString().substring(0,10)):"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 成交人信息
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '成交人：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  dealUserName+"  "+dealUserPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              houseDetail!=null &&houseDetail.confirmDealUser==false?
                              GestureDetector(
                                onTap: (){
                                  // 是上级弹出
                                  _onConfirmRolePressed(context,dealUserName,4,"成交人");
                                  // 不是上级弹出
                                  // _onConfirmRoleAlertPressed(context,dealUserName);
                                },
                                child: IconButton(
                                  icon: Icon(Icons.error),
                                  onPressed: null,
                                  color: Colors.redAccent,
                                  disabledColor: Colors.redAccent,
                                ),
                              ):Container(width: 1,),
                            ],
                          ),
                        ),
                        // 成交时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '成交时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null && houseDetail.houseImages.length>0
                                      && houseDetail.houseImages[0].dealDate!=null
                                      && houseDetail.houseImages[0].dealDate!=""?
                                  houseDetail.houseImages[0].dealDate.toString().substring(0,10)+"-":"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 维护信息分割线
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 15),
                                  padding: EdgeInsets.only(left: 20),
                                  color: Color(0xFF93C0FB),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '维护信息',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // IconButton(icon: Icon(Icons.edit), onPressed: null,color: Colors.white,)
                                    ],
                                  )

                              ),
                            ),

                            Positioned(
                              right:20,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: null,
                                color: Colors.white,
                                disabledColor: Colors.white,
                              ),
                            )

                          ],
                        ),
                        // 维护记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '维护记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // '业主2月25日~3月15日在北京，有意向的客户联系我安排谈单',
                                  houseDetail!=null && houseDetail.houseIntro!=null?houseDetail.houseIntro:"暂无",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF24848),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 维护时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '维护时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '2021-02-15',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 调价记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '调价记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '张三于2021-04-03 13:30将价格调整为560万元',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF5580EB),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 调价原因
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '调价原因：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '业主诚心出售，再降20万元',
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
                        // 带看记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '带看记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '张三(13122334455)于2020-01-30 15:00~16:00带客户看过此房源',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF5580EB),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 带看感受
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '带看感受：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '客户觉得光线不好',
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
                        // 面访记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '面访记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '二麻子(18622334455)与2020-01-30 16:30~18:00面访业主',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF5580EB),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 面访收获
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '面访收获：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '业主诚心出售，希望大家踊跃带看',
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
                        // 空看记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '空看记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '二麻子(18622334455)于2020-01-30 14:00~15:00空看了此房源',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF5580EB),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 空看收获
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '空看收获：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '房子采光很好，装修维持的很好',
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
                        // 调紧急度记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '调整急迫度记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '二麻子(18622334455)于2020-07-30 21:45将急迫度从一般调整为着急',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 下架记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '下架记录：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '二麻子(18622334455)于2020-07-30 21:45将该房源下架',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 下架原因
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '下架原因：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '暂不交易——业主卖了另一套房子，这套暂时不卖了',
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

                        // 业主信息分割线
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 15),
                                  padding: EdgeInsets.only(left: 20),
                                  color: Color(0xFF93C0FB),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '隐私信息',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      // IconButton(icon: Icon(Icons.edit), onPressed: null,color: Colors.white,)
                                    ],
                                  )

                              ),
                            ),

                            Positioned(
                              right:20,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HouseEditOwnerMsgPage(
                                          houseId:widget.houseId,
                                          houseDetail : houseDetail
                                      )));
                                },
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: null,
                                  color: Colors.white,
                                  disabledColor: Colors.white,
                                ),
                              ),
                            )

                          ],
                        ),

                        // 业主姓名
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '业主姓名：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ownerName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 业主电话
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '业主电话：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ownerPhone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 代理人姓名
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '代理人姓名：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null?houseDetail.agentName:"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 代理人电话
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '代理人电话：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    houseDetail!=null?houseDetail.agentPhone:"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 出售原因
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '出售原因：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null?houseDetail.tradeReason:"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 期望成交时间
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '期望成交时间：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  houseDetail!=null?houseDetail.expectedTransTime.toString().substring(0,10):"-",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 业主身份证照片
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '业主身份证照片：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '已上传，您没有权限查看/点击查看',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 房本照片
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '房本照片：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '已上传，您没有权限查看/点击查看',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 委托协议
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '委托协议：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '已上传，您没有权限查看/点击查看',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 独家委托协议
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '独家委托协议：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '已上传，您没有权限查看/点击查看',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 钥匙照片
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '钥匙照片：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '点击查看',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 钥匙委托协议
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '钥匙委托协议：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '已上传，您没有权限查看/点击查看',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 成交合同
                        Container(
                          margin: EdgeInsets.only(bottom: 35,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '成交合同：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '暂无成交记录',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 导航栏
                Opacity(
                  opacity: appBarAlpha,
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: BackButton(
                            color: Color(0xFF333333),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('房源详情页',style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: IconButton(
                              icon: Icon(Icons.share),
                              onPressed: null,
                              disabledColor: Color(0xFF5580EB),
                              color:Color(0xFF5580EB)
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )


        )
        );}
    // 加载中loading
    Future<Null> _onRefresh() async {
      setState(() {
        _loading = !_loading;
      });
    }


// 选择角色人
  _onChooseRolePressed(context) {
    Alert(
      context: context,
      title: "选择您要修改或成为的角色类型",
      content: Container(
        width: 200,
        height: 120,
        margin: EdgeInsets.only(top: 18),
        child: WheelChooser(
          onValueChanged: (s){
            setState(() {
              roleMinCount = s;
            });
          },
          datas: roles,
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
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            if(roleMinCount=="成交人"){

            }
            if(roleMinCount=="维护人"){
              // 查找要成为维护人的同事信息并选择
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeMaintenanceMemberPage(
                houseId: widget.houseId,
              )));
            }
            if(roleMinCount=="实勘人"){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseUploadHouseImgPage(
                houseId: widget.houseId,
              )));
            }
            if(roleMinCount=="钥匙人"){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseUploadKeyImgPage(
                houseId: widget.houseId,
              )));
            }
            if(roleMinCount=="独家委托人"){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseUploadOnlyEntrustPage(
                houseId: widget.houseId,
              )));
            }

          },
          color: Color(0xFF5580EB),
          width: 120,
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
          width: 120,
        )
      ],
    ).show();
  }

  // 确认角色人
  _onConfirmRolePressed(context,roleName,num,role) {
    Alert(
      context: context,
      title: "确认角色人",
      desc: "是否确认"+roleName+"为此房源的"+role+"？",
      buttons: [
        DialogButton(
          child: Text(
            "是",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            var confirmResult = await UpdateUserConfirmDao.updateUserConfirm(
              num,
              widget.houseId.toString(),
              true
            );
            if (confirmResult.code == 200) {
              Navigator.pop(context);
            }
          },
          color: Color(0xFF5580EB),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "不是",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()async{
            var confirmResult = await UpdateUserConfirmDao.updateUserConfirm(
                num,
                widget.houseId.toString(),
                false
            );
            if (confirmResult.code == 200) {
              Navigator.pop(context);
            }
          },
          color: Color(0xFFF24848),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "再想想",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
          width: 120,
        )
      ],
    ).show();
  }
  // 待确认角色人
  _onConfirmRoleAlertPressed(context,roleName) {
    Alert(
      context: context,
      title: "该角色人待确认",
      desc: "仅"+roleName+"的直属上级可进行确认或否认的操作",
      buttons: [
        DialogButton(
          child: Text(
            "知道了",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Color(0xFFCCCCCC),
          width: 120,
        )
      ],
    ).show();
  }

    // 复制房源编号成功的弹窗
    _onPasteAlertPressed(context) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "房源编号复制成功",
        buttons: [
          DialogButton(
            child: Text(
              "确定",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color(0xFF5580EB),
          ),
        ],
      ).show();
    }

    String returnItem(String jsonStr){
        String r="";
        if(jsonStr==""){
          return r;
        }
        List list=json.decode(jsonStr);
        list.forEach((element) {
          r+=element['name']+'-'+element['distance']+'米,';
        });
        return r;
    }
  }




