import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todoapp/Pages/Shared/DialogButton.dart';
import 'package:todoapp/Pages/settings/Controllers/ThemeCubit/theme_cubit.dart';
import 'package:todoapp/core/Helper/AppHelper.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';

class ThemeAlertDialog extends StatelessWidget {
  const ThemeAlertDialog({
    super.key,
    required this.color,
    required this.enabled,
  });
  final Color color;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Center(
        child: Text(
          "Theme".tr(context),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color),
        ),
      ),
      content: SizedBox(
        height: 400,
        child: ColorPicker(
            displayThumbColor: false,
            enableAlpha: false,
            hexInputBar: false,
            portraitOnly: false,
            labelTypes: const [],
            pickerColor: color,
            onColorChanged: (pickerColor) =>
                context.read<ThemeCubit>().changeTheme(pickerColor)),
      ),
      actions: [
        DialogButton(
          text: "Confirm".tr(context),
          width: AppHelper.getDeviceWidth(context) / 1.5,
          color: color,
          onPressed: enabled == true
              ? () => context.read<ThemeCubit>().saveTheme(context)
              : null,
        ),
      ],
    );
  }
}
