import 'package:flutter/material.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/themes/app_colors.dart';

class AppTheme {
  final ThemeMode mode;
  final ThemeData data;
  final AppColors appColors;

  AppTheme({required this.mode, required this.data, required this.appColors});

  factory AppTheme.light() {
    final mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      primaryColor: appColors.primary,
      accentColor: Colors.deepPurple,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.purple),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorBlack,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline1: TextStyle(color: appColors.header),
          headline2: TextStyle(color: appColors.header),
          bodyText1: TextStyle(color: appColors.contentText1),
        ),
      ),
      buttonColor: appColors.primary,
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    final mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      primaryColor: appColors.primary,
      backgroundColor: Colors.grey.shade700,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: AppColor.endColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedIconTheme: IconThemeData(color: AppColor.endColor),
        unselectedIconTheme: IconThemeData(color: mCL),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline1: TextStyle(color: appColors.header),
          headline2: TextStyle(color: appColors.header),
          bodyText1: TextStyle(color: appColors.contentText1),
        ),
      ),
      buttonColor: appColors.primary,
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }
}
