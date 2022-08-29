import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleBase {
  late Map<String, dynamic> _data;
  late String _path;
  Future<void> load(String path) async {
    _path = path;
    final strJson = await rootBundle.loadString(path);
    _data = jsonDecode(strJson);
    initAll();
  }
  
  Map<String, String> getData(String group) {
    return Map<String, String>.from(_data[group]);
  }

  String getPath() => _path;

  late Localelogin _login;
  Localelogin get login => _login;
  late Localecommon _common;
  Localecommon get common => _common;

  void initAll() {
    _login = Localelogin(Map<String, String>.from(_data['login']));
    _common = Localecommon(Map<String, String>.from(_data['common']));
  }
}

class Localelogin {
  late final Map<String, String> _data;
  Localelogin(this._data);

  String getByKey(String key) {
    return _data[key]!;
  }

  String get login => _data["login"]!;
  String get loginSuccess => _data["loginSuccess"]!;
  String get loginFailed => _data["loginFailed"]!;
  String get loginGoogle => _data["loginGoogle"]!;
  String get loginFacebook => _data["loginFacebook"]!;
  String get loginApple => _data["loginApple"]!;
}

class Localecommon {
  late final Map<String, String> _data;
  Localecommon(this._data);

  String getByKey(String key) {
    return _data[key]!;
  }

  String get versionName => _data["versionName"]!;
  String get buildNumber => _data["buildNumber"]!;
}

