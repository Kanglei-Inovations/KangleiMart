import 'package:flutter/material.dart';
import 'package:kangleimart/utils/text_theme.dart';

import 'firebase/all_constants.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    ///colorScheme: ColorScheme(background: AppColors.white, brightness: null),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.indyBlue,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    ///colorScheme: ColorScheme(surface: AppColors.spaceCadet),
  );
}