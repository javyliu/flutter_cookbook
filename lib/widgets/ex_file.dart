import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ExFile extends StatefulWidget {
  static String name = "文件读写测试";
  final CounterStorage storage;

  const ExFile({Key key, @required this.storage}) : super(key: key);

  @override
  _ExFileState createState() => _ExFileState();
}

class _ExFileState extends State<ExFile> {
  int _counter;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
        log("----current counter is: $_counter");
      });
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    widget.storage.writeInt(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ExFile.name),
      ),
      body: Center(
        child: Text("Button tapped $_counter time${_counter == 1 ? '' : 's'}", style: Theme.of(context).textTheme.headline4),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterStorage {
  Directory dir;
  Future<String> get _localPath async {
    // dir ??= await getApplicationDocumentsDirectory();
    if (dir == null) {
      dir = await getApplicationDocumentsDirectory();
      log("path: $dir");
    }

    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      log("---no counter string");

      return 0;
    }
  }

  Future<File> writeInt(int counter) async {
    final file = await _localFile;
    return file.writeAsString("$counter");
  }
}
