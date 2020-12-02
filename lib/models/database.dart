import 'dart:developer';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbBase {
  Database _db;
  final String tableName;
  final String createSql;

  DbBase(this.tableName, this.createSql);
  external factory DbBase.fromJson(Map<String, dynamic> json);

  Future<Database> get database async => initDb();
  Future<Database> initDb() async {
    _db ??= await openDatabase(
      join((await getApplicationDocumentsDirectory()).path, '$tableName.db'),
      onCreate: (db, version) async {
        log("--openDatabase onCreate");
        await db.execute(createSql);
      },
      version: 1,
    );

    return _db;
  }
}
