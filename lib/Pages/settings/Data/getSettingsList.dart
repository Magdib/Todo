import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/Pages/Home/bloc/tasks_bloc.dart';
import 'package:todoapp/Pages/Shared/DialogButton.dart';
import 'package:todoapp/Pages/settings/Controllers/LanguageCubit/language_cubit.dart';
import 'package:todoapp/Pages/settings/Widgets/HandleThemeDialog.dart';
import 'package:todoapp/core/Helper/AppHelper.dart';
import 'package:todoapp/core/constant/AppColors.dart';
import 'package:todoapp/core/constant/HiveData.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';
import 'package:todoapp/model/TaskModel.dart';

List<Map<String, dynamic>> getSettingsList(BuildContext context) {
  List<Map<String, dynamic>> settingeDataList = [
    {
      'text': "En --> Ar".tr(context),
      'icon': Icons.language,
      "function": () => context.read<LanguageCubit>().changeLocal()
    },
    {
      'text': "Theme".tr(context),
      'icon': Icons.color_lens,
      "function": () => showDialog(
            context: context,
            builder: (context) => const HandleThemeDialog(),
          )
    },
    {
      'text': "Delete All".tr(context),
      'icon': Icons.delete,
      "function": Hive.box<Task>(HiveData.tasksBox).isNotEmpty
          ? () {
              context.read<TasksBloc>().add(ClearTasksEvent());
              ScaffoldMessenger.of(context)
                  .showSnackBar(clearTaskSnackBar(context));
            }
          : null
    },
    {
      'text': "info".tr(context),
      'icon': Icons.info,
      "function": () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Center(
                child: Text(
                  "info".tr(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              content: Text(
                "Long Tap the task to delete it\n\nDouble tap the task to edit it"
                    .tr(context),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              actions: [
                DialogButton(
                  text: "I understand!".tr(context),
                  width: AppHelper.getDeviceWidth(context) / 1.5,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          )
    }
  ];
  return settingeDataList;
}

SnackBar clearTaskSnackBar(BuildContext context) {
  return SnackBar(
    content: BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        final currentState = state as ChangeTasksState;
        if (currentState.timer > 0) {
          return InkWell(
            onTap: () async {
              context.read<TasksBloc>().add(StopTimerEvent());
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            child: Row(
              children: [
                Text(
                    "${'Tasks will be deleted after'.tr(context)} ${currentState.timer} ",
                    style: Theme.of(context).textTheme.titleMedium),
                Text(
                  "Undo".tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(decoration: TextDecoration.underline),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.delete,
                  color: AppColors.white,
                )
              ],
            ),
          );
        } else {
          return Text(
            "All tasks have been deleted".tr(context),
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
      },
    ),
    duration: const Duration(milliseconds: 8500),
    backgroundColor: Theme.of(context).primaryColor,
  );
}
