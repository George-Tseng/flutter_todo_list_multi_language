import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/pages/MainPage.dart';

class Tool {

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String hour;
  String minute;

  static void showMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false, //獨占性，只允許使用者按下對話框中的按鈕才能繼續操作
        builder: (context) {
          return AlertDialog(
            title: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('操作完成',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.check_circle_outline)
                    ],
                  ),
                ],
              ),
            ),
            content: Text(message,
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //返回首頁
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
                },
                child:
                    Text("確定", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  static void showErrorMessage(BuildContext context, String message, String errorFound, String yes) {
    showDialog(
        context: context,
        barrierDismissible: false, //獨占性，只允許使用者按下對話框中的按鈕才能繼續操作
        builder: (context) {
          return AlertDialog(
            title: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(errorFound,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.error_outline)
                    ],
                  ),
                ],
              ),
            ),
            content: Text(message,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    Text(yes, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  Future<String> showDate(BuildContext context, DateTime inputDate) async {
    //選中的為pickedDate
    final DateTime pickedDate = await showDatePicker(
        context: context,
        //初始日(從哪天做起點)
        initialDate: DateTime.now(),
        //日曆設定的起點
        firstDate: DateTime(2001),
        //日曆設定的終點
        lastDate: DateTime(2101));

    //如果選中的不為空(代表有選)且跟現有的不同，才需要更新
    if (pickedDate != null && pickedDate != inputDate) {
      inputDate = pickedDate;
      return '${dateFormat.format(inputDate)}';
    }
    return '';
  }

  Future<String> showTime(BuildContext context, TimeOfDay inputTime) async {

    //選中的為pickedDate
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        //初始時間(從哪個時間點做起點)
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
        return MediaQuery(
          //是否啟用「總是使用24小時制」
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    //如果選中的不為空(代表有選)且跟現有的不同，才需要更新
    if (pickedTime != null && pickedTime != inputTime) {
      inputTime = pickedTime;
      //字串處理
      if(inputTime.hour < 10 && inputTime.hour >= 0)
        hour = '0'+inputTime.hour.toString();
      else
        hour = inputTime.hour.toString();
      
      if(inputTime.minute < 10 && inputTime.minute >= 0)
        minute = '0'+inputTime.minute.toString();
      else
        minute = inputTime.minute.toString();
      
      return hour + ':' + minute;
    }
    return '';
  }
}