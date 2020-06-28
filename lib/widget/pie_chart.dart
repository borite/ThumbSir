import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';
class PieChartView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartViewState();
}
class PieChartViewState extends State {
  Color c1 = Color(0xFF0E7AE6);
  Color c2 = Color(0xFFF67818);
  Color c3 = Color(0xFF24CC8E);
  Color c4 = Color(0xFF7412F2);
  Color c5 = Color(0xFFF24848);
  Color c6 = Color(0xFF93C0FB);
  Color c7 = Color(0x99EB6666);
  Color c8 = Color(0xFF003273);
  Color c9 = Color(0x999149EC);
  Color c10 = Color(0xFF999999);
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 335,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                          pieTouchResponse.touchInput is FlPanEnd) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 80,
                  sections: showingSections()),
            ),
            Container(
              margin: EdgeInsets.only(top: 30,left: 40,right: 40),
              alignment: Alignment.center,
              child: Column(
                children: const <Widget>[
                  Indicator(
                    color: Color(0xFF0E7AE6),
                    text: '打电话-44%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFFF67818),
                    text: '带看-20%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFF24CC8E),
                    text: '面访业主-15%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFF7412F2),
                    text: '谈单-10%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFFF24848),
                    text: '带看-5%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFF93C0FB),
                    text: '面访业主-2%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0x99EB6666),
                    text: '谈单-1%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFF003273),
                    text: '谈单-1%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0x999149EC),
                    text: '谈单-1%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Color(0xFF666666),
                    text: '其他-1%',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      '其他包括：面访-0.3%、物业交割-0.2%、开会-0.1%、社区-0.05%、排练-0.02%',
                    style: TextStyle(
                      color: Color(0xff505050)
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(10, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF0E7AE6),
            value: 44,
            title: '44%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFF67818),
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF24CC8E),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFF7412F2),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xFFF24848),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: const Color(0xFF93C0FB),
            value: 2,
            title: '2%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: const Color(0x99EB6666),
            value: 1,
            title: '1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 7:
          return PieChartSectionData(
            color: const Color(0xFF003273),
            value: 1,
            title: '1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 8:
          return PieChartSectionData(
            color: const Color(0x999149EC),
            value: 1,
            title: '1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 9:
          return PieChartSectionData(
            color: const Color(0xFF666666),
            value: 1,
            title: '1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}