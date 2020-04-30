import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;

  static MyAppLocalizations of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations);
  }

  //在此撰寫多種語言字串的翻譯
  static Map<String, Map<String, String>> _localizedValues = {
    //這裡同時使用languageCode及countryCode，藉此區隔出中文家族(zh-Hans-CN、zh-Hant-HK、zh-Hant-TW)
    'en' + 'US': {
      'title': 'To-Do List',
      'all_tabBar': 'all',
      'newTitle': 'New Task',
      'topic': 'Task',
      'topicHint': 'ex. Have a meeting with someone.',
      'pickDate': 'Pick Date',
      'selectTime': 'Select Time',
      'save': 'Save',
      'errorFound': 'Error!',
      'yes': 'Confirm',
      'success': 'Success!',
      'errorMessage00': 'The operation is not successed!',
      'errorMessage01': 'The "Task" can not be empty!',
      'errorMessage02': 'The "Date" can not be empty!',
      'errorMessage03': 'The "Time" can not be empty!',
      'errorMessage04': 'Nothing has beed changed!',
      'successMessage01': 'The operation is successed!',
      'loadSuccess': 'The loading is complete!',
      'contentEmpty': "There is no task. Let's create one!",
      'editTitle': 'Edit Task',
      'unfinished': 'Unfinished',
      'finished': 'Finished',
      'warning': 'Warning!',
      'deleteMessage': ' will be deleted, Continue?',
      'no': 'Undo',
      'notice': 'Please select search options: ',
      'byTopic': 'By task',
      'byDate': 'By date',
    },
    'zh' + 'TW': {
      'title': '備忘錄',
      'all_tabBar': '全部',
      'newTitle': '新增代辦事項',
      'topic': '代辦事項',
      'topicHint': '例如，跟某人有約。',
      'pickDate': '選取日期',
      'selectTime': '選擇時間',
      'save': '儲存',
      'errorFound': '發生錯誤!',
      'yes': '確認',
      'success': '順利完成!',
      'errorMessage00': '操作未順利完成!',
      'errorMessage01': '「代辦事項」不可為空白!',
      'errorMessage02': '「日期」不可為空白!',
      'errorMessage03': '「時間」不可為空白!',
      'errorMessage04': '沒有任何修改!',
      'successMessage01': '操作順利完成!',
      'loadSuccess': '載入完成!',
      'contentEmpty': "沒有任何代辦事項。 來建立一個吧!",
      'editTitle': '編輯代辦事項',
      'unfinished': '未完成',
      'finished': '已完成',
      'warning': '注意!',
      'deleteMessage': ' 將被刪除，要繼續嗎?',
      'no': '取消',
      'notice': '請選取搜尋選項: ',
      'byTopic': '依代辦事項',
      'byDate': '依日期',
    },
    'zh' + 'CN': {
      'title': '备忘录',
      'all_tabBar': '全部',
      'newTitle': '新增代办事项',
      'topic': '代办事项',
      'topicHint': '例如，跟某人有约。',
      'pickDate': '选取日期',
      'selectTime': '选择时间',
      'save': '储存',
      'errorFound': '发生错误!',
      'yes': '确认',
      'success': '順利完成!',
      'errorMessage00': '操作未顺利完成!',
      'errorMessage01': '「代办事项」不可为空白!',
      'errorMessage02': '「日期」不可为空白!',
      'errorMessage03': '「时间」不可为空白!',
      'errorMessage04': '沒有任何修改!',
      'successMessage01': '操作順利完成!',
      'loadSuccess': '载入完成!',
      'contentEmpty': "没有任何代办事项。来建立一个吧!",
      'editTitle': '编辑待办事项',
      'unfinished': '未完成',
      'finished': '已完成',
      'warning': '注意!',
      'deleteMessage': ' 将被删除，要继续吗?',
      'no': '取消',
      'notice': '请选取搜寻选项: ',
      'byTopic': '依代办事项',
      'byDate': '依日期',
    },
    'zh' + 'Hant': {
      'title': '備忘錄',
      'all_tabBar': '全部',
      'newTitle': '新增代辦事項',
      'topic': '代辦事項',
      'topicHint': '例如，跟某人有約。',
      'pickDate': '選取日期',
      'selectTime': '選擇時間',
      'save': '儲存',
      'errorFound': '發生錯誤!',
      'yes': '確認',
      'success': '順利完成!',
      'errorMessage00': '操作未順利完成!',
      'errorMessage01': '「代辦事項」不可為空白!',
      'errorMessage02': '「日期」不可為空白!',
      'errorMessage03': '「時間」不可為空白!',
      'errorMessage04': '没有任何修改!',
      'successMessage01': '操作顺利完成!',
      'loadSuccess': '載入完成!',
      'contentEmpty': "沒有任何代辦事項。 來建立一個吧!",
      'editTitle': '編輯代辦事項',
      'unfinished': '未完成',
      'finished': '已完成',
      'warning': '注意!',
      'deleteMessage': ' 將被刪除，要繼續嗎?',
      'no': '取消',
      'notice': '請選取搜尋選項: ',
      'byTopic': '依代辦事項',
      'byDate': '依日期',
    },
    'zh' + 'Hans': {
      'title': '备忘录',
      'allTabBar': '全部',
      'newTitle': '新增代办事项',
      'topic': '代办事项',
      'topicHint': '例如，跟某人有約。',
      'pickDate': '选取日期',
      'selectTime': '选择时间',
      'save': '储存',
      'errorFound': '发生错误!',
      'yes': '确认',
      'success': '順利完成!',
      'errorMessage00': '操作未顺利完成!',
      'errorMessage01': '「代办事项」不可为空白!',
      'errorMessage02': '「日期」不可为空白!',
      'errorMessage03': '「时间」不可为空白!',
      'errorMessage04': '沒有任何修改!',
      'successMessage01': '操作顺利完成!',
      'loadSuccess': '载入完成!',
      'contentEmpty': "没有任何代办事项。来建立一个吧!",
      'editTitle': '编辑待办事项',
      'unfinished': '未完成',
      'finished': '已完成',
      'warning': '注意!',
      'deleteMessage': ' 将被删除，要继续吗?',
      'no': '取消',
      'notice': '请选取搜寻选项: ',
      'byTopic': '依代办事项',
      'byDate': '依日期',
    },
  };

  //回傳翻譯後的特定字串
  String get title {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['title'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]['title'];
  }

  String get allTabBar {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['allTabBar'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['allTabBar'];
  }

  String get newTitle {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['newTitle'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['newTitle'];
  }

  String get topic {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['topic'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]['topic'];
  }

  String get topicHint {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['topicHint'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['topicHint'];
  }

  String get pickDate {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['pickDate'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['pickDate'];
  }

  String get selectTime {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['selectTime'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['selectTime'];
  }

  String get save {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]['save'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]['save'];
  }

  String get errorFound {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['errorFound'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['errorFound'];
  }

  String get yes {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]['yes'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]['yes'];
  }

  String get no {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]['no'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]['no'];
  }

  String get success {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['success'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['success'];
  }

  String get errorMessage00 {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['errorMessage00'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['errorMessage00'];
  }

  String get errorMessage01 {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['errorMessage01'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['errorMessage01'];
  }

  String get errorMessage02 {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['errorMessage02'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['errorMessage02'];
  }

  String get errorMessage03 {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['errorMessage03'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['errorMessage03'];
  }

  String get errorMessage04 {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['errorMessage04'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['errorMessage04'];
  }

  String get successMessage01 {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['successMessage01'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['successMessage01'];
  }

  String get loadSuccess {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['loadSuccess'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['loadSuccess'];
  }

  String get contentEmpty {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['contentEmpty'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['contentEmpty'];
  }

  String get editTitle {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['editTitle'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['editTitle'];
  }

  String get unfinished {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['unfinished'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['unfinished'];
  }

  String get finished {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['finished'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['finished'];
  }

  String get warning {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['warning'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['warning'];
  }

  String get deleteMessage {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['deleteMessage'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['deleteMessage'];
  }

  String get notice {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['notice'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['notice'];
  }

  String get byTopic {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['byTopic'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['byTopic'];
  }
  String get byDate {
    if (locale.countryCode != null)
      return _localizedValues[locale.languageCode + locale.countryCode]
          ['byDate'];
    else
      return _localizedValues[locale.languageCode + locale.scriptCode]
          ['byDate'];
  }
}

class MyAppLocalizationsDelegate
    extends LocalizationsDelegate<MyAppLocalizations> {
  const MyAppLocalizationsDelegate();

  //檢查執行環境是否支援所設定的語言
  @override
  //這裡同時使用languageCode及countryCode，藉此區隔出中文家族(zh-Hans-CN、zh-Hant-HK、zh-Hant-TW)
  bool isSupported(Locale locale) =>
      (['en', 'zh'].contains(locale.languageCode) &&
          ['US', 'TW', 'CN'].contains(locale.countryCode)) ||
      (['zh'].contains(locale.languageCode) &&
          ['Hans', 'Hant'].contains(locale.scriptCode));

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(MyAppLocalizations(locale));
  }

  //是否需要重載
  @override
  bool shouldReload(MyAppLocalizationsDelegate old) => false;
}
