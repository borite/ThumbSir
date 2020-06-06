import 'package:ThumbSir/pages/broker/qlist/analyze_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AnalyzeItem extends StatefulWidget {
  final String name;
  final String sum;
  final String finish;
  final double percent;
  const AnalyzeItem({Key key,this.name,this.sum,this.finish,this.percent});
  @override
  _AnalyzeItemState createState() => _AnalyzeItemState();
}

class _AnalyzeItemState extends State<AnalyzeItem> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationValue;

  @override
  void initState() {
    super.initState();
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
        onTap:() async{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalyzeDetailPage()));
        },
        child: Container(
          width: 335,
          margin: EdgeInsets.only(top: animation.value),
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
                      child: this.widget.percent == 100?
                      Image(image:AssetImage('images/finish.png'))
                      :
                      SleekCircularSlider(
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
                        initialValue: this.widget.percent,
                      ),
                    ),
                    this.widget.percent == 100?
                    Column(
                      children: <Widget>[
                        Container(
                          width: 225,
                          padding: EdgeInsets.only(top: 8,bottom: 3),
                          child: Text(
                            this.widget.name,
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
                              Text('计划：共'+this.widget.sum+'套',style: TextStyle(fontSize: 12,color: Color(0xFF999999),),),
                              Text('|',style: TextStyle(fontSize: 16,color: Color(0xFFCCCCCC),letterSpacing: 5),),
                              Text('已完成 '+this.widget.finish+'套',style: TextStyle(fontSize: 12,color: Color(0xFF999999),),),
                            ],
                          ),
                        )

                      ],
                    )
                        :
                    Column(
                      children: <Widget>[
                        Container(
                          width: 225,
                          padding: EdgeInsets.only(top: 8,bottom: 3),
                          child: Text(
                            this.widget.name,
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
                              Text('计划：共'+this.widget.sum+'套',style: TextStyle(fontSize: 12,color: Color(0xFFF24848),),),
                              Text('|',style: TextStyle(fontSize: 16,color: Color(0xFFCCCCCC),letterSpacing: 5),),
                              Text('已完成 '+this.widget.finish+'套',style: TextStyle(fontSize: 12,color: Color(0xFFF24848),),),
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
}

