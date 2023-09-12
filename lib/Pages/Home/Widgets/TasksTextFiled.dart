import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Pages/Home/bloc/tasks_bloc.dart';
import 'package:todoapp/core/constant/AppColors.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';

class TasksTextFiled extends StatelessWidget {
  const TasksTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 30,
      cursorColor: Theme.of(context).primaryColor,
      style: Theme.of(context).textTheme.bodyMedium,
      controller: context.read<TasksBloc>().textEditingController,
      decoration: InputDecoration(
        counterText: "",
        hintText: "Write task description here... ".tr(context),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.deepGrey),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).dividerColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
