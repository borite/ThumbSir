import 'package:ThumbSir/widget/qlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TomorrowQList extends StatefulWidget {
  TomorrowQList({Key key,this.pageIndex,this.tabIndex,this.callBack }):super(key:key);
  int pageIndex;
  int tabIndex;
  final callBack;
  @override
  _TomorrowQListState createState() => _TomorrowQListState();
}

class _TomorrowQListState extends State<TomorrowQList> {
  @override
  void initState(){
    super.initState();
    print('tomorrow');
    print(widget.pageIndex);
    print('tomorrow');
    print(widget.tabIndex);

  }
  void onChange(pIndex,tIndex){
    setState(() {
      this.widget.pageIndex = pIndex;
      this.widget.tabIndex=tIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              constraints: BoxConstraints(
                  minHeight: 800
              ),
              decoration: BoxDecoration(color: Colors.white),
              child:Padding(
                padding: EdgeInsets.only(top:240,bottom:25),
                child: Column(
                  children: <Widget>[
                    Text('今日明日往期'+this.widget.tabIndex.toString()),
                    Text('上午下午晚上'+this.widget.pageIndex.toString()),
                    // 每一条量化
                    QListItem(
                      name: "带看",
                      number: "1组",
                      time: "11：00-12：00",
                      star: 3,
                      percent: 80,
                      pageIndex: this.widget.pageIndex,
                      tabIndex: this.widget.tabIndex,
                      callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                    ),
                    QListItem(
                      name: "实勘",
                      number: "1套",
                      time: "11：00-12：00",
                      star: 3,
                      percent: 100,
                      pageIndex: this.widget.pageIndex,
                      tabIndex: this.widget.tabIndex,
                      callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                    ),
                    QListItem(
                      name: "实勘",
                      number: "1套",
                      time: "11：00-12：00",
                      star: 3,
                      percent: 60,
                      pageIndex: this.widget.pageIndex,
                      tabIndex: this.widget.tabIndex,
                      callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                    ),
                    QListItem(
                      name: "实勘",
                      number: "1套",
                      time: "11：00-12：00",
                      star: 3,
                      percent: 20,
                      pageIndex: this.widget.pageIndex,
                      tabIndex: this.widget.tabIndex,
                      callBack: ()=>onChange(this.widget.pageIndex,this.widget.tabIndex),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}