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
    //如果不存在就進行初始化
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    //如果不存在就進行初始化
    if (_db == null) {
      _db = await initializeDatabase();
    }
    return _db;
  }

  Future<Database> initializeDatabase() async {
    //設定DB檔案存放路徑
    Directory directory =
        await getApplicationDocumentsDirectory(); //用getApplicationDocumentsDirectory()取得APP的所在目錄路徑
    String path = directory.path + "task.db"; //如果日後要區分使用者，可用變數加在.db檔案前

    //開啟/建立指定DB
    Database taskDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return taskDatabase;
  }

  //建立DB
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        //建立table的指令
        'CREATE TABLE $taskTable ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTask TEXT, $columnDate TEXT, $columnTime TEXT, $columnStatus TEXT)');
  }

  //取得所有列表(map)
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.database;
    dynamic _result = db.rawQuery(
        'SELECT * FROM $taskTable order by $columnDate, $columnTime ASC');
    return _result;
  }

  //取得未完成列表(map)
  Future<List<Map<String, dynamic>>> getUnfinishedTaskMapList() async {
    Database db = await this.database;
    dynamic _result = db.rawQuery(
        'SELECT * FROM $taskTable where $columnStatus = "" order by $columnDate, $columnTime ASC');
    return _result;
  }

  //取得完成列表(map)
  Future<List<Map<String, dynamic>>> getFinishedTaskMapList() async {
    Database db = await this.database;
    dynamic _result = db.rawQuery(
        'SELECT * FROM $taskTable where $columnStatus = "finished" order by $columnDate, $columnTime ASC');
    return _result;
  }

  //更新列表
  Future<int> insertTask(DBDatas task) async {
    Database db = await this.database;
    dynamic _result = await db.insert(taskTable, task.toMap());
    return _result;
  }

  //修改列表
  Future<int> updateTask(DBDatas task) async {
    Database db = await this.database;
    dynamic _result = await db.update(taskTable, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.id]);
    return _result;
  }

  //刪除列表
  Future<int> deleteTask(int id) async {
    Database db = await this.database;
    int _result =
        await db.rawDelete('DELETE FROM $taskTable WHERE $columnId=$id');
    return _result;
  }

  //計算總數
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> _count =
        await db.rawQuery('SELECT COUNT (*) FROM $taskTable');
    int _result = Sqflite.firstIntValue(_count);
    return _result;
  }

  //取得列表
  Future<List<DBDatas>> getTaskList() async {
    List<Map<String, dynamic>> taskMapList =
        await getTaskMapList(); //透過getTaskMapList()取得資料

    List<DBDatas> taskList = List<DBDatas>();
    //利用for in將陣列中的資料加入taskList
    for (Map<String, dynamic> taskItem in taskMapList) {
      taskList.add(DBDatas.fromMapObject(taskItem));
    }
    return taskList;
  }

  //取得未完成列表
  Future<List<DBDatas>> getUnfinishedTaskList() async {
    List<Map<String, dynamic>> taskMapList =
        await getUnfinishedTaskMapList(); //透過getUnfinishedTaskMapList()取得資料

    List<DBDatas> taskList = List<DBDatas>();
    //利用for in將陣列中的資料加入taskList
    for (Map<String, dynamic> taskItem in taskMapList) {
      taskList.add(DBDatas.fromMapObject(taskItem));
    }
    return taskList;
  }

  //取得完成列表
  Future<List<DBDatas>> getFinishedTaskList() async {
    List<Map<String, dynamic>> taskMapList =
        await getFinishedTaskMapList(); //透過getFinishedTaskMapList()取得資料

    List<DBDatas> taskList = List<DBDatas>();
    //利用for in將陣列中的資料加入taskList
    for (Map<String, dynamic> taskItem in taskMapList) {
      taskList.add(DBDatas.fromMapObject(taskItem));
    }
    return taskList;
  }
}
