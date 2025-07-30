import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/ui/ui.dart';
import '../../../l10n/jp_locale_keys.dart';
import '../../state/view_models.dart';

class BalanceTabWidget extends StatelessWidget {
  const BalanceTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<double>> items = context
        .watch<DataBaseViewModel>()
        .balanceGraphItems();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              JPSpacingVertical.l,
              if (items.length > 1)
                _BarChartWidget(
                  graphItems: items,
                  maxY: maxY(items),
                  barWidth: 200 / items.length,
                )
              else
                Padding(
                  padding: JPPadding.all,
                  child: JPText(context.translate(JPLocaleKeys.balanceNoGraph)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  double maxY(Map<String, List<double>> items) {
    List<List<double>> values = items.values.toList();
    double newMaxY = 0;

    for (var e in values) {
      double sum = e.fold(
        0.0,
        (previousValue, element) => previousValue + element,
      );

      if (sum > newMaxY) {
        newMaxY = sum;
      }
    }

    return newMaxY + (newMaxY * .2);
  }
}

class _BarChartWidget extends StatefulWidget {
  final Map<String, List<double>> graphItems;
  final double maxY;
  final double barWidth;

  const _BarChartWidget({
    required this.graphItems,
    required this.maxY,
    required this.barWidth,
  });

  @override
  State<StatefulWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<_BarChartWidget> {
  final List<Color> _rodColors = [
    const Color(0xFF2196F3),
    const Color(0xFFFFC300),
    const Color(0xFFFF683B),
    const Color(0xFF3BFF49),
    const Color(0xFF6E1BFF),
    const Color(0xFFFF3AF2),
    const Color(0xFFE80054),
    const Color(0xFF50E4FF),
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
          width: widget.barWidth,
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
              BorderSide(color: context.textColor, width: isTouched ? 1 : 0),
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
          maxY: widget.maxY,
          minY: 0,
          groupsSpace: 6,
          barTouchData: BarTouchData(
            handleBuiltInTouches: false,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => Colors.transparent,
              tooltipBorder: const BorderSide(color: Colors.transparent),
              getTooltipItem:
                  (BarChartGroupData _, int _, BarChartRodData rod, int _) {
                    return BarTooltipItem(
                      context.currencyIntoString(rod.toY),
                      context.textStyle,
                    );
                  },
            ),
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
                    monthKey: keys[index],
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
                interval: widget.maxY / 4,
                reservedSize: 50,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (_, __) => const SizedBox(),
              ),
            ),

            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (_, __) => const SizedBox(),
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: context.textColor.withAlpha(25),
                strokeWidth: 0.8,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: context.textColor.withAlpha(25),
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
  final String monthKey;
  final TitleMeta meta;

  const _HorizontalTitlesWidget({required this.monthKey, required this.meta});

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      meta: meta,
      child: JPText(context.translate(monthKey)),
    );
  }
}

class _VerticalTitlesWidget extends StatelessWidget {
  final double value;
  final TitleMeta meta;

  const _VerticalTitlesWidget({required this.value, required this.meta});

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      angle: degreeToRadian(0),
      meta: meta,
      space: 4,
      child: JPText(
        '${context.currency} ${value.round().toString()}',
        type: JPTextTypeEnum.xs,
      ),
    );
  }

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }
}
