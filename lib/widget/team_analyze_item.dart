import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../pages/qlist/manager/analyze_detail_page.dart';

class TeamAnalyzeItem extends StatefulWidget {
  final String name;
  final String sum;
  final String finish;
  final double percent;
  final double timePersent;
  final String unit;
  final String taskId;
  final String section;
  final String companyId;
  final startTime;
  final endTime;
  final leaderID;
  const TeamAnalyzeItem({Key? key,
    required this.name,required this.sum,required this.finish,required this.percent,required this.timePersent,required this.unit,
    required this.taskId,required this.section,required this.companyId,this.startTime,this.endTime,this.leaderID
  });
  @override
  _TeamAnalyzeItemState createState() => _TeamAnalyzeItemState();
}

class _TeamAnalyzeItemState extends State<TeamAnalyzeItem> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus animationStatus;
  late double animationValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync:this,duration: const Duration(seconds: 1));
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalyzeDetailPage(
            section:widget.section,
            companyId:widget.companyId,
            taskId:widget.taskId.toString(),
            startTime:widget.startTime.toString(),
            endTime:widget.endTime.toString(),
            leaderID: widget.leaderID,
          )));
        },
        child: Container(
          width: 335,
          margin: EdgeInsets.only(top: animation.value),
          decoration: const BoxDecoration(
              color: Colors.transparent
          ),
          child: Container(
            width: 335,
            height: 94,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(
                    color: Color(0xFFcccccc),
                    offset: Offset(0.0, 3.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0
                )],
                color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                // 完成度
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:const EdgeInsets.only(top: 10),
                        width: 182,
                        child: StepProgressIndicator(
                          totalSteps: 100,
                          currentStep: widget.percent==0.0?0:widget.percent==100.0?100:widget.percent.toInt(),
                          size: 14,
                          padding: 0,
                          selectedColor: const Color(0xFF4ED491),
                          unselectedColor: const Color(0xFF6E85D3),
                          roundedEdges: const Radius.circular(7),
                          selectedGradientColor: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF6E85D3),Color(0xFF4ED491)],
                          ),
                          unselectedGradientColor: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x80CCCCCC),Color(0x30CCCCCC),Color(0x10CCCCCC)],
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 60,
                          child: Text(
                            //"88.8",
                            widget.percent==0.0?"0":widget.percent==100.0?"100":widget.percent.toString(),
                            style: TextStyle(
                                fontSize: 24,
                                color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
                            ),
                            textAlign: TextAlign.right,
                          )
                      ),
                      Container(
                          margin:const EdgeInsets.only(top:10,right: 6),
                          child: Text(
                            "%",
                            style: TextStyle(
                                fontSize: 12,
                                color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
                            ),
                            textAlign: TextAlign.right,
                          )
                      ),
                      Container(
                          margin:const EdgeInsets.only(top:10),
                          width: 40,
                          child: Text(
                            widget.percent==100.0?"已完成" :"未完成",
                            style: TextStyle(
                                fontSize: 12,
                                color: widget.percent==100.0?const Color(0xFF4ED491) :const Color(0xFF6E85D3)
                            ),
                            textAlign: TextAlign.right,
                          )
                      ),
                    ],
                  ),
                ),
                // 名称
                Container(
                    width: 300,
                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.access_alarms,
                          color: Color(0xFF6E85D3),
                          size: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6E85D3),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4,left: 10),
                          child: Text(
                            '时间占比：'+widget.timePersent.toString().split(".")[0]+'%',
                            style: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )
                ),
                // 数量
                SizedBox(
                  width: 252,
                  child: Row(
                    children: <Widget>[
                      Text('计划：共'+widget.sum+widget.unit,style: const TextStyle(fontSize: 12,color: Color(0xFF666666),),),
                      Container(width: 20,),
                      Text('已完成 '+widget.finish+widget.unit,style: const TextStyle(fontSize: 12,color: Color(0xFF666666),),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
}

