import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatefulWidget {
  final bool isDetailScreen;
  Chart({this.isDetailScreen = false});
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Color> gradientColors = [
    const Color(0xffF469BD),
    const Color(0xffB880FF),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff474E73).withOpacity(0.5),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff474E73).withOpacity(0.5),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: widget.isDetailScreen,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) =>
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 8),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '15 Nov';
              case 4:
                return '20 Nov';
              case 6:
                return '25 Nov';
              case 8:
                return '30 Nov';
              case 10:
                return '1 Dec';
            }
            return '';
          },
          margin: 11,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(show: false, border: Border.all(color: const Color(0xff474E73), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 6),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              Color(0xff343956).withOpacity(0.3),
              Color(0xff3A3F5F).withOpacity(0.3),
            ].map((color) => color).toList(),
          ),
        ),
      ],
    );
  }
}
