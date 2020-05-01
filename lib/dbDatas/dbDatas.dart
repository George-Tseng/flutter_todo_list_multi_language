class DBDatas {
  int id; //id
  String task; //項目
  String date; //日期
  String time; //時間
  String status; //狀態

  DBDatas(this.id, this.task, this.date, this.time, this.status);

  //將資料轉成map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['task'] = task;
    map['date'] = date;
    map['time'] = time;
    map['status'] = status;
    return map;
  }

  //將資料從map轉回來
  DBDatas.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.task = map['task'];
    this.date = map['date'];
    this.time = map['time'];
    this.status = map['status'];
  }
}
