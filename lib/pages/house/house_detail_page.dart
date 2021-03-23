import 'dart:convert';
import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_customer_dao.dart';
import 'package:ThumbSir/dao/get_default_task_dao.dart';
import 'package:ThumbSir/model/login_result_data_model.dart';
import 'package:ThumbSir/pages/broker/client/sell_need_page.dart';
import 'package:ThumbSir/pages/manager/traded/m_traded_page.dart';
import 'package:ThumbSir/pages/manager/traded/s_traded_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:ThumbSir/model/set_kpimission_item_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ThumbSir/model/get_default_task_model.dart';

import '../broker/client/my_client_page.dart';

// 滚动到100的时候顶部导航栏显示成白色
const APPBAR_SCROLL_OFFSET = 100;

class HouseDetailPage extends StatefulWidget {
  @override
  _HouseDetailPageState createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  ScrollController _dealScrollController = ScrollController();
  bool _loading = false;
  List _imageUrls=[
        'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  @override
  void initState() {
    super.initState();
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
                                    Container(
                                      width: 70,
                                      height: 30,
                                      margin: EdgeInsets.only(top: 210,left: 10),
                                      padding: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF5580EB),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Text("图片",style: TextStyle(
                                        color: Colors.white,
                                      ),textAlign: TextAlign.center,),
                                    ),
                                    Container(
                                      width: 70,
                                      height: 30,
                                      margin: EdgeInsets.only(top: 210),
                                      padding: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Text("视频",style: TextStyle(
                                        color: Colors.white,
                                      ),textAlign: TextAlign.center,),
                                    ),
                                    Container(
                                      width: 70,
                                      height: 30,
                                      margin: EdgeInsets.only(top: 210),
                                      padding: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Text("户型",style: TextStyle(
                                        color: Colors.white,
                                      ),textAlign: TextAlign.center,),
                                    ),
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
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "满五唯一",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "近地铁",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "随时看房",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "学区房",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "学区房",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "学区房",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "学区房",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5,bottom: 5),
                                padding: EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
                                color: Color(0xFF93C0FB),
                                child: Text(
                                  "学区房",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        // 地址和紧急标志
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 20,top: 5),
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsets.only(right: 10),
                                child: Image(image: AssetImage('images/urgent1.png'),),
                              ),
                              Expanded(
                                child: Text(
                                    '长河湾小区1号楼2单元401室长河湾小区1号楼2单元401室',
                                    style: TextStyle(
                                      fontSize: 20,
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
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: null,
                                color: Colors.white,
                                disabledColor: Colors.white,
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
                                            '650万',
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
                                            '73218元/平米',
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
                                            '东.南.西.北',
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
                                            '精装修',
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
                                            '有',
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
                                            '物业公司：',
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
                                            '嘉禾物业',
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
                                            '2-1-1-1',
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
                                            '83.41平米',
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
                                            '5/6层',
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
                                            '1990年',
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
                                            '2020-12-26',
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
                                            '物业费：',
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
                                            '2.16元/平米/天',
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
                              Container(
                                child: Text(
                                  '37513425567（长按复制）',
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
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: null,
                                color: Colors.white,
                                disabledColor: Colors.white,
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
                                  '学区房，北京交通大学附属小学（200m）、北京交通大学附属中学（300m）、北京交通大学（150m）',
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
                                  '地铁2、4、13号线西直门站（100m），公交5、18、32、56路交通大学南口（50m）',
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
                                  '凯德Mall（200m）',
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
                                  '北京协和医院（800m）、北大人民医院（1200m）',
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
                                  '交通银行（100m）、中国银行（50m）、农业银行（100m）',
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
                                  '人民公园(200m)',
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
                                  '绿化率高、容积率低、人车分流、安静、视野好、底层板楼',
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
                                  '长河湾小区是一个巴拉巴拉巴拉巴拉，希望大家多多给客户推荐，成交有礼',
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
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: null,
                                color: Colors.white,
                                disabledColor: Colors.white,
                              ),
                            )

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
                                  '李四 13111223344',
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
                                  '签委托时间：',
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
                                  '2020-12-26',
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
                                  '张三 13311223344',
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
                                  '2020-12-26至2021-12-26',
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
                                  '张三 13311223344',
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
                                  '2020-12-26',
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
                                  '王五 13311223344',
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
                                  '2020-12-26',
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
                                  '暂未成交',
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
                                  '-',
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
                                  '业主2月25日~3月15日在北京，有意向的客户联系我安排谈单',
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
                        // 成交记录
                        Container(
                          margin: EdgeInsets.only(bottom: 5,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '成交记录：',
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
                                  '二麻子(18622334455)于2020-07-30 21:45上传了成交合同',
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
                                        '业主信息',
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
                                  '迪丽热巴',
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
                                  '15033445678',
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
                                  '古力娜扎',
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
                                  '15033445678',
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
                                  '变现',
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
                                  '2121-10-30',
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
  }




