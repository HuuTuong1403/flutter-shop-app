import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopappfirebase/src/lang/translation_service.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';
import 'package:shopappfirebase/src/screens/authentication/widgets/landing_page.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';
import 'package:shopappfirebase/src/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return GetMaterialApp(
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
          );
        });
  }
}
