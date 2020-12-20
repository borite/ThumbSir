import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ThumbSir/widget/pie_chart_indicator.dart';
class PieChartSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}
class PieChart2State extends State {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return
      AspectRatio(
      aspectRatio: 0.7,
      child: Container(
        margin: EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
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
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                PieChartIndicator(
                  color: Color(0xff0293ee),
                  text: '40%——打客户电话',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xfff8b250),
                  text: '30%——打业主电话',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xff845bef),
                  text: '15%——带看',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xff13d38e),
                  text: '5%——实勘',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xff01e9ee),
                  text: '3%——未知',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xff7aee01),
                  text: '2%——全天休息',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xffee6101),
                  text: '2%——午饭/晚饭',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xffee01d5),
                  text: '1%——休息',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xff4e01ee),
                  text: '1%——面访',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                PieChartIndicator(
                  color: Color(0xffeeea01),
                  text: '1%——其余各项（过户、网签、面签、匹配房源、收五证、社区开发、午饭/晚饭）',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(9, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: 40,
              title: '40%',
              radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xff01e9ee),
            value: 3,
            title: '3%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: const Color(0xff7aee01),
            value: 2,
            title: '2%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xffee6101),
            value: 2,
            title: '2%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 6:
          return PieChartSectionData(
            color: const Color(0xffee01d5),
            value: 1,
            title: '1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 7:
          return PieChartSectionData(
            color: const Color(0xff4e01ee),
            value: 1,
            title: '1%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 8:
          return PieChartSectionData(
            color: const Color(0xffeeea01),
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