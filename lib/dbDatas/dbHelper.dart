import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//引入其他頁面
import 'dbDatas.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _db;

  String taskTable = "task_table"; //table名稱
  String columnId = "id"; //欄位-id
  String columnTask = "task"; //欄位-task
  String columnDate = "date"; //欄位-date
  String columnTime = "time"; //欄位-time
  String columnStatus = "status"; //欄位-status

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_db == null) {
      _db = await initializeDatabase();
    }
    return _db;
  }

  Future<Database> initializeDatabase() async {
    //Get the directory path for both Android and iOS to store Database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "task.db";

    //Open/Create the database at the given path
    var taskDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return taskDatabase;
  }
}
