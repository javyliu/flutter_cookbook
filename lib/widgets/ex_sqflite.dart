import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/db_dog.dart';

class ExSqflite extends StatelessWidget {
  static String name = "本地数据库测试";

  ExSqflite() {
    log("--ex sqflite 构造函数");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ExSqflite.name),
      ),
      body: Center(
        child: FutureBuilder<Widget>(
          future: getDogs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<Widget> getDogs() async {
    var db = await DbDog.dbWorker.database;
    var res = await db.query(DbDog.dbWorker.tableName);
    return Text(res.toString());
  }
}
