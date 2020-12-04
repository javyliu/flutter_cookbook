import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SampleData {
  dynamic x;
  num y1;
  num y2;
  SampleData(this.x, this.y1, this.y2);
  bool selected = false;

  factory SampleData.fromJson(Map<dynamic, dynamic> data) {
    return SampleData(data['x'], data['y1'], data['y2']);
  }

  @override
  String toString() {
    return "$x, $y1, $y2";
  }
}

class ExDataTable extends StatelessWidget {
  static String name = "数据表使用";

  // ExDataTable() {
  //   loadData();
  // }

  Future<List<SampleData>> loadData() async {
    final List<SampleData> _data = [];
    String jsonStr = await rootBundle.loadString("assets/chart_data.json");
    final res = jsonDecode(jsonStr);
    for (var item in res) {
      _data.add(SampleData.fromJson(item));
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ExDataTable.name),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<SampleData> _resData = snapshot.data;
                  return DataTable(
                      columns: [
                        DataColumn(label: Text("x", style: Theme.of(context).textTheme.headline3)),
                        DataColumn(label: Text("y1", style: Theme.of(context).textTheme.headline3), numeric: true),
                        DataColumn(label: Text("y2", style: Theme.of(context).textTheme.headline3), numeric: true),
                      ],
                      rows: List.generate(_resData.length, (index) {
                        SampleData sd = _resData[index];

                        return DataRow(
                          cells: [
                            DataCell(Text(sd.x)),
                            DataCell(Text("${sd.y1}")),
                            DataCell(Text("${sd.y2}")),
                          ],
                          onSelectChanged: (value) {
                            log("---${value.runtimeType}: $value -- ${_resData[index]}");
                          },
                        );
                      })
                      // rows: snapshot.data.map((SampleData ele) {
                      //   return DataRow(cells: [
                      //     DataCell(Text(ele.x)),
                      //     DataCell(Text(ele.y1.toString())),
                      //     DataCell(Text(ele.y2.toString())),
                      //   ]);
                      // }),
                      );
                } else {
                  return Text("no data");
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
