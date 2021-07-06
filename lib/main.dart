import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopappfirebase/src/lang/translation_service.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';
import 'package:shopappfirebase/src/screens/authentication/widgets/landing_page.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';
import 'package:shopappfirebase/src/themes/themes.dart';

void main() async {
  await GetStorage.init();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Shop App Flutter',
    locale: TranslationService.locale,
    translations: TranslationService(),
    fallbackLocale: TranslationService.fallbackLocale,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    theme: AppTheme.light().data,
    darkTheme: AppTheme.dark().data,
    themeMode: ThemeService().getThemeMode(),
  ));
}
