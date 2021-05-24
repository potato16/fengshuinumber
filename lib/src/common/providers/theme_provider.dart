import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//FBAE3C
//001220

final themeProvider = StateProvider<ThemeData>((ref) {
  return ThemeData(
    fontFamily: 'Poppins',
    // primaryColor: AppColors.primary,
    // accentColor: AppColors.secondary,
    // errorColor: AppColors.warning,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 2,
      )),
      errorMaxLines: 3,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        padding: EdgeInsets.all(16),
        elevation: 4,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        backgroundColor: AppColors.inputBackground,
        alignment: AlignmentDirectional.centerStart,
        primary: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 1,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    ),
    textTheme: TextTheme(
      headline4:
          TextStyle(fontWeight: FontWeight.w700, fontSize: 32, height: 34 / 32),
      headline5: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 38 / 24,
          letterSpacing: .75),
      headline6: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, letterSpacing: .75),
      button: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 22 / 14,
          letterSpacing: .25),
      subtitle1: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18, letterSpacing: .75),
      subtitle2: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          height: 18 / 13,
          letterSpacing: .75),
      bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 28 / 16,
          letterSpacing: .75),
      caption: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          height: 18 / 13,
          letterSpacing: .25),
    ).apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
  );
});

class AppColors {
  AppColors._();
  static Color primaryDark = Color(0xFF2A00A2);
  static Color primary = Color(0xFFFBAE3C);
  static Color secondary = Color(0xFFDEF9FF);
  static Color warning = Color(0xFFC30052);
  static Color warningBG = Color(0xFFFFDFED);
  static Color text = Color(0xFF14142B);
  static Color inputBackground = Color(0xFFEFF0F6);
  static Color label = Color(0xFF6E7191);
}
