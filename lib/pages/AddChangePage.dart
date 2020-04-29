import 'package:flutter/material.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/modules/localizations.dart';
import 'package:flutter_todo_multi_lan/modules/tools.dart';

class AddChangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddChangePage();
  }
}

class _AddChangePage extends State<AddChangePage> {
  final TextEditingController _controller01 = TextEditingController();
  final TextEditingController _controller02 = TextEditingController();
  final TextEditingController _controller03 = TextEditingController();

  String transTime;

  bool btnSave = true;

  DateTime inputDate = DateTime.now();

  TimeOfDay inputTime;

  Tool myTool = Tool();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          maxLength: 50,
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
      title: _controller02.text == '' ? Text(MyAppLocalizations.of(context).pickDate) : Text(_controller02.text),
      trailing: IconButton(
        icon: Icon(Icons.calendar_today), 
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
      title: _controller03.text == '' ? Text(MyAppLocalizations.of(context).selectTime) : Text(transTime),
      subtitle: Text(""),
      trailing: IconButton(
        icon: Icon(Icons.alarm_on), 
        onPressed: () async {
          inputTime = TimeOfDay.now();  
          String keyTime = await myTool.showTime(context, inputTime); 
          setState(() {
            _controller03.text = keyTime;
            if(int.parse(keyTime.split(':').first) > 11) 
              transTime = 'PM '+(int.parse(keyTime.split(':').first) - 12).toString() + ':' + keyTime.split(':').last;
            else
              transTime = 'AM '+int.parse(keyTime.split(':').first).toString() + ':' + keyTime.split(':').last;
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
          onPressed: (){
            if(btnSave) {
              //btnSave = false;
              _save();
            }
          }, 
          child: Text(MyAppLocalizations.of(context).save, style: TextStyle(color: Colors.white))),
      ),
    );
  }

  void _save() async {
    if(inputCheckAdd() == true) {
      print('成功');
    }
    else {
      print('失敗');
    }
  }

  bool inputCheckAdd() {
    int _result = 0;
    if(_controller01.text == '')
      _result = -1;
    if(_controller02.text == '') {
      if(_result == 0) 
        _result = -2;
    }
    if(_controller03.text == '') {
      if(_result == 0) 
        _result = -3;
    }

    if(_result == 0) 
      return true;
    if(_result == -1) {
      Tool.showErrorMessage(context, MyAppLocalizations.of(context).errorMessage01, MyAppLocalizations.of(context).errorFound, MyAppLocalizations.of(context).yes);
      return false;
    }
  }
}
