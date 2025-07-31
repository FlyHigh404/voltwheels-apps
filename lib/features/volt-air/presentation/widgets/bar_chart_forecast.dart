import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';
import 'package:voltwheels_mobile/core/utils/date_utils.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/controllers/volt_air_controller.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/utils/aqi_converter.dart';
import 'package:voltwheels_mobile/features/volt-air/presentation/utils/get_aqi_color.dart';

class BarChartForecast extends GetView<VoltAirController> {
  const BarChartForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups:
              controller.forecastAirQualityResponse.value.list.where((e) {
            var hM = convertTimestampToHHMM(e.dt);

            return labelHours.contains(hM);
          }).map((e) {
            var component = e.components;
            AQICalculator aqiCalculator = AQICalculator(
              pm25: component.pm2_5,
              pm10: component.pm10,
              co: component.co,
              so2: component.so2,
              no2: component.no,
            );

            var aqiIndex = aqiCalculator.calculateOverallAQI();

            return BarChartGroupData(
              x: e.dt,
              barRods: [
                BarChartRodData(
                  toY: aqiIndex,
                  color: getAirQualityInfo(aqiIndex.toInt()).color,
                  width: 4,
                ),
              ],
            );
          }).toList(),
          gridData: const FlGridData(
            show: false,
          ),
          alignment: BarChartAlignment.spaceAround,
          maxY: 200,
          minY: 0,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppPallete.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = const TextStyle(
      color: AppPallete.blackGrayColor,
      fontWeight: FontWeight.w600,
      fontSize: 8,
    );

    var hM = convertTimestampToHHMM(value.toInt());

    String text;
    switch (hM) {
      case '01:00':
        text = '01:00';
        break;
      case '03:00':
        text = '03:00';
        break;
      case '06:00':
        text = '06:00';
        break;
      case '09:00':
        text = '09:00';
        break;
      case '12:00':
        text = '12:00';
        break;
      case '15:00':
        text = '15:00';
        break;
      case '18:00':
        text = '18:00';
        break;
      case '21:00':
        text = '21:00';
        break;
      case '23:00':
        text = '23:00';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: 50,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppPallete.blackGrayColor,
                      fontWeight: FontWeight.w600),
                );
              }),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppPallete.gradientColor,
          AppPallete.gradient2Color,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 190,
              color: AppPallete.veryDangerAir,
              width: 4,
            ),
          ],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: BarChartForecast(),
    );
  }
}
