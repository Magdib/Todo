import 'package:flutter/material.dart';
import 'package:todoapp/core/constant/AppColors.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light().copyWith(
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(
      AppColors.white,
    ))),
    cardTheme: const CardTheme(
      surfaceTintColor: AppColors.white,
    ),
    useMaterial3: true,
    primaryColor: AppColors.orange,
    dividerColor: AppColors.black,
    primaryColorLight: AppColors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: AppColors.orange, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: AppColors.orange, fontSize: 16, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
        color: AppColors.black,
        fontSize: 16,
      ),
    ),
  );
}
