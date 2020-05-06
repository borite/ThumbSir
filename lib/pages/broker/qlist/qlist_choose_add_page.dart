import 'package:ThumbSir/pages/broker/qlist/qlist_add_page.dart';
import 'package:flutter/material.dart';

class QListChooseAddPage extends StatefulWidget {
  @override
  _QListChooseAddPageState createState() => _QListChooseAddPageState();
}

class _QListChooseAddPageState extends State<QListChooseAddPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60,bottom: 50),
              child: Text('新增任务',style: TextStyle(fontSize: 16,color: Color(0xFF0E7AE6)),textAlign: TextAlign.center,),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20,right: 20,left: 20),
                height: 80,
                decoration: BoxDecoration(
                    border:Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 35,
                          child: Image(image: AssetImage('images/plantoday.png')),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '今日任务',
                            style:TextStyle(
                              fontSize: 20,
                              color: Color(0xFF0E7AE6),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image(image: AssetImage('images/edit.png'),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QListAddPage()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20,right: 20,left: 20),
                height: 80,
                decoration: BoxDecoration(
                    border:Border(bottom: BorderSide(width: 1,color: Color(0xFFEBEBEB)))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 35,
                          child: Image(image: AssetImage('images/plantom.png')),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '明日任务',
                            style:TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFF9600),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image(image: AssetImage('images/edit.png'),)
                  ],
                ),
              ),
            ),
          ]
        )
    );
  }
}
