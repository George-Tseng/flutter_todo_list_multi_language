import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/pages/MainPage.dart';

class Tool {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat timeFormat = DateFormat('HH:mm');
  String hour;
  String minute;

  static void showMessage(
      BuildContext context, String message, String success, String yes) {
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
                      Text(success,
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
                child: Text(yes, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  static void showErrorMessage(
      BuildContext context, String message, String errorFound, String yes) {
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
                  //Navigator.of(context).pop()這個寫法有遇到短暫黑屏過，所以還是用下面這個好
                  Navigator.pop(context);
                },
                child: Text(yes, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  static void showCheckMessage(BuildContext context, String warning,
      String message, String yes, String no, Function func) {
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
                      Text(warning,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.error_outline)
                    ],
                  ),
                ],
              ),
            ),
            content: Text(message,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //如果帶入的程式不為空才執行
                  if (func != null) func();
                  //Navigator.of(context).pop()這個寫法有遇到短暫黑屏過，所以還是用下面這個好
                  Navigator.pop(context);
                },
                child: Text(yes, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: () {
                  //Navigator.of(context).pop()這個寫法有遇到短暫黑屏過，所以還是用下面這個好
                  Navigator.pop(context);
                },
                child: Text(no, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  showSearchModeMessage(BuildContext context, String notice, String key, String message, String message1, String message2, String message3, String no) {
    //1.根據標題搜尋、2.根據日期搜尋、(3.根據重要性搜尋)
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
                      Text(notice,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.error_outline)
                    ],
                  ),
                ],
              ),
            ),
            content: Text(message + (key == '1' ? message1 : key == '2' ? message2 : message3),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  key = '1';
                  Navigator.pop(context);
                  return key;
                }, 
                child: Text(message1, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: (){
                  key = '2';
                  Navigator.pop(context);
                  return key;
                }, 
                child: Text(message2, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: (){
                  key = '3';
                  Navigator.pop(context);
                  return key;
                }, 
                child: Text(message3, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                onPressed: () {
                  //返回首頁
                  Navigator.pop(context);
                },
                child: Text(no, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  static void showSackerMessageBar(dynamic key, String message, String status) {
    final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(
              color: status == 'Error'
                  ? Colors.red
                  : status == 'Notice' ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold)),
      backgroundColor: status == 'Error'
          ? Colors.black
          : status == 'Notice' ? Colors.orange : Colors.blue,
      //持續時間
      duration: Duration(seconds: 1, milliseconds: 500),
    );
    key.currentState.showSnackBar(snackBar);
  }

  bool timeDifference(DateTime nowTime, String date, String time) {
    nowTime = DateTime.now();
    if (nowTime.isAfter(DateTime.parse(date + ' ' + time)) == true)
      return true;
    else
      return false;
  }

  String timeTranstor(String keyTime) {
    String transTime;
    String hour;
    String minute;
    if (int.parse(keyTime.split(':').first) > 12) {
      if ((int.parse(keyTime.split(':').first) - 12) < 10)
        hour = '0' + (int.parse(keyTime.split(':').first) - 12).toString();
      else
        hour = (int.parse(keyTime.split(':').first) - 12).toString();
      if (int.parse(keyTime.split(':').last) < 10)
        minute = '0' + int.parse(keyTime.split(':').last).toString();
      else
        minute = int.parse(keyTime.split(':').last).toString();
      transTime = 'PM ' + hour + ':' + minute;
    } else {
      if (int.parse(keyTime.split(':').first) < 10)
        hour = '0' + int.parse(keyTime.split(':').first).toString();
      else
        hour = int.parse(keyTime.split(':').first).toString();
      if (int.parse(keyTime.split(':').last) < 10)
        minute = '0' + int.parse(keyTime.split(':').last).toString();
      else
        minute = int.parse(keyTime.split(':').last).toString();
      transTime = 'AM ' + hour + ':' + minute;
    }
    return transTime;
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
      if (inputTime.hour < 10 && inputTime.hour >= 0)
        hour = '0' + inputTime.hour.toString();
      else
        hour = inputTime.hour.toString();

      if (inputTime.minute < 10 && inputTime.minute >= 0)
        minute = '0' + inputTime.minute.toString();
      else
        minute = inputTime.minute.toString();

      return hour + ':' + minute;
    }
    return '';
  }
}
