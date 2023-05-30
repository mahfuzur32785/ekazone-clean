import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/constants.dart';
import '../model/overview_model.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({Key? key, required this.overViewModel}) : super(key: key);
  final DOverViewModel overViewModel;
  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  List<_ChartData> data = [];
  late TooltipBehavior _tooltip;

  List<String> months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',];

  @override
  void initState() {

    _tooltip = TooltipBehavior(enable: true);
    super.initState();
    Future.microtask(() {
      for(int i = 0; i < months.length; i++){
        data.add(_ChartData(months[i], widget.overViewModel.monthWiseViews[i].toDouble()));
      }
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withAlpha(1000),
      // elevation: 3,
      shadowColor: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(30),
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfCartesianChart(
                title: ChartTitle(
                    text: "Ads view",
                    alignment: ChartAlignment.near,
                    borderWidth: 10),
                borderColor: ashColor,
                isTransposed: false,
                primaryXAxis: CategoryAxis(borderColor: ashColor),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 1.0, interval: 0.1),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      dataSource: data,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      name: 'Gold',
                      color: redColor,
                      width: 0.3)
                ])
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
