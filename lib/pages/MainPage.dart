import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//引入其他頁
import 'package:flutter_todo_multi_lan/dbDatas/dbDatas.dart';
import 'package:flutter_todo_multi_lan/dbDatas/dbHelper.dart';
import 'package:flutter_todo_multi_lan/modules/localizations.dart';
import 'package:flutter_todo_multi_lan/modules/tools.dart';
import 'AddPage.dart';
import 'ChangePage.dart';

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

  final key = GlobalKey<ScaffoldState>();

  String mode = '1';

  DBHelper helper = DBHelper();

  Tool myTool = Tool();

  List<DBDatas> fullData = List<DBDatas>();
  List<DBDatas> finishedData = List<DBDatas>();
  List<DBDatas> unfinishedData = List<DBDatas>();

  List<String> fullList = List<String>();
  List<String> finishedList = List<String>();
  List<String> unfinishedList = List<String>();

  DateFormat idFormat = DateFormat('yyyy-MM-dd HH:mm');

  DateTime nowTime;

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: key,
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
                icon: Icon(Icons.autorenew),
                color: Colors.white,
                iconSize: 20.0,
                onPressed: () {
                  setState(() {
                    getData();
                  });
                }),
            IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                iconSize: 20.0,
                onPressed: () {
                  //前往新增
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPage()));
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
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: _buildList1(fullData),
                    ),
                  ),
                  _buildSearchBar(_controller001),
                  _buildButtomBar(),
                ],
              ),
            ),
            //tab-未完成
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: _buildList2(unfinishedData),
                    ),
                  ),
                  _buildSearchBar(_controller002),
                  _buildButtomBar(),
                ],
              ),
            ),
            //tab-已完成
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: _buildList3(finishedData),
                    ),
                  ),
                  _buildSearchBar(_controller003),
                  _buildButtomBar(),
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
          IconButton(
            icon: mode == '1' ? Icon(Icons.list) : mode == '2' ? Icon(Icons.calendar_today) : mode == '3' ? Icon(Icons.star) : Container(),
            color: Colors.white,
            iconSize: 20.0,
            onPressed: () {
              setState(() {
                if (mode == '1') {
                  mode = '2';
                  Tool.showSackerMessageBar(key, MyAppLocalizations.of(context).nowis + MyAppLocalizations.of(context).byDate, 'Notice');
                }
                else if (mode == '2') {
                  mode = '3';
                  Tool.showSackerMessageBar(key, MyAppLocalizations.of(context).nowis + MyAppLocalizations.of(context).byImportance, 'Notice');
                }
                else if (mode == '3') {
                  mode = '1';
                  Tool.showSackerMessageBar(key, MyAppLocalizations.of(context).nowis + MyAppLocalizations.of(context).byTopic, 'Notice');
                }
              });
            },
          ),
          Expanded(
            child: SizedBox(
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                ),
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

  Widget _buildButtomBar() {
    return Container(
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 40,
              child: Container(
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildList1(List<DBDatas> fullData) {
    if (fullData.length == 0 || fullData == null)
      return Container(
          child:
              Center(child: Text(MyAppLocalizations.of(context).contentEmpty)));
    else
      return ListView.builder(
          itemCount: fullData.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.blue,
                  onPressed: () {
                    //執行刪除
                    Tool.showCheckMessage(
                        context,
                        MyAppLocalizations.of(context).warning,
                        '「' +
                            fullData[index].task +
                            '」' +
                            MyAppLocalizations.of(context).deleteMessage,
                        MyAppLocalizations.of(context).yes,
                        MyAppLocalizations.of(context).no, () async {
                      int _result = await helper.deleteTask(fullData[index].id);
                      //成功
                      if (_result != 0)
                        Tool.showSackerMessageBar(
                            key,
                            MyAppLocalizations.of(context).successMessage01,
                            'Success');
                      //失敗
                      else
                        Tool.showSackerMessageBar(
                            key,
                            MyAppLocalizations.of(context).errorMessage00,
                            'Error');
                    });
                  }),
              title: Text(fullData[index].task,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: myTool.timeDifference(nowTime, fullData[index].date, fullData[index].time) && fullData[index].status == '' ? Colors.red : fullData[index].status == 'finished' ? Colors.blue : Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(fullData[index].date +
                  ' ' +
                  myTool.timeTranstor(fullData[index].time)),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  onPressed: () {
                    //前往修改
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangePage(list: fullData[index])));
                  }),
            );
          });
  }

  Widget _buildList2(List<DBDatas> unfinishedData) {
    if (unfinishedData.length == 0 || unfinishedData == null)
      return Container();
    else
      return ListView.builder(
          itemCount: unfinishedData.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.blue,
                  onPressed: () {
                    //執行刪除
                    Tool.showCheckMessage(
                      context,
                      MyAppLocalizations.of(context).warning,
                      '「' +
                          unfinishedData[index].task +
                          '」' +
                          MyAppLocalizations.of(context).deleteMessage,
                      MyAppLocalizations.of(context).yes,
                      MyAppLocalizations.of(context).no,
                      () async {
                        int _result =
                            await helper.deleteTask(unfinishedData[index].id);
                        //成功
                        if (_result != 0)
                          Tool.showSackerMessageBar(
                              key,
                              MyAppLocalizations.of(context).successMessage01,
                              'Success');
                        //失敗
                        else
                          Tool.showSackerMessageBar(
                              key,
                              MyAppLocalizations.of(context).errorMessage00,
                              'Error');
                      },
                    );
                  }),
              title: Text(unfinishedData[index].task,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: myTool.timeDifference(nowTime, unfinishedData[index].date, unfinishedData[index].time) && unfinishedData[index].status == '' ? Colors.red : unfinishedData[index].status == 'finished' ? Colors.blue :Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(unfinishedData[index].date +
                  ' ' +
                  myTool.timeTranstor(unfinishedData[index].time)),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  onPressed: () {
                    //前往修改
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangePage(list: unfinishedData[index])));
                  }),
            );
          });
  }

  Widget _buildList3(List<DBDatas> finishedData) {
    if (finishedData.length == 0 || finishedData == null)
      return Container();
    else
      return ListView.builder(
          itemCount: finishedData.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.blue,
                  onPressed: () {
                    //執行刪除
                    Tool.showCheckMessage(
                      context,
                      MyAppLocalizations.of(context).warning,
                      '「' +
                          finishedData[index].task +
                          '」' +
                          MyAppLocalizations.of(context).deleteMessage,
                      MyAppLocalizations.of(context).yes,
                      MyAppLocalizations.of(context).no,
                      () async {
                        int _result =
                            await helper.deleteTask(finishedData[index].id);
                        //成功
                        if (_result != 0)
                          Tool.showSackerMessageBar(
                              key,
                              MyAppLocalizations.of(context).successMessage01,
                              'Success');
                        //失敗
                        else
                          Tool.showSackerMessageBar(
                              key,
                              MyAppLocalizations.of(context).errorMessage00,
                              'Error');
                      },
                    );
                  }),
              title: Text(finishedData[index].task,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: myTool.timeDifference(nowTime, finishedData[index].date, finishedData[index].time) && finishedData[index].status == '' ? Colors.red : finishedData[index].status == 'finished' ? Colors.blue : Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(finishedData[index].date +
                  ' ' +
                  myTool.timeTranstor(finishedData[index].time)),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  onPressed: () {
                    //前往修改
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangePage(list: finishedData[index])));
                  }),
            );
          });
  }

  void getData() async {
    fullData = await helper.getTaskList();
    //如果有資料就不會為空
    if (fullData != null) {
      Tool.showSackerMessageBar(
          key, MyAppLocalizations.of(context).loadSuccess, 'Success');
    }
    finishedData = await helper.getFinishedTaskList();
    //如果有資料就不會為空
    unfinishedData = await helper.getUnfinishedTaskList();
    //如果有資料就不會為空
  }
}
