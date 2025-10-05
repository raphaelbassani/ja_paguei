import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions.dart';
import '../../../core/ui.dart';
import '../../../l10n/jp_locale_keys.dart';
import '../default_padding_widget.dart';

class BalanceTabWidget extends StatelessWidget {
  const BalanceTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final Map<String, List<double>> items = context
    //     .watch<DataBaseViewModel>()
    //     .balanceGraphItems();

    final items = mockBalanceGraphItems();

    return CustomScrollView(
      slivers: [
        const DefaultPaddingWidget(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              if (items.isNotEmpty) ...[
                JPSpacingVertical.l,
                _LineChartWidget(graphItems: items, maxY: maxY(items)),
              ] else
                Padding(
                  padding: JPPadding.all,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JPText(context.translate(JPLocaleKeys.balanceNoGraph)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const DefaultPaddingWidget(),
      ],
    );
  }

  Map<String, List<double>> mockBalanceGraphItems() {
    final random = Random();
    final months = ['jun', 'jul', 'aug', 'sep', 'oct'];

    return {
      for (var m in months)
        m: List.generate(1, (_) => random.nextDouble() * 1000),
    };
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
    return degree * 3.1415926535897932 / 180;
  }
}

class _LineChartWidget extends StatelessWidget {
  final Map<String, List<double>> graphItems;
  final double maxY;

  const _LineChartWidget({required this.graphItems, required this.maxY});

  List<FlSpot> _generateSpots() {
    final items = graphItems.values.toList();
    return List<FlSpot>.generate(
      items.length,
      (index) => FlSpot(
        index.toDouble(),
        items[index].fold(0.0, (prev, el) => prev + el),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final months = graphItems.keys.toList();
    final minX = -0.5;
    final maxX = months.length - 0.5;

    return AspectRatio(
      aspectRatio: 1,
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0 - maxY / 3,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
              spots: _generateSpots(),
              isCurved: true,
              color: const Color(0xFF2196F3),
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF2196F3).withOpacity(0.2),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) =>
                    _VerticalTitlesWidget(value: value, meta: meta),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (value != index.toDouble() ||
                      index < 0 ||
                      index >= months.length) {
                    return const SizedBox.shrink();
                  }
                  return _HorizontalTitlesWidget(
                    monthKey: months[index],
                    meta: meta,
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
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
        ),
      ),
    );
  }
}
