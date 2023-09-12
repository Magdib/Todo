import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Pages/settings/Controllers/ThemeCubit/theme_cubit.dart';

import 'ThemeAlertDialog.dart';

class HandleThemeDialog extends StatelessWidget {
  const HandleThemeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        if (state is SaveThemeState) {
          return ThemeAlertDialog(
            color: state.pickerColor,
            enabled: true,
          );
        } else if (state is ChangeThemeState) {
          return ThemeAlertDialog(
            color: state.pickerColor,
            enabled: true,
          );
        } else {
          final Color color = Theme.of(context).primaryColor;
          return ThemeAlertDialog(
            color: color,
            enabled: false,
          );
        }
      },
    );
  }
}
