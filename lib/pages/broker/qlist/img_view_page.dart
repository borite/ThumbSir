import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImgViewPage extends StatefulWidget {
  final imglist;
  final bool canDel;
  ImgViewPage({Key key,this.imglist,this.canDel }):super(key:key);
  @override
  _ImgViewPageState createState() => _ImgViewPageState();
}

class _ImgViewPageState extends State<ImgViewPage> {
  final controller = PageController(viewportFraction: 2);

  int pageIndex=1;

  final List<String> imgList = [];

  @override
  void initState() {
    super.initState();
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
                      onTap: (){},
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


