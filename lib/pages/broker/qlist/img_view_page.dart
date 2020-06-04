import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImgViewPage extends StatefulWidget {
  @override
  _ImgViewPageState createState() => _ImgViewPageState();
}

class _ImgViewPageState extends State<ImgViewPage> {
  final controller = PageController(viewportFraction: 0.8);
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    ''
  ];
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
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
                      child: Image.network(item, fit: BoxFit.contain, height: height,)
                    ),
                  )).toList(),
                );
              }
            ),

//          Column(
//            children: <Widget>[
//              CarouselSlider(
//                items: imgList.map((item) => Container(
//                    child: Center(
//                      child: Image.network(item, fit: BoxFit.contain, )
//                    ),
//                  )).toList(),
//                options: CarouselOptions(enlargeCenterPage: true, height: 200),
//                carouselController: _controller,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Flexible(
//                    child: RaisedButton(
//                      onPressed: () => _controller.previousPage(),
//                      child: Text('←'),
//                    ),
//                  ),
//                  Flexible(
//                    child: RaisedButton(
//                      onPressed: () => _controller.nextPage(),
//                      child: Text('→'),
//                    ),
//                  ),
//                  ...Iterable<int>.generate(imgList.length).map(
//                        (int pageIndex) => Flexible(
//                      child: RaisedButton(
//                        onPressed: () => _controller.animateToPage(pageIndex),
//                        child: Text("$pageIndex"),
//                      ),
//                    ),
//                  ),
//                ],
//              )
//            ],
//          ),
          // 导航栏
          Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top: 40),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image(image: AssetImage('images/back.png'),),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Image(image: AssetImage('images/delete_blue.png'),),
                    )
                  )
                ],
              )
          ),
        ],
      )
    );
  }
}
