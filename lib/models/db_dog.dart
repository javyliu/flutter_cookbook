import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'dog.dart';

class DbDog extends DbBase {
  ///单例

  DbDog._() : super("dogs", "create table dogs (id integer primary key, name text, age integer) ");
  static final DbDog dbWorker = DbDog._();

  Future<void> save(Dog dog) async {
    log("--create---");

    final db = await database;
    await db.insert(tableName, dog.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Dog> find(int id) async {
    final db = await database;
    var res = await db.query(tableName, where: "id=?", whereArgs: [id]);
    return Dog.fromJson(res.first);
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> update(Dog dog) async {
    final db = await database;
    await db.update(
      tableName,
      dog.toJson(),
      where: "id=?",
      whereArgs: [dog.id],
    );
  }
}
