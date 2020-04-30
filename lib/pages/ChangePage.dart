import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/modules/localizations.dart';
import 'package:flutter_todo_multi_lan/modules/tools.dart';
import 'package:flutter_todo_multi_lan/dbDatas/dbDatas.dart';
import 'package:flutter_todo_multi_lan/dbDatas/dbHelper.dart';

class ChangePage extends StatefulWidget {
  //定義
  final DBDatas list;

  //建構
  ChangePage({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePage();
  }
}

class _ChangePage extends State<ChangePage> {
  final TextEditingController _controller01 = TextEditingController();
  final TextEditingController _controller02 = TextEditingController();
  final TextEditingController _controller03 = TextEditingController();

  final key = GlobalKey<ScaffoldState>();

  //顯示給使用者看的時間格式
  String transTime;
  String status;

  bool btnSave = true;

  DBDatas updatedData;
  DBDatas orginalData;

  DateTime inputDate = DateTime.now();

  TimeOfDay inputTime;

  DateFormat idFormat = DateFormat('yyyyMMddHHmmss');

  Tool myTool = Tool();

  DBHelper helper = DBHelper();

  @override
  void initState() {
    super.initState();
    setState(() {
      orginalData = widget.list;
      _controller01.text = orginalData.task;
      _controller02.text = orginalData.date;
      _controller03.text = orginalData.time;
      status = orginalData.status;
      transTime = myTool.timeTranstor(orginalData.time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(MyAppLocalizations.of(context).editTitle,
            style: TextStyle(fontSize: 20)),
        centerTitle: true, //文字是否置中
        leading: IconButton(
            icon: Icon(Icons.close),
            color: Colors.white,
            iconSize: 20.0,
            onPressed: () {
              //返回上一頁
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _buildTask(_controller01),
            _buildDatePicker(),
            _buildTimePicker(),
            _buildStatusChanger(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTask(TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: TextField(
          controller: controller,
          maxLength: 255, //可根據自己的定義調整
          decoration: InputDecoration(
            labelText: MyAppLocalizations.of(context).topic, //位於輸入框時時會自動縮小到左上角
            hintText: MyAppLocalizations.of(context).topicHint, //輸入提示
            counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      title: _controller02.text == ''
          ? Text(MyAppLocalizations.of(context).pickDate)
          : Text(_controller02.text),
      trailing: IconButton(
          icon: Icon(Icons.calendar_today),
          color: Colors.blue,
          onPressed: () async {
            String keyDate = await myTool.showDate(context, inputDate);
            setState(() {
              _controller02.text = keyDate;
            });
          }),
    );
  }

  Widget _buildTimePicker() {
    return ListTile(
      title: _controller03.text == ''
          ? Text(MyAppLocalizations.of(context).selectTime)
          : Text(transTime),
      subtitle: Text(""),
      trailing: IconButton(
          icon: Icon(Icons.access_time),
          color: Colors.blue,
          onPressed: () async {
            inputTime = TimeOfDay.now();
            String keyTime = await myTool.showTime(context, inputTime);
            setState(() {
              _controller03.text = keyTime;
              transTime = myTool.timeTranstor(keyTime);
            });
          }),
    );
  }

  Widget _buildStatusChanger() {
    return ListTile(
      title: status == ''
          ? Text(MyAppLocalizations.of(context).unfinished)
          : Text(MyAppLocalizations.of(context).finished),
      subtitle: Text(""),
      trailing: status == ''
          ? IconButton(
              icon: Icon(Icons.check),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  status = 'finished';
                });
              },
            )
          : IconButton(
              icon: Icon(Icons.clear),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  status = '';
                });
              },
            ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: FlatButton(
            //顏色
            color: Colors.blue,
            //白字
            colorBrightness: Brightness.light,
            //圓角
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () {
              if (btnSave) {
                //btnSave = false;
                _save();
              }
            },
            child: Text(MyAppLocalizations.of(context).save,
                style: TextStyle(color: Colors.white))),
      ),
    );
  }

  void _save() async {
    int _result;
    if (inputCheck() == true && isChanged() == true) {
      //設定要修改的整組資料
      updatedData = DBDatas(orginalData.id, _controller01.text,
          _controller02.text, _controller03.text, status);

      _result = await helper.updateTask(updatedData);
      //如果成功，_result會回傳一個等於id的值
      if (_result != 0)
        //成功
        Tool.showMessage(
            context,
            MyAppLocalizations.of(context).successMessage01,
            MyAppLocalizations.of(context).success,
            MyAppLocalizations.of(context).yes);
      else
        //失敗
        Tool.showErrorMessage(
            context,
            MyAppLocalizations.of(context).errorMessage00,
            MyAppLocalizations.of(context).errorFound,
            MyAppLocalizations.of(context).yes);
    }
  }

  bool inputCheck() {
    int _result = 0;
    if (_controller01.text == '') _result = -1;
    if (_controller02.text == '') {
      if (_result == 0) _result = -2;
    }
    if (_controller03.text == '') {
      if (_result == 0) _result = -3;
    }

    if (_result == -1) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).errorMessage01, 'Error');
      return false;
    }
    if (_result == -2) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).errorMessage02, 'Error');
      return false;
    }
    if (_result == -3) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).errorMessage03, 'Error');
      return false;
    }
    return true;
  }

  bool isChanged() {
    if (_controller01.text.compareTo(orginalData.task) == 0 &&
        _controller02.text.compareTo(orginalData.date) == 0 &&
        _controller03.text.compareTo(orginalData.time) == 0 &&
        status.compareTo(orginalData.status) == 0) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).errorMessage04, 'Error');
      return false;
    }
    return true;
  }
}
