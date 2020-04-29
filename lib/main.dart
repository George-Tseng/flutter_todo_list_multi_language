import 'package:flutter/material.dart';
//引入其他頁
import 'pages/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: null,
      /* 路由表 */
      routes: {
        '/': (BuildContext context) => MainPage(), //首頁
      },
      /* 路由表(帶參數) */
      onGenerateRoute: (RouteSettings settings) {
        return null;
      },
      /* 路由失敗時 */
      onUnknownRoute: (RouteSettings settings) {
        return null;
      },
    );
  }
}
