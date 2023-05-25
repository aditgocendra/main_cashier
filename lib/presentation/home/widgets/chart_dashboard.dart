import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../color_app.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/format_utils.dart';
import '../tab_controller/dashboard_tab_controller.dart';

class ChartDashboard extends StatelessWidget {
  const ChartDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorApp = context.watch<ColorApp>();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ProfitChart(
            gradientColor: [
              colorApp.primary,
              colorApp.primaryLight,
            ],
            colorApp: colorApp,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: BestSellerCategoryChart(
            colorApp: colorApp,
          ),
        )
      ],
    );
  }
}

// Profit Chart
class ProfitChart extends StatelessWidget {
  final List<Color> gradientColor;
  final ColorApp colorApp;

  const ProfitChart({
    required this.gradientColor,
    required this.colorApp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardTabController>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorApp.canvas,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Profit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const Dialog(
                          child: DialogYearPicker(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "January - December ${controller.yearProfitActive}",
                        style: TextStyle(
                          fontSize: 12,
                          color: colorApp.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const Dialog(
                          child: DialogSettingProfitChart(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.more_vert,
                        color: colorApp.primary,
                        size: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          AspectRatio(
            aspectRatio: 2.1,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: gradientColor.last,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((flSpot) {
                          return LineTooltipItem(
                            '',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: FormatUtility.currencyRp(
                                  (flSpot.y * 1000000).toInt(),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                            textAlign: TextAlign.center,
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: controller.profitChartSettings[0]['value'],
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    verticalInterval: 1,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: leftTitleWidgets,
                        reservedSize: 100,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: controller.profitChartSettings[1]['value'],
                    border: Border.all(color: const Color(0xff37434d)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: controller.profitMonthInYear
                          .asMap()
                          .map(
                            (index, value) {
                              return MapEntry(
                                index,
                                FlSpot(index.toDouble(), value / 1000000),
                              );
                            },
                          )
                          .values
                          .toList(),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: gradientColor,
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: controller.profitChartSettings[2]['value'],
                      ),
                      belowBarData: BarAreaData(
                        show: controller.profitChartSettings[3]['value'],
                        gradient: LinearGradient(
                          colors: gradientColor
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                  minX: 0,
                  minY: 0,
                  maxX: 11,
                  maxY: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        DateFormat.MMM().format(DateTime(2023, value.toInt() + 1)),
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      FormatUtility.currencyRp(value.toInt() * 1000000),
      style: const TextStyle(
        fontSize: 12,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class DialogSettingProfitChart extends StatelessWidget {
  const DialogSettingProfitChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardTabController>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: 'Settings',
      childern: controller.profitChartSettings
          .asMap()
          .map(
            (i, val) => MapEntry(
              i,
              CheckboxListTile(
                value: val['value'],
                onChanged: (bool? value) {
                  controller.setSettingProfitBar(index: i, value: value!);
                },
                title: Text(val['setting']),
              ),
            ),
          )
          .values
          .toList(),
      callbackClose: () => Navigator.pop(context),
    );
  }
}

class DialogYearPicker extends StatelessWidget {
  const DialogYearPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DashboardTabController>();

    return DialogUtils.layoutCustomDialog(
      dialogHeaderText: "Select Year",
      childern: [
        Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(
            20,
            (index) => InkWell(
              onTap: () {
                controller.changeYearProfitMonthYear(
                  DateTime.now().year - index,
                );

                controller.setProfitMonthInYear();
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  label: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      (DateTime.now().year - index).toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
      callbackClose: () => Navigator.pop(context),
    );
  }
}

// Best Seller Chart
class BestSellerCategoryChart extends StatelessWidget {
  final ColorApp colorApp;

  const BestSellerCategoryChart({
    required this.colorApp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardTabController>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorApp.canvas,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Best Seller Category",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: AspectRatio(
              aspectRatio: 1.22,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: true,
                  ),
                  sectionsSpace: 3,
                  centerSpaceRadius: 40,
                  sections: controller.bestSellerCategory
                      .asMap()
                      .map(
                        (key, value) {
                          final double percentage = value['total_sold'] *
                              controller.percentagePieChart;
                          return MapEntry(
                            key,
                            PieChartSectionData(
                              color: value['color'],
                              value: value['total_sold'],
                              title: '${percentage.toStringAsFixed(2)} %',
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      )
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            children: controller.bestSellerCategory
                .map(
                  (val) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: val['color'],
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        Text(
                          "${FormatUtility.capitalize(val['title_ctg'])} (${val['total_sold'].toInt()})",
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
