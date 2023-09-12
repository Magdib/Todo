import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/core/constant/HiveData.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late Color pickerColor;
  ThemeCubit() : super(ThemeInitial());
  changeTheme(Color pickedColor) {
    pickerColor = pickedColor;
    emit(ThemeInitial());
    emit(ChangeThemeState(pickerColor: pickedColor));
  }

  saveTheme(BuildContext context) {
    emit(SaveThemeState(pickerColor: pickerColor));
    Hive.box(HiveData.dataBox)
        .put(HiveData.primaryColor, colorToHex(pickerColor));
    Navigator.of(context).pop();
  }
}
