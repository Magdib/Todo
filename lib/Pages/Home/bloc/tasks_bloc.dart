import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/core/constant/HiveData.dart';
import 'package:todoapp/model/TaskModel.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  Box<Task> tasksBox = Hive.box(HiveData.tasksBox);
  bool? canDelete;
  final TextEditingController textEditingController = TextEditingController();
  TasksBloc() : super(TaskInitial()) {
    on<TasksEvent>((event, emit) async {
      if (event is GetTasksEvent) {
        if (tasksBox.isNotEmpty) {
          List<Task> tempList = tasksBox.values.toList();

          await Future.delayed(const Duration(milliseconds: 1100));
          emit(ChangeTasksState(tasks: tempList));
        }
      }
      if (event is AddTaskEvent) {
        Task newTask = Task(taskbody: textEditingController.text);
        ChangeTasksState currentState;
        tasksBox.add(newTask);
        textEditingController.clear();
        if (state is ChangeTasksState) {
          currentState = state as ChangeTasksState;
          emit(ChangeTasksState(
              tasks: List.from(currentState.tasks)..add(newTask)));
        } else {
          emit(ChangeTasksState(tasks: [newTask]));
        }
      } else if (event is EditTaskEvent) {
        Task newTask = Task(taskbody: textEditingController.text);
        ChangeTasksState currentState = state as ChangeTasksState;
        tasksBox.putAt(event.index, newTask);
        textEditingController.clear();
        emit(ChangeTasksState(
            tasks: List.from(currentState.tasks)..[event.index] = newTask));
      } else if (event is DeleteTaskEvent) {
        ChangeTasksState currentState = state as ChangeTasksState;
        tasksBox.deleteAt(event.index);
        emit(ChangeTasksState(
            tasks: List.from(currentState.tasks)..removeAt(event.index)));
      } else if (event is CompleteTaskEvent) {
        ChangeTasksState currentState = state as ChangeTasksState;
        Task task = Task(
            taskbody: currentState.tasks[event.index].taskbody,
            isfinished: !currentState.tasks[event.index].isfinished);
        tasksBox.putAt(event.index, task);
        emit(ChangeTasksState(
            tasks: List.from(currentState.tasks)..[event.index] = task));
      } else if (event is StopTimerEvent) {
        ChangeTasksState currentState = state as ChangeTasksState;
        canDelete = false;
        emit(ChangeTasksState(tasks: List.from(currentState.tasks), timer: 9));
      }
    });
    on<ClearTasksEvent>((event, emit) async {
      canDelete = true;
      ChangeTasksState currentState = state as ChangeTasksState;
      int time = 9;
      for (int i = 9; i > 0; i--) {
        if (canDelete != false) {
          await Future.delayed(const Duration(seconds: 1));
          time--;
          if (canDelete == false) {
            emit(ChangeTasksState(
                tasks: List.from(currentState.tasks), timer: 9));
          } else {
            emit(ChangeTasksState(
                tasks: List.from(currentState.tasks), timer: time));
          }
        }
      }
      if (canDelete != false) {
        tasksBox.clear();
        emit(const ChangeTasksState(tasks: [], timer: 9));
      }
    });
  }
}
