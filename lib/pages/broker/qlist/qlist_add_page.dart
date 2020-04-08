import 'package:flutter/material.dart';
import 'package:ThumbSir/pages/broker/mycenter/my_center_page.dart';

class QListAddPage extends StatefulWidget {
  @override
  _QListAddPageState createState() => _QListAddPageState();
}

class _QListAddPageState extends State<QListAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Text('添加量化条目')
      ),
      appBar:AppBar(
          leading:GestureDetector(
            onTap: (){
              Navigator.pop(context);
              RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                },
                color: Colors.transparent,
                elevation: 0,
                disabledElevation: 0,
                highlightColor: Colors.transparent,
                highlightElevation: 0,
                splashColor: Colors.transparent,
                disabledColor: Colors.transparent,
                child: ClipOval(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child:Image(
                          width: 26,
                          height:26,
                          image: AssetImage('images/my.png'),
                        ),
                      )
                  ),
                ),
              );
              RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCenterPage()));
                },
                color: Colors.transparent,
                elevation: 0,
                disabledElevation: 0,
                highlightColor: Colors.transparent,
                highlightElevation: 0,
                splashColor: Colors.transparent,
                disabledColor: Colors.transparent,
                child: ClipOval(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child:Image(
                          width: 26,
                          height:26,
                          image: AssetImage('images/my.png'),
                        ),
                      )
                  ),
                ),
              );
            },
            child: Icon(Icons.home),
          )
      ),
    );
  }
}
