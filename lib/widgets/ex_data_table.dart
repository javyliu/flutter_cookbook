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

///this class is for the paginatedDatatable
class DtsData extends DataTableSource {
  List<SampleData> items;
  int _selectCount = 0;
  bool _isRowCountApproximate = false;

  DtsData() {
    loadData();
  }
  Future<void> loadData() async {
    log("---Load Data");

    items = [];
    String jsonStr = await rootBundle.loadString("assets/chart_data.json");
    final res = jsonDecode(jsonStr);
    for (var item in res) {
      items.add(SampleData.fromJson(item));
    }
    log("load data notify");

    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    if (index >= items.length || index < 0) throw FlutterError("no data");
    final SampleData sd = items[index];
    return DataRow.byIndex(
      cells: [
        DataCell(Text(sd.x)),
        DataCell(Text(sd.y1.toString())),
        DataCell(Text(sd.y2.toString())),
        DataCell(Text(sd.y1.toString())),
        DataCell(Text(sd.y2.toString())),
      ],
      selected: sd.selected,
      index: index,
      onSelectChanged: (value) {
        log("--on select changed ${value.toString()}");
        if (sd.selected != value) {
          _selectCount = _selectCount += value ? 1 : -1;
          sd.selected = value;
          notifyListeners();
        }
      },
    );
  }

  @override
  bool get isRowCountApproximate => _isRowCountApproximate;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => _selectCount;

  int rowsPerPage = 5;

  void sort<T>(Comparable<T> getField(SampleData sampleData), bool b) {
    items.sort((SampleData s1, SampleData s2) {
      if (!b) {
        //两个项进行交换
        final SampleData temp = s1;
        s1 = s2;
        s2 = temp;
      }
      final Comparable<T> s1Value = getField(s1);
      final Comparable<T> s2Value = getField(s2);
      return Comparable.compare(s1Value, s2Value);
    });
    notifyListeners();
  }
}

class WfulData extends StatefulWidget {
  final DtsData data = DtsData();
  @override
  _WfulDataState createState() => _WfulDataState();
}

class _WfulDataState extends State<WfulData> {
  int sortColumnIndex = 0;
  bool sortAscending = false;
  @override
  Widget build(BuildContext context) {
    log("----paginated data table build");

    return PaginatedDataTable(
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
      rowsPerPage: widget.data.rowsPerPage,
      availableRowsPerPage: [5, 10, 15],
      onRowsPerPageChanged: (value) {
        log("----rows per page is: $value");
        setState(() {
          widget.data.rowsPerPage = value;
        });
      },
      columns: [
        DataColumn(
          label: Text("x", style: Theme.of(context).textTheme.headline5),
          onSort: (columnIndex, ascending) {
            _sort((sd) => sd.x, columnIndex, ascending);
          },
        ),
        DataColumn(
          label: Text("y", style: Theme.of(context).textTheme.headline5),
          numeric: true,
          onSort: (columnIndex, ascending) => _sort((sd) => sd.y1, columnIndex, ascending),
        ),
        DataColumn(
          label: Text("y2", style: Theme.of(context).textTheme.headline5),
          numeric: true,
          onSort: (columnIndex, ascending) => _sort((sd) => sd.y2, columnIndex, ascending),
        ),
        DataColumn(label: Text("y3", style: Theme.of(context).textTheme.headline5), numeric: true),
        DataColumn(label: Text("y4", style: Theme.of(context).textTheme.headline5), numeric: true),
      ],
      source: widget.data,
      header: Text("分页表格"),
    );
  }

  void _sort<T>(Comparable<T> getField(SampleData sd), int index, bool ascending) {
    widget.data.sort(getField, ascending);
    setState(() {
      sortColumnIndex = index;
      sortAscending = ascending;
    });
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
            // child: WlTable(),
            child: WfulData(),
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
