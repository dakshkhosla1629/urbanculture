import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urbanculture/model/chartmodel.dart';
import 'package:urbanculture/provider/skincareprovider.dart';
import 'package:urbanculture/utills/comman_widgets.dart';

class linechart extends StatefulWidget {
  const linechart({super.key});

  @override
  State<linechart> createState() => _linechartState();
}

class _linechartState extends State<linechart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<SkincareProvider>(
            builder: (context, value, child) {
              return SfCartesianChart(
                margin: EdgeInsets.all(0),
                tooltipBehavior: TooltipBehavior(enable: true),
                backgroundColor: CommanWidgets.backgroundcolor,
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  labelAlignment: LabelAlignment.start,
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                  labelStyle: GoogleFonts.epilogue(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: CommanWidgets.textsubheadingcolor,
                  ),
                ),
                primaryYAxis: const NumericAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  isVisible: false,
                ),
                series: <CartesianSeries<ChartData, String>>[
                  LineSeries<ChartData, String>(
                    dataSource: value.getChartData(),
                    xValueMapper: (ChartData data, _) => data.timePeriod,
                    yValueMapper: (ChartData data, _) => data.streaks,
                    name: 'Streaks',
                    color: CommanWidgets.textsubheadingcolor,
                    width: 3,
                    markerSettings: const MarkerSettings(isVisible: false),
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: false),
                    enableTooltip: true,
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "Keep it up! You're on a roll.",
              style: GoogleFonts.epilogue(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: CommanWidgets.textheadingcolor,
              ),
            ),
          ),
          CommanWidgets.mybutton(context),
        ],
      ),
    );
  }
}
