import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/Pages/Home/Widgets/CUTaskDialog.dart';
import 'package:todoapp/Pages/Home/Widgets/TasksListView.dart';
import 'package:todoapp/Pages/Home/bloc/tasks_bloc.dart';
import 'package:todoapp/Pages/settings/screen/SettingsPage.dart';
import 'package:todoapp/core/Helper/AppHelper.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/core/constant/HiveData.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';
import 'package:todoapp/model/TaskModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                context.read<TasksBloc>().textEditingController.clear();
                return const CUTaskDialog();
              }),
          child: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Home Page".tr(context),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  )),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is ChangeTasksState) {
            return TasksListView(tasks: state.tasks);
          } else {
            return LottieBuilder.asset(
              "${AppHelper.lottiePath}g8atEQReYj.json",
              repeat: Hive.box<Task>(HiveData.tasksBox).isEmpty ? false : true,
            );
          }
        },
      ),
    );
  }
}
