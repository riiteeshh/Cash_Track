import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget buildBarChart(List data) {
  List<ColumnSeries<_BarData, String>> barSeries = [];

  String xAxis = 'Date';
  String yAxis = 'Amount';
  try {
    barSeries.add(
      ColumnSeries<_BarData, String>(
        enableTooltip: true, // enable tooltip
        dataSource: List.generate(
          data.length,
          (index) => _BarData(
              label: data[index]['date'].toString(),
              value: data[index]['totalAmount']),
        ),
        xValueMapper: (_BarData data, _) => data.label,
        yValueMapper: (_BarData data, _) => data.value,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          angle: -60,
          overflowMode: OverflowMode.trim,
          textStyle: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w500),
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SfCartesianChart(
        title: ChartTitle(
            textStyle: TextStyle(fontSize: 10.h, fontWeight: FontWeight.w600),
            alignment: ChartAlignment.center),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: xAxis),
          labelPosition: ChartDataLabelPosition.outside,
          labelRotation: 60,
          labelStyle:
              GoogleFonts.poppins(fontSize: 10.h, fontWeight: FontWeight.w600),
          labelPlacement: LabelPlacement.betweenTicks,
          // maximumLabels: data.length,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: yAxis),
        ),

        series: barSeries,

        legend: const Legend(
            overflowMode: LegendItemOverflowMode.scroll,
            shouldAlwaysShowScrollbar: true),
        tooltipBehavior: TooltipBehavior(
            textStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 9.h,
                fontWeight: FontWeight.w500),
            enable: true,
            format: '$xAxis: point.x\n$yAxis: point.y',
            header: ''), // enable tooltip
      ),
    );
  } catch (e) {
    return Wrap();
  }
}

class _BarData {
  final label;
  final num value;

  _BarData({required this.label, required this.value});
}
