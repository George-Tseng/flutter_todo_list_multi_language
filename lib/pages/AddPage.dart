import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/modules/localizations.dart';
import 'package:flutter_todo_multi_lan/modules/tools.dart';
import 'package:flutter_todo_multi_lan/dbDatas/dbDatas.dart';
import 'package:flutter_todo_multi_lan/dbDatas/dbHelper.dart';
import 'MainPage.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final TextEditingController _controller01 = TextEditingController();
  final TextEditingController _controller02 = TextEditingController();
  final TextEditingController _controller03 = TextEditingController();
  final TextEditingController _controller04 = TextEditingController();
  final TextEditingController _controller05 = TextEditingController();

  final FocusNode node01 = FocusNode();
  final FocusNode node02 = FocusNode();
  final FocusNode node03 = FocusNode();

  final key = GlobalKey<ScaffoldState>();

  //顯示給使用者看的時間格式
  String transTime;

  //主鍵(產生規則暫定為日期格式yyyyMMddHHmmss共14碼)
  int id;

  bool btnSave = true;

  DBDatas insertedData;

  DateTime inputDate = DateTime.now();
  DateTime nowTime;

  TimeOfDay inputTime;

  DateFormat idFormat = DateFormat('yyyyMMddHHmmss');

  Tool myTool = Tool();

  DBHelper helper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(MyAppLocalizations.of(context).newTitle,
            style: TextStyle(fontSize: 20)),
        centerTitle: true, //文字是否置中
        leading: IconButton(
            icon: Icon(Icons.close),
            color: Colors.white,
            iconSize: 20.0,
            onPressed: () {
              //返回上一頁
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _buildTask(_controller01, node01, node02),
            _buildImportance(_controller04, node02, node03),
            _buildCatgory(_controller05, node03),
            _buildDatePicker(),
            _buildTimePicker(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTask(TextEditingController controller, FocusNode node, FocusNode nodeNext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: TextField(
          controller: controller,
          focusNode: node,
          maxLength: 255, //可根據自己的定義調整
          decoration: InputDecoration(
            labelText: MyAppLocalizations.of(context).topic, //位於輸入框時時會自動縮小到左上角
            hintText: MyAppLocalizations.of(context).topicHint, //輸入提示
            counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
          ),
          //按下確認後才準備跳至下個欄位
          onSubmitted: (value) {
            if (node != nodeNext) {
              node.unfocus();
              FocusScope.of(context).requestFocus(nodeNext);
            }
          },
        ),
      ),
    );
  }

  Widget _buildImportance(TextEditingController controller, FocusNode node, FocusNode nodeNext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: TextField(
          controller: controller,
          focusNode: node,
          maxLength: 2, //可根據自己的定義調整
          keyboardType: TextInputType.number, //出現數字鍵盤供使用者輸入
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly], //僅限輸入純數字
          decoration: InputDecoration(
            labelText: MyAppLocalizations.of(context).importance, //位於輸入框時時會自動縮小到左上角
            hintText: MyAppLocalizations.of(context).importanceHint, //輸入提示
            counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
          ),
          //按下確認後才準備跳至下個欄位
          onSubmitted: (value) {
            if (node != nodeNext) {
              node.unfocus();
              FocusScope.of(context).requestFocus(nodeNext);
            }
          },
        ),
      ),
    );
  }

  Widget _buildCatgory(TextEditingController controller, FocusNode node) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: TextField(
          controller: controller,
          focusNode: node,
          maxLength: 50, //可根據自己的定義調整
          decoration: InputDecoration(
            labelText: MyAppLocalizations.of(context).catgory, //位於輸入框時時會自動縮小到左上角
            hintText: MyAppLocalizations.of(context).catgoryHint, //輸入提示
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
                btnSave = false;
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
    if (inputCheck() == true) {
      //產生id
      nowTime = DateTime.now();
      id = int.parse('${idFormat.format(nowTime)}');
      print('id = ' + id.toString());

      //設定要新增的整組資料
      insertedData = DBDatas(
          id, int.parse(_controller04.text), _controller01.text, _controller02.text, _controller03.text, _controller05.text, '');

      _result = await helper.insertTask(insertedData);
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
    else
      btnSave = true;
  }

  bool inputCheck() {
    int _result = 0;
    if (_controller01.text == '') _result = -1;
    if (_controller04.text == '') {
      if (_result == 0) _result = -4;
    }
    else if(int.parse(_controller04.text) > 10) {
      if (_result == 0) _result = -5;
    }
    if (_controller05.text == '') {
      setState(() {
        _controller05.text = MyAppLocalizations.of(context).none;
      });
    }
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
    if (_result == -4) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).errorMessage05, 'Error');
      return false;
    }
    if (_result == -5) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).errorMessage06, 'Error');
      return false;
    }
    return true;
  }
}
