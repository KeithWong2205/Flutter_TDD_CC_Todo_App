import 'package:flutter_tcc_base_source/core/helpers/global_configs.dart';
import 'package:flutter_tcc_base_source/generated/locale_base.dart';
import 'package:flutter/material.dart';

class LocDelegate extends LocalizationsDelegate<LocaleBase> {
  const LocDelegate();

  final idMap = const {
    GlobalConfig.languageEn: 'locales/en.json',
    GlobalConfig.languageKo: 'locales/ko.json',
  };

  @override
  bool isSupported(Locale locale) => [
        GlobalConfig.languageEn,
        GlobalConfig.languageKo,
      ].contains(locale.languageCode);

  @override
  Future<LocaleBase> load(Locale locale) async {
    var lang = GlobalConfig.languageEn;
    if (isSupported(locale)) lang = locale.languageCode;
    final loc = LocaleBase();
    await loc.load(idMap[lang]!);
    return loc;
  }

  @override
  bool shouldReload(LocDelegate old) => false;
}
