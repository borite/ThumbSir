import 'package:ThumbSir/pages/broker/qlist/analyze_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthAnalyze extends StatefulWidget {
  final DateTime initialDate=DateTime.now();
  @override
  _MonthAnalyzeState createState() => _MonthAnalyzeState();
}

class _MonthAnalyzeState extends State<MonthAnalyze> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState(){
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.only(top:290,bottom:25),
                  child:Column(
                    children: <Widget>[
                      // 每一条量化
                      _continueItem('带看','3','2',77),
                      _continueItem('签委托','3','2',80),
                      _continueItem('实勘','3','2',50),
                      _finishItem('收钥匙', '3', '3'),
                      _finishItem('打电话', '3', '3'),
                      _finishItem('过户', '3', '3'),
                    ],
                  ),
                )
            )
          ],
        ),
        // 背景
        Positioned(
          child: Column(
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ClipPath(
                    clipper: BottomClipper(),
                    child:
                    //  背景
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0E7AE6),Color(0xFF93C0FB)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        image: DecorationImage(
                          image:AssetImage('images/circle_s.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                )
              ]
          ),
        ),
        // 日期
        Align(
          alignment: Alignment(0,-1),
          child: Container(
            width: 335,
            height: 40,
            margin: EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(
                    color: Color(0x990E7AE6),
                    offset: Offset(0.0, 3.0),
                    blurRadius: 10.0,
                    spreadRadius: 2.0
                )],
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.only(left: 8,right: 8),
                      child: Image(image: AssetImage('images/date.png')),
                    ),
                    Text(
                      '2020-04',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0E7AE6),
                      ),
                    )
                  ],
                ),

                // 月选择器插件
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 5),
                        lastDate: DateTime(DateTime.now().year + 1, 9),
                        initialDate: selectedDate ?? widget.initialDate,
                        locale: Locale("es"),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          '日期',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF999999),
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.only(left: 5,right: 8),
                          child: Image(image: AssetImage('images/next.png')),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        // 完成率和业务量
        Align(
          alignment: Alignment(0,-1),
          child: Container(
              width: 290,
              height: 150,
              margin: EdgeInsets.only(top: 140),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(
                      color: Color(0xFFcccccc),
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
                  )],
                  color: Colors.white
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(left: 20),
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          startAngle: 280,
                          angleRange: 360,
                          customWidths: CustomSliderWidths(progressBarWidth: 10),
                          customColors: CustomSliderColors(
                            progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                            trackColor: Color(0x20CCCCCC),
                            dotColor: Colors.transparent,
                          ),
                          infoProperties: InfoProperties(
                              mainLabelStyle: TextStyle(
                                fontSize: 24,
                                color: Color(0xFF2692FD),
                              )
                          )
                      ),
                      min: 0,
                      max: 100,
                      initialValue: 80,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding:EdgeInsets.fromLTRB(20, 15, 10, 15),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('综合完成度',style: TextStyle(color: Color(0xFF0E7AE6),fontSize: 20),),
                            ],
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('计划：共6项',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                            ],
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('已完成：4项',style: TextStyle(color: Color(0xFF666666),fontSize: 14),),
                            ],
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('未完成：2项',style: TextStyle(color: Color(0xFFF24848),fontSize: 14),),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              )

          ),
        ),
      ],
    );

  }
  // 未完成的item
  _continueItem(String name,String sum,String finish,double percent){
    return GestureDetector(
      onTap:() async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalyzeDetailPage()));
      },
      child: Container(
        width: 335,
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
            color: Colors.transparent
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 335,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(
                      color: Color(0xFFcccccc),
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
                  )],
                  color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(left: 15,right: 10),
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                          startAngle: 280,
                          angleRange: 360,
                          customWidths: CustomSliderWidths(progressBarWidth: 4.5),
                          customColors: CustomSliderColors(
                            progressBarColors: [Color(0xFF0E7AE6),Color(0xFF2692FD),Color(0xFF93C0FB)],
                            trackColor: Color(0x20CCCCCC),
                            dotColor: Colors.transparent,
                          ),
                          infoProperties: InfoProperties(
                              mainLabelStyle: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF2692FD),
                              )
                          )
                      ),
                      min: 0,
                      max: 100,
                      initialValue: percent,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 235,
                        padding: EdgeInsets.only(top: 8,bottom: 3),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Color(0xFFF24848),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: 225,
                        child: Row(
                          children: <Widget>[
                            Text('计划：共$sum套',style: TextStyle(fontSize: 12,color: Color(0xFFF24848),),),
                            Text('|',style: TextStyle(fontSize: 16,color: Color(0xFFCCCCCC),letterSpacing: 5),),
                            Text('已完成 $finish套',style: TextStyle(fontSize: 12,color: Color(0xFFF24848),),),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:EdgeInsets.only(left: 5,right: 8),
                    child: Image(image: AssetImage('images/next.png')),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 已完成的item
  _finishItem(String name,String sum,String finish){
    return Container(
      width: 335,
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 335,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(
                  color: Color(0xFFcccccc),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
              )],
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(left: 15,right: 10),
                  child: Image(image:AssetImage('images/finish.png')),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(top: 8,bottom: 3),
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Color(0xFF24CC8E),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: 225,
                      child: Row(
                        children: <Widget>[
                          Text('计划：共$sum套',style: TextStyle(fontSize: 12,color: Color(0xFF999999),),),
                          Text('|',style: TextStyle(fontSize: 16,color: Color(0xFFCCCCCC),letterSpacing: 5),),
                          Text('已完成 $finish套',style: TextStyle(fontSize: 12,color: Color(0xFF999999),),),
                        ],
                      ),
                    )

                  ],
                ),
                Padding(
                  padding:EdgeInsets.only(left: 5,right: 8),
                  child: Image(image: AssetImage('images/next.png')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 导航区域下曲线
class BottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height-70.0); //第2个点
    var firstControlPoint = Offset(size.width/2, size.height);
    var firstEdnPoint = Offset(size.width, size.height-70.0);
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEdnPoint.dx,
        firstEdnPoint.dy
    );
    path.lineTo(size.width, size.height-50.0); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

