import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImgViewPage extends StatefulWidget {
  @override
  _ImgViewPageState createState() => _ImgViewPageState();
}

class _ImgViewPageState extends State<ImgViewPage> {
  final controller = PageController(viewportFraction: 2);

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  ];

  @override
  void initState() {
    super.initState();
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
                      child: Text("第"+imgList.length.toString()+"张 / 共"+imgList.length.toString()+"张",style: TextStyle(
                        color: Colors.white,
                      ),textAlign: TextAlign.center,),
                    ),
                    Container(
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
                  ],
                )
            ),
          ],
        ),
      )
    );
  }
}


