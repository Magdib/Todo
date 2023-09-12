import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Pages/Home/bloc/tasks_bloc.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';

import '../../Shared/DialogButton.dart';
import 'TasksTextFiled.dart';

class CUTaskDialog extends StatelessWidget {
  const CUTaskDialog({
    super.key,
    this.isEdit,
    this.index,
  });
  final int? index;
  final bool? isEdit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      title: Center(
        child: Text(
          "Task".tr(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      content: const TasksTextFiled(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        DialogButton(
          text: "Confirm".tr(context),
          onPressed: () {
            isEdit != null
                ? context.read<TasksBloc>().add(EditTaskEvent(index!))
                : context.read<TasksBloc>().add(AddTaskEvent());
            Navigator.of(context).pop();
          },
        ),
        DialogButton(
          text: "Cancle".tr(context),
          onPressed: () {
            Navigator.of(context).pop();
            context.read<TasksBloc>().textEditingController.clear();
          },
        )
      ],
    );
  }
}
