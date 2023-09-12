import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/core/constant/AppColors.dart';
import 'package:todoapp/core/constant/HiveData.dart';
import 'package:todoapp/core/theme/AppTheme.dart';

class ThemeFun {
  ThemeData? getThemeData() {
    Box dataBox = Hive.box(HiveData.dataBox);
    Color? primaryColor;
    if (dataBox.get(HiveData.primaryColor) == null) {
      primaryColor = null;
    } else {
      primaryColor = colorFromHex(dataBox.get(HiveData.primaryColor));
    }
    return primaryColor == null
        ? AppTheme.theme
        : ThemeData.light().copyWith(
            iconButtonTheme: const IconButtonThemeData(
                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(
              AppColors.white,
            ))),
            cardTheme: const CardTheme(
              surfaceTintColor: AppColors.white,
            ),
            useMaterial3: true,
            primaryColor: primaryColor,
            dividerColor: AppColors.black,
            primaryColorLight: AppColors.white,
            textTheme: TextTheme(
              titleLarge: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              titleMedium: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              labelMedium: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
          );
  }
}
