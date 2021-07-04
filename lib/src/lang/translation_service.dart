import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'vi_VN.dart';
import 'en_US.dart';

class TranslationService extends Translations {
  static final locale = _getLocaleFromLanguage();

  static final fallbackLocale = Locale('en', 'US');

  static final langCodes = ['en', 'vi'];

  static final locales = [Locale('en', 'US'), Locale('vi', 'VN')];

  static void changeLocale(String langCodes) {
    final locale = _getLocaleFromLanguage(langCode: langCodes);
    Get.updateLocale(locale!);
  }

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en_US, 'vi_VN': vi_VN};

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }
}
