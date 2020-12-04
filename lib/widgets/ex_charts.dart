import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

///json 数据对像
class SampleData {
  dynamic x;
  num y1;
  num y2;
  SampleData(this.x, this.y1, this.y2);

  factory SampleData.fromJson(Map<dynamic, dynamic> data) {
    return SampleData(data['x'], data['y1'], data['y2']);
  }
}

class ExCharts extends StatefulWidget {
  static String name = '从json数据渲染数据表';

  @override
  _ExChartsState createState() => _ExChartsState();
}

class _ExChartsState extends State<ExCharts> {
  List<SampleData> chartData = [];

  Future<String> _loadDataFromAssets() async {
    return await rootBundle.loadString('assets/chart_data.json');
  }

  Future loadData() async {
    String jsonStr = await _loadDataFromAssets();
    final res = jsonDecode(jsonStr);
    setState(() {
      for (var item in res) {
        chartData.add(SampleData.fromJson(item));
      }
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  ///线型图
  List<LineSeries<SampleData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<SampleData, DateTime>>[
      LineSeries(
        dataSource: chartData,
        xValueMapper: (datum, index) => DateTime.parse(datum.x),
        yValueMapper: (datum, index) => datum.y1,
        name: "产品A",
      ),
      LineSeries(
        dataSource: chartData,
        xValueMapper: (datum, index) => DateTime.parse(datum.x),
        yValueMapper: (datum, index) => datum.y2,
        pointColorMapper: (datum, index) => Color.fromRGBO(0, 189, 174, 1),
        name: "产品B",
        color: Color.fromRGBO(0, 189, 174, 1),
      ),
    ];
  }

  ///柱型图
  List<ColumnSeries<SampleData, String>> _getRoundedColumnSeries() {
    final List<SampleData> data = <SampleData>[
      SampleData('Chicago', 5498, 0),
      SampleData('Tokyo', 6993, 0),
      SampleData('Atlanta', 5083, 0),
      SampleData('New York', 8683, 0),
      SampleData('Boston', 4497, 0),
    ];

    return <ColumnSeries<SampleData, String>>[
      ColumnSeries<SampleData, String>(
        width: 0.8,
        dataSource: data,
        dataLabelSettings: DataLabelSettings(isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        xValueMapper: (datum, index) => datum.x,
        yValueMapper: (datum, index) => datum.y1,
        color: Colors.red,
        name: "柱形图",
        // borderColor: Colors.red,
        // borderWidth: 1,

        // borderRadius: BorderRadius.circular(10),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ExCharts.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCartesianChart(
              key: GlobalKey(),
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: "产品对比数据"),
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                position: LegendPosition.top,
              ),
              primaryXAxis: DateTimeAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                intervalType: DateTimeIntervalType.years,
                dateFormat: DateFormat.y(),
                name: "Years",
                majorGridLines: MajorGridLines(width: 0),
                // axisLine: AxisLine(width: 1, color: Colors.red),
              ),
              primaryYAxis: NumericAxis(
                rangePadding: ChartRangePadding.none,
                name: 'Price',
                minimum: 70,
                maximum: 110,
                interval: 10,
                labelFormat: '{value}元',
                axisLine: AxisLine(width: 1),
                majorTickLines: MajorTickLines(color: Colors.transparent),
              ),
              series: _getDefaultLineSeries(),
              trackballBehavior: TrackballBehavior(
                enable: true,
                lineColor: Color.fromRGBO(0, 0, 0, 0.1),
                lineWidth: 1,
                activationMode: ActivationMode.singleTap,
                markerSettings: TrackballMarkerSettings(
                  borderWidth: 4,
                  height: 10,
                  width: 10,
                  markerVisibility: TrackballVisibilityMode.visible,
                ),
              ),
            ),

            Divider(),

            ///柱形图
            SfCartesianChart(
              borderWidth: 1,
              borderColor: Colors.black26,
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Land area of various cities(sq.km)\n今天收入金额：1000'),
              primaryXAxis: CategoryAxis(
                labelStyle: const TextStyle(color: Colors.white),
                axisLine: AxisLine(width: 1),
                labelPosition: ChartDataLabelPosition.inside,
                majorTickLines: MajorTickLines(width: 0),
                majorGridLines: MajorGridLines(width: 0),
                isVisible: true,
              ),
              primaryYAxis: NumericAxis(isVisible: true, minimum: 0, maximum: 9000),
              series: _getRoundedColumnSeries(),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                canShowMarker: false,
                format: 'point.x : point.y sq.km',
                header: 'test files',
              ),
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                position: LegendPosition.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
