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
    'en'+'US': {
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
      'errorMessage01': 'The "Task" can not be empty!',
      'errorMessage02': 'The "Date" can not be empty!',
      'errorMessage03': 'The "Time" can not be empty!',
      'successMessage01': 'The operation is successed!',
    },
    'zh'+'TW': {
      'title': '備忘錄',
      'all_tabBar': '全部',
      'newTitle': '新增事項',
      'topic': '事項',
      'topicHint': '例如，跟某人有約。',
      'pickDate': '選取日期',
      'selectTime': '選擇時間',
      'save': '儲存',
      'errorFound': '發生錯誤!',
      'yes': '確認',
      'success': '順利完成!',
      'errorMessage01': '「事項」不可為空白!',
      'errorMessage02': '「日期」不可為空白!',
      'errorMessage03': '「時間」不可為空白!',
      'successMessage01': '操作順利完成!',
    },
    'zh'+'CN': {
      'title': '备忘录',
      'all_tabBar': '全部',
      'newTitle': '新增事项',
      'topic': '事项',
      'topicHint': '例如，跟某人有约。',
      'pickDate': '选取日期',
      'selectTime': '选择时间',
      'save': '储存',
      'errorFound': '发生错误!',
      'yes': '确认',
      'success': '順利完成!',
      'errorMessage01': '「事项」不可为空白!',
      'errorMessage02': '「日期」不可为空白!',
      'errorMessage03': '「时间」不可为空白!',
      'successMessage01': '操作順利完成!',
    },
    'zh'+'Hant': {
      'title': '備忘錄',
      'all_tabBar': '全部',
      'newTitle': '新增事項',
      'task': '項目',
      'topic': '事項',
      'topicHint': '例如，跟某人有約。',
      'pickDate': '選取日期',
      'selectTime': '選擇時間',
      'save': '儲存',
      'errorFound': '發生錯誤!',
      'yes': '確認',
      'success': '順利完成!',
      'errorMessage01': '「事項」不可為空白!',
      'errorMessage02': '「日期」不可為空白!',
      'errorMessage03': '「時間」不可為空白!',
      'successMessage01': '操作顺利完成!',
    },
    'zh'+'Hans': {
      'title': '备忘录',
      'allTabBar': '全部',
      'newTitle': '新增事项',
      'topic': '事项',
      'topicHint': '例如，跟某人有約。',
      'pickDate': '选取日期',
      'selectTime': '选择时间',
      'save': '储存',
      'errorFound': '发生错误!',
      'yes': '确认',
      'success': '順利完成!',
      'errorMessage01': '「事项」不可为空白!',
      'errorMessage02': '「日期」不可为空白!',
      'errorMessage03': '「时间」不可为空白!',
      'successMessage01': '操作顺利完成!',
    },
  };

  //回傳翻譯後的特定字串
  String get title {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['title'];
    else 
      return _localizedValues[locale.languageCode+locale.scriptCode]['title'];
  }
  String get allTabBar {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['allTabBar'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['allTabBar'];
  }
  String get newTitle {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['newTitle'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['newTitle'];
  }
  String get topic {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['topic'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['topic'];
  }
  String get topicHint {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['topicHint'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['topicHint'];
  }
  String get pickDate {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['pickDate'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['pickDate'];
  }
  String get selectTime {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['selectTime'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['selectTime'];
  }
  String get save {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['save'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['save'];
  }
  String get errorFound {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['errorFound'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['errorFound'];
  }
  String get yes {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['yes'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['yes'];
  }
  String get success {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['success'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['success'];
  }
  String get errorMessage01 {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['errorMessage01'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['errorMessage01'];
  }
  String get errorMessage02 {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['errorMessage02'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['errorMessage02'];
  }
  String get errorMessage03 {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['errorMessage03'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['errorMessage03'];
  }
  String get successMessage01 {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['successMessage01'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['successMessage01'];
  }
}

class MyAppLocalizationsDelegate extends LocalizationsDelegate<MyAppLocalizations> {
  const MyAppLocalizationsDelegate();

  //檢查執行環境是否支援所設定的語言
  @override
  //這裡同時使用languageCode及countryCode，藉此區隔出中文家族(zh-Hans-CN、zh-Hant-HK、zh-Hant-TW)
  bool isSupported(Locale locale) => (['en', 'zh'].contains(locale.languageCode) && ['US', 'TW', 'CN'].contains(locale.countryCode)) || (['zh'].contains(locale.languageCode) && ['Hans', 'Hant'].contains(locale.scriptCode));

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(MyAppLocalizations(locale));
  }

  //是否需要重載
  @override
  bool shouldReload(MyAppLocalizationsDelegate old) => false;
}