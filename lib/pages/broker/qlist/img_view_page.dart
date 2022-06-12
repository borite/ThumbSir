import 'package:ThumbSir/dao/get_user_mission_records_dao.dart';
import 'package:ThumbSir/model/common_result_model.dart';
import 'package:ThumbSir/model/mission_record_model.dart';
import 'package:ThumbSir/pages/major/qlist/major_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/manager_qlist_page.dart';
import 'package:ThumbSir/pages/manager/qlist/s_qlist_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ThumbSir/dao/delete_single_mission_pic_dao.dart';
import 'package:ThumbSir/pages/broker/qlist/qlist_page.dart';

class ImgViewPage extends StatefulWidget {
  final imglist;
  final bool canDel;
  final userid,taskid;
  final userlevel;
  ImgViewPage({Key? key,this.imglist,required this.canDel,this.userid,this.userlevel,this.taskid }):super(key:key);
  @override
  _ImgViewPageState createState() => _ImgViewPageState();
}

class _ImgViewPageState extends State<ImgViewPage> {
  final controller = PageController(viewportFraction: 2);

  int pageIndex=1;

  final String current_img_url="";
  List<String> imgList = [];

  @override
  void initState() {
    super.initState();
    print(widget.userid);
    for(String url in widget.imglist){
      imgList.add(url);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: <Widget>[
            Builder(
                builder: (context) {
                  final double height = MediaQuery.of(context).size.height;
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      aspectRatio: 2,
                      onPageChanged: (int index, CarouselPageChangedReason reason){
                          setState(() {
                            pageIndex=index+1;
                          });
                      },
                      // autoPlay: false,
                    ),
                    items: imgList.map((item) => Container(
                      child: Center(
//                        child: Text(imgList.indexOf(item).toString(),style: TextStyle(color: Colors.amber),),
                          child: Image.network(item, fit: BoxFit.contain, height: height,)
                      ),
                    )).toList(),
                  );
                }
            ),
//          导航栏
            Padding(
                padding: EdgeInsets.only(left: 15,right: 15,top: 50),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Image(image: AssetImage('images/back_w_arrow.png'),),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 30,
                      padding: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("第"+pageIndex.toString()+"张 / 共"+imgList.length.toString()+"张",style: TextStyle(
                        color: Colors.white,
                      ),textAlign: TextAlign.center,),
                    ),
                    widget.canDel==true?
                    GestureDetector(
                      onTap: () async{
                        String currentImgUrl=imgList[pageIndex-1];
                        //print(currentImgUrl);
                        print("当前用户级别");
                        //print(widget.userlevel);
                        print(widget.taskid);
                        print(widget.userid);
                        print(widget.userlevel);
                        if(widget.taskid != null && widget.userid != null && widget.userlevel != null){
                          CommonResult m_record= await DeleteMissionPicDao.deleteSingleMissionPic(widget.taskid, widget.userid, widget.userlevel.substring(0,1), currentImgUrl);
                          print(m_record);
                          if(m_record.code==200) {
                            print("单个删除图片成功");
                            GetMissionRecord mr= await GetMissionRecordDao.missionRecord(widget.userid,widget.taskid,widget.userlevel.substring(0,1));
                            if(mr.code==200){
                              print("重新获取任务记录");
                              List<String> leftImg=[];
                              if(mr.data==null){
                                print("已全部删除");
                                if(widget.userlevel.substring(0,1)=="6"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QListPage()));
                                }
                                if(widget.userlevel.substring(0,1)=="5"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerQListPage()));
                                }
                                if(widget.userlevel.substring(0,1)=="4"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SQListPage()));
                                }
                                if(widget.userlevel.substring(0,1)=="1"||widget.userlevel.substring(0,1)=="2"||widget.userlevel.substring(0,1)=="3"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MajorQListPage()));
                                }
                              }else{
                                for(String missImg in mr.data!.missionImgs!.split('|')){
                                  if(missImg!="") {
                                    leftImg.add(missImg);
                                  }
                                }
                                setState(() {
                                  pageIndex=1;
                                  imgList=leftImg;
                                });
                                print("还有"+leftImg.length.toString()+"张图片");
                              }

                            }
                          }
                        }else{print("传值为空");}

                      },
                      child: Container(
                        width: 50,
                        height: 30,
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text("删除",style: TextStyle(
                          color: Colors.white,
                        ),textAlign: TextAlign.center,),
                      ),
                    )
                    :Container(
                      width: 50,
                      height: 30,
                      padding: EdgeInsets.only(top: 4),
                    ),
                  ],
                )
            ),
          ],
        ),
      )
    );
  }
}


