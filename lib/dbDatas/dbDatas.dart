class DBDatas {
  int _id; //id
  String _task; //項目
  String _date; //日期
  String _time; //時間
  String _status; //狀態

  DBDatas(this._id, this._task, this._date, this._time, this._status);

  //getter
  int get id => _id;
  String get task => _task;
  String get date => _date;
  String get time => _time;
  String get status => _status;
  //getter

  //setter
  set id(int newId) => this._id = newId;
  set task(String newTask) {
    if (newTask.length <= 255) {
      this._task = newTask;
    }
  }

  set date(String newDate) => this._date = newDate;
  set time(String newTime) => this._time = newTime;
  set status(String newStatus) => this._status = newStatus;
  //setter

  //將資料轉成map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['task'] = _task;
    map['date'] = _date;
    map['time'] = _time;
    map['status'] = _status;
    return map;
  }

  //將資料從map轉回來
  DBDatas.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._task = map['task'];
    this._date = map['date'];
    this._time = map['time'];
    this._status = map['status'];
  }
}
