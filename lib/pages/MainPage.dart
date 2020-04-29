import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/modules/localizations.dart';
import 'AddChangePage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          MyAppLocalizations.of(context).title,
      localizationsDelegates: [
        const MyAppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //英文-美國
        const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        //中文-臺灣
        const Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
        //中文-中國
        const Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
        //中文-繁體
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        //中文-簡體
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  final TextEditingController _controller001 = TextEditingController();
  final TextEditingController _controller002 = TextEditingController();
  final TextEditingController _controller003 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.check)),
            ],
          ),
          title: Text(MyAppLocalizations.of(context).title,
              style: TextStyle(fontSize: 20)),
          centerTitle: true, //文字是否置中
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                iconSize: 20.0,
                onPressed: () {
                  //前往新增
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AddChangePage()));
                }),
          ],
        ),
        body: TabBarView(
          children: [
            //tab-全部
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  _buildSearchBar(_controller001),
                ],
              ),
            ),
            //tab-未完成
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  _buildSearchBar(_controller002),
                ],
              ),
            ),
            //tab-已完成
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  _buildSearchBar(_controller003),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(TextEditingController controller) {
    return Container(
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid)),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  maxLength: 250,
                  inputFormatters: null,
                  decoration: InputDecoration(
                    hintText: '', //輸入提示
                    counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
                  ),
                  enabled: true,
                  onChanged: (value) {
                    setState(() {
                      value = controller.text;
                    });
                  },
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            iconSize: 20.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
