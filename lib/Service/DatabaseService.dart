import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/SQLModel.dart';

class DatabaseHelper {
  static Database _database;

  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    var databaseFolder = await getDatabasesPath();
    String path = join(databaseFolder, "Values.db");
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    return db.execute("CREATE TABLE DataModel(id INTEGER PRIMARY KEY, name TEXT, luxValue TEXT,date TEXT)");
  }

  Future<List<DataModel>> getData() async {
    var databaseClient = await db;
    var result = await databaseClient.query("DataModel");
    return result.map((data) => DataModel.fromMap(data)).toList();
  }

  Future<void> insertData(DataModel dataModel) async {
    var dbClient = await db;
    return await dbClient.insert("DataModel", dataModel.toMap());
  }

  Future<void> removeData(int id) async {
    var dbClient = await db;
    return dbClient.delete("DataModel", where: "id=?", whereArgs: [id]);
  }
}
