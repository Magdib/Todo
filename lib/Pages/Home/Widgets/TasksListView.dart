import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Pages/Home/Widgets/CUTaskDialog.dart';
import 'package:todoapp/Pages/Home/bloc/tasks_bloc.dart';
import 'package:todoapp/core/Helper/AppHelper.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';
import 'package:todoapp/model/TaskModel.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
    required this.tasks,
  });
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHelper.getDeviceHeight(context),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          SizedBox(
            height: AppHelper.getDeviceHeight(context) - 200,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.all(10),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) => InkWell(
                onDoubleTap: () {
                  context.read<TasksBloc>().textEditingController.text =
                      tasks[index].taskbody;
                  showDialog(
                    context: context,
                    builder: (context) => CUTaskDialog(
                      isEdit: true,
                      index: index,
                    ),
                  );
                },
                onLongPress: () =>
                    context.read<TasksBloc>().add(DeleteTaskEvent(index)),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tasks[index].taskbody,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        IconButton(
                          onPressed: () => context
                              .read<TasksBloc>()
                              .add(CompleteTaskEvent(index)),
                          tooltip: tasks[index].isfinished == false
                              ? "Complete Task".tr(context)
                              : "Reset Task".tr(context),
                          iconSize: 30,
                          icon: Icon(
                            tasks[index].isfinished == false
                                ? Icons.circle_outlined
                                : Icons.check,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: AppHelper.getDeviceWidth(context) / 2 - 52.5,
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20)),
              ))
        ],
      ),
    );
  }
}
