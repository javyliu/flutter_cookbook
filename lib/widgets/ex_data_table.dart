import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return "$x, $y1, $y2, $selected";
  }
}

class ProData extends ChangeNotifier {
  ///实例变量必须在方法中实例化，不能直接指定
  List<SampleData> items;
  Future<List<SampleData>> loadData() async {
    log("---Load Data");

    items = [];
    String jsonStr = await rootBundle.loadString("assets/chart_data.json");
    final res = jsonDecode(jsonStr);
    for (var item in res) {
      items.add(SampleData.fromJson(item));
    }
    return items;
  }

  void setSelected(SampleData sd, bool value) {
    sd.selected = value;
    notifyListeners();
  }
}

class ExDataTable extends StatelessWidget {
  static String name = "数据表使用";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(ExDataTable.name),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: WlTable(),
          ),
        ),
      ),
    );
  }
}

///是否可以用provider来实现状态改变？,没有实现，不知怎么弄,
class WlTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProData pd = Provider.of<ProData>(context, listen: false);
    return FutureBuilder(
      future: pd.loadData(),
      builder: (context, snapshot) {
        log("----future builder");

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return DataTable(
              columns: [
                DataColumn(label: Text("x", style: Theme.of(context).textTheme.headline3)),
                DataColumn(label: Text("y1", style: Theme.of(context).textTheme.headline3), numeric: true),
                DataColumn(label: Text("y2", style: Theme.of(context).textTheme.headline3), numeric: true),
              ],
              rows: List.generate(snapshot.data.length, (index) {
                SampleData sd = context.select<ProData, SampleData>((value) => pd.items[index]);

                return DataRow(
                  cells: [
                    DataCell(Text(sd.x)),
                    DataCell(Text("${sd.y1}")),
                    DataCell(Text("${sd.y2}")),
                  ],
                  onSelectChanged: (value) {
                    log("----before event: ${sd.toString()}");
                    pd.setSelected(sd, value);
                    log("----after event: ${sd.toString()}");
                  },
                  selected: sd.selected,
                );
              }),
            );
          } else {
            return Text("no data");
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

///使用有状态组件来刷新datatable，经测试没有问题
class Wtable extends StatefulWidget {
  @override
  _WtableState createState() => _WtableState();
}

class _WtableState extends State<Wtable> {
  Future<List<SampleData>> items;
  @override
  void initState() {
    items = loadData();
    super.initState();
  }

  Future<List<SampleData>> loadData() async {
    log("---Load Data");
    List<SampleData> _data = [];
    String jsonStr = await rootBundle.loadString("assets/chart_data.json");
    final res = jsonDecode(jsonStr);
    for (var item in res) {
      _data.add(SampleData.fromJson(item));
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        log("----future builder");

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return DataTable(
              columns: [
                DataColumn(label: Text("x", style: Theme.of(context).textTheme.headline3)),
                DataColumn(label: Text("y1", style: Theme.of(context).textTheme.headline3), numeric: true),
                DataColumn(label: Text("y2", style: Theme.of(context).textTheme.headline3), numeric: true),
              ],
              rows: List.generate(snapshot.data.length, (index) {
                SampleData sd = snapshot.data[index];
                return DataRow(
                  cells: [
                    DataCell(Text(sd.x)),
                    DataCell(Text("${sd.y1}")),
                    DataCell(Text("${sd.y2}")),
                  ],
                  onSelectChanged: (value) {
                    log("----before event: ${sd.toString()}");

                    setState(() {
                      sd.selected = value;
                    });
                    log("----after event: ${sd.toString()}");
                  },
                  selected: sd.selected,
                );
              }),
            );
          } else {
            return Text("no data");
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
