import 'package:ThumbSir/pages/house/house_detail_page.dart';
import 'package:flutter/material.dart';

class HouseItem extends StatefulWidget {
  final houseItem;
  HouseItem({Key? key,
    this.houseItem,
  }):super(key:key);
  @override
  _HouseItemState createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;
  int page = 0;
  var tags=[];
  List<Widget> tagsTips=[];

  final nowDate = DateTime.now();
  var differenceTime;

  _addTags(){
    if(widget.houseItem!=null){
      if(widget.houseItem.houseType != null ){
        tags.add(widget.houseItem.houseType);
      }
      if(widget.houseItem.houseInfo.length>0 && widget.houseItem.houseInfo[0].tax=="满五唯一,"){
        tags.add("满五唯一");
      }
      if(widget.houseItem.houseAroundInfo.length>0 && widget.houseItem.houseAroundInfo[0].traffic.toString().contains("地铁")){
        tags.add("近地铁");
      }
      if(widget.houseItem.houseAroundInfo.length>0 && widget.houseItem.houseAroundInfo[0].isInSchoolArea){
        tags.add("学区房");
      }
      if(widget.houseItem.keyUser != null ){
        tags.add("随时看房");
      }
      if(widget.houseItem.houseInfo.length>0 && widget.houseItem.houseInfo[0].decoration=="精装修,"){
        tags.add("精装修");
      }
    }
    if(tags.length>0){

      for (var item1 in tags) {
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
  }

  @override
  void initState() {
    super.initState();
    _addTags();
    // 报盘时间
    differenceTime = nowDate.difference(widget.houseItem.addTime).inDays;
    if(differenceTime>300){
      differenceTime = ">300";
    }

    controller = AnimationController(vsync:this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 500,end:25).animate(
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
    controller.forward();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HouseDetailPage(
          houseId : widget.houseItem.houseId.toString(),
          tags:tags,
          houseNum:widget.houseItem.houseNum
        )));
      },
      child: Container(
        width: 335,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: animation.value),
        child: Container(
          width: 335,
          // height: 104,
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
          child: Row(
            children: [
              Container(
                width: 80,
                height: 60,
                margin: EdgeInsets.only(left: 10,right: 10),
                color: Colors.black12,
                child:
                widget.houseItem.houseInfo.length>0?
                    widget.houseItem.houseInfo[0].houseImages !="" && widget.houseItem.houseInfo[0].houseImages !=null?
                Image(image: NetworkImage(widget.houseItem.houseInfo[0].houseImages.split('|')[0]),fit: BoxFit.fill,)
                    :
                Image(image: AssetImage('images/time.png'),)
                    :
                Image(image: AssetImage('images/time.png'),),
              ),

              Column(
                children: <Widget>[
                  // 小区名，报盘时间
                  Container(
                    width: 220,
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width:110,
                              child: Text(
                                widget.houseItem!=null?widget.houseItem.houseCommunity:"未完善",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            widget.houseItem!=null && widget.houseItem.tradeLevel=="着急"
                                || widget.houseItem!=null && widget.houseItem.tradeLevel=="诚心"
                            || widget.houseItem!=null && widget.houseItem.tradeLevel=="一般"?
                            Container(
                              width: 25,
                              height: 25,
                              padding: EdgeInsets.only(left: 4),
                              child: Image(image:
                              widget.houseItem!=null && widget.houseItem.tradeLevel=="着急"?
                              AssetImage('images/urgent1.png')
                                      :widget.houseItem!=null && widget.houseItem.tradeLevel=="诚心"?
                                  AssetImage('images/urgent2.png')
                                      :AssetImage('images/urgent3.png'),
                              ),
                            ):Container(width: 1,),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4, top: 3),
                          child: Text(
                            '报盘'+differenceTime.toString()+'天',
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
                  // 基本信息
                  Container(
                    width: 220,
                    padding: EdgeInsets.only(top: 5, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '2-1-1-1',
                          widget.houseItem.houseInfo.length<1 || widget.houseItem.houseInfo[0].structure==null || widget.houseItem.houseInfo[0].structure==""?"-居室"
                              :widget.houseItem.houseInfo[0].structure,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          // '88.85平',
                          widget.houseItem.houseInfo.length<1 || widget.houseItem.houseInfo[0].area==null || widget.houseItem.houseInfo[0].area==""?"-平":(widget.houseItem.houseInfo[0].area.toString().split(".")[0].toString()+"平"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.houseItem.houseInfo.length<1|| widget.houseItem.houseInfo[0].floor==null || widget.houseItem.houseInfo[0].floor==""
                              || widget.houseItem.houseInfo[0].totalFloor==""|| widget.houseItem.houseInfo[0].totalFloor==null?"-层"
                              :(widget.houseItem.houseInfo[0].floor.toString()+"/"+widget.houseItem.houseInfo[0].totalFloor.toString()+"层"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.houseItem.houseInfo.length<1 || widget.houseItem.houseInfo[0].orientation==null || widget.houseItem.houseInfo[0].orientation==""?"-朝向"
                              :widget.houseItem.houseInfo[0].orientation
                              .substring(0,widget.houseItem.houseInfo[0].orientation.lastIndexOf(',')).split(',').toString()
                              .replaceAll("[", "").replaceAll("]", ""),
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
                  // 房源特色
                  Container(
                    width: 220,
                    child: Wrap(
                      children: tagsTips,
                    ),
                  ),
                  // 总价、单价
                  Container(
                    width: 220,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              child: Text(
                                widget.houseItem!=null?widget.houseItem.housePrice.toString().split(".")[0].toString()+"万":"-",
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
                        Container(
                          padding: EdgeInsets.only(left: 4, top: 3),
                          child: Text(
                            widget.houseItem!=null?(
                                widget.houseItem.houseInfo.length<1 || widget.houseItem.houseInfo.length<1 || widget.houseItem.houseInfo[0].area==null || widget.houseItem.houseInfo[0].area==""?"-元/平"
                                    :(widget.houseItem.housePrice*10000/widget.houseItem.houseInfo[0].area).toString().split(".")[0].toString()+"元/平"
                            ):'-元/平',
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
              ),
            ],
          )

        ),
      ),
    );
  }
}

