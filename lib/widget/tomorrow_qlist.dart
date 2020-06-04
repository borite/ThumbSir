import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TomorrowQList extends StatefulWidget {
  @override
  _TomorrowQListState createState() => _TomorrowQListState();
}

class _TomorrowQListState extends State<TomorrowQList> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            constraints: BoxConstraints(
                minHeight: 800
            ),
            decoration: BoxDecoration(color: Colors.white),
            child:Padding(
              padding: EdgeInsets.only(top:265,bottom:25),
              child: Column(
                children: <Widget>[
                  // 每一条量化
                  QListItem(
                    name: "带看",
                    number: "1组",
                    time: "11：00-12：00",
                    star: 3,
                    percent: 80,
                  ),
                  QListItem(
                    name: "实勘",
                    number: "1套",
                    time: "11：00-12：00",
                    star: 3,
                    percent: 100,
                  ),
                  QListItem(
                    name: "实勘",
                    number: "1套",
                    time: "11：00-12：00",
                    star: 3,
                    percent: 60,
                  ),
                  QListItem(
                    name: "实勘",
                    number: "1套",
                    time: "11：00-12：00",
                    star: 3,
                    percent: 20,
                  ),
                ],
              ),
            ))
      ],
    );
  }
}