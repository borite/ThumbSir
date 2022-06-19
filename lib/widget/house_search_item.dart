import 'package:flutter/material.dart';

import '../pages/broker/house/house_detail_page.dart';

class HouseSearchItem extends StatefulWidget {
  final houseItem;
  HouseSearchItem({Key? key,
    this.houseItem,
  }):super(key:key);
  @override
  _HouseSearchItemState createState() => _HouseSearchItemState();
}

class _HouseSearchItemState extends State<HouseSearchItem> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;
  int page = 0;
  dynamic tags=[];
  List<Widget> tagsTips=[];

  final nowDate = DateTime.now();
  var differenceTime;

  _addTags(){
    if(widget.houseItem!=null){
      if(widget.houseItem.houseType != null ){
        tags.add(widget.houseItem.houseType);
      }
      if(widget.houseItem.tax=="满五唯一,"){
        tags.add("满五唯一");
      }
      if(widget.houseItem.otherLabel!=null && widget.houseItem.otherLabel!=""&& widget.houseItem.otherLabel.contains("地铁")){
        tags.add("近地铁");
      }
      if(widget.houseItem.otherLabel!=null && widget.houseItem.otherLabel!=""&& widget.houseItem.otherLabel.contains("学区房")){
        tags.add("学区房");
      }
      if(widget.houseItem.otherLabel!=null && widget.houseItem.otherLabel!=""&& widget.houseItem.otherLabel.contains("随时看房")){
        tags.add("随时看房");
      }
      if(widget.houseItem.decoration=="精装修,"){
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
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.houseItem);
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
          houseId : widget.houseItem.hid.toString(),
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
                widget.houseItem.houseImages !="" && widget.houseItem.houseImages !=null?
                Image(image: NetworkImage(widget.houseItem.houseImages.split('|')[0]),fit: BoxFit.fill,)
                    :
                Image(image: AssetImage('images/time.png'),)
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
                          widget.houseItem.structure==null || widget.houseItem.structure==""?"-居室"
                              :widget.houseItem.structure,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          // '88.85平',
                          widget.houseItem.area==null || widget.houseItem.area==""?"-平":(widget.houseItem.area.toString().split(".")[0].toString()+"平"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.houseItem.floor==null || widget.houseItem.floor==""
                              || widget.houseItem.totalFloor==""|| widget.houseItem.totalFloor==null?"-层"
                              :(widget.houseItem.floor.toString()+"/"+widget.houseItem.totalFloor.toString()+"层"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.houseItem.orientation==null || widget.houseItem.orientation==""?"-朝向"
                              :widget.houseItem.orientation,
                              // .substring(0,widget.houseItem.orientation.lastIndexOf(',')).split(',').toString(),
                              // .replaceAll("[", "").replaceAll("]", ""),
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
                                widget.houseItem.area==null || widget.houseItem.area==""?"-元/平"
                                    :(widget.houseItem.housePrice*10000/widget.houseItem.area).toString().split(".")[0].toString()+"元/平"
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

