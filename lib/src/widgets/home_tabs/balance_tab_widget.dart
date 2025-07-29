import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../ui.dart';
import '../../helpers/extensions.dart';

class BalanceTabWidget extends StatelessWidget {
  const BalanceTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainItems = <String, List<double>>{
      context.translate(JPLocaleKeys.jan): [.2, .2, .2, .2, 5],
      context.translate(JPLocaleKeys.feb): [1.8, 2.7, 3, 6.5],
      context.translate(JPLocaleKeys.mar): [1.5, 2, 3.5, 6],
      context.translate(JPLocaleKeys.apr): [1.5, 1.5, 4, 6.5],
      context.translate(JPLocaleKeys.may): [2, 2, 5, 9],
      context.translate(JPLocaleKeys.jun): [1.2, 1.5, 4.3, 10],
    };
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _BarChartWidget(graphItems: mainItems)),
      ],
    );
  }
}

class _BarChartWidget extends StatefulWidget {
  final Map<String, List<double>> graphItems;

  const _BarChartWidget({required this.graphItems});

  @override
  State<StatefulWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<_BarChartWidget> {
  final double _barWidth = 28;
  final List<Color> _rodColors = [
    Color(0xFF2196F3),
    Color(0xFFFFC300),
    Color(0xFFFF683B),
    Color(0xFF3BFF49),
    Color(0xFF6E1BFF),
    Color(0xFFFF3AF2),
    Color(0xFFE80054),
    Color(0xFF50E4FF),
  ];
  int _touchedIndex = -1;

  BarChartGroupData generateGroup({
    required int keyIndex,
    required List<double> values,
  }) {
    final isTouched = _touchedIndex == keyIndex;
    double sum = 0;
    for (var e in values) {
      sum += e;
    }

    double barRodSum = 0;

    return BarChartGroupData(
      x: keyIndex,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: sum,
          width: _barWidth,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          rodStackItems: List<BarChartRodStackItem>.generate(values.length, (
            index,
          ) {
            double value = values[index];
            barRodSum += value;
            int colorsLength = _rodColors.length - 1;

            int truncated = index ~/ colorsLength;

            return BarChartRodStackItem(
              barRodSum - value,
              barRodSum,
              _rodColors[(index / colorsLength) > 1
                  ? (index - (colorsLength * truncated))
                  : index],
              BorderSide(color: Colors.white, width: isTouched ? 2 : 0),
            );
          }),
        ),
      ],
    );
  }

  bool isShadowBar(int rodIndex) => rodIndex == 1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 20,
          minY: 0,
          groupsSpace: 12,
          barTouchData: BarTouchData(
            handleBuiltInTouches: false,
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                setState(() {
                  _touchedIndex = -1;
                });
                return;
              }
              final rodIndex = barTouchResponse.spot!.touchedRodDataIndex;
              if (isShadowBar(rodIndex)) {
                setState(() {
                  _touchedIndex = -1;
                });
                return;
              }
              setState(() {
                _touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  final int index = value.toInt();
                  final List<String> keys = widget.graphItems.keys.toList();
                  if (index > keys.length - 1 || index < 0) {
                    return Container();
                  }

                  return _HorizontalTitlesWidget(
                    month: keys[index],
                    meta: meta,
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) =>
                    _VerticalTitlesWidget(value: value, meta: meta),
                interval: 5,
                reservedSize: 42,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (_, __) => SizedBox(),
              ),
            ),

            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (_, __) => SizedBox(),
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (value) => value % 5 == 0,
            getDrawingHorizontalLine: (value) {
              if (value == 0) {
                return FlLine(
                  color: Colors.white54.withValues(alpha: 0.1),
                  strokeWidth: 3,
                );
              }
              return FlLine(
                color: Colors.white54.withValues(alpha: 0.05),
                strokeWidth: 0.8,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: List<BarChartGroupData>.generate(
            widget.graphItems.length,
            (index) {
              final List<double> currentValue = widget.graphItems.values
                  .toList()[index];

              return generateGroup(keyIndex: index, values: currentValue);
            },
          ),
        ),
      ),
    );
  }
}

class _HorizontalTitlesWidget extends StatelessWidget {
  final String month;
  final TitleMeta meta;

  const _HorizontalTitlesWidget({required this.month, required this.meta});

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(meta: meta, child: JPText(month));
  }
}

class _VerticalTitlesWidget extends StatelessWidget {
  final double value;
  final TitleMeta meta;

  const _VerticalTitlesWidget({required this.value, required this.meta});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${value.toInt()}0k';
    }
    return SideTitleWidget(
      angle: degreeToRadian(0),
      meta: meta,
      space: 4,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }
}
