part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TasksState {}

class ChangeTasksState extends TasksState {
  final List<Task> tasks;
  final int timer;
  const ChangeTasksState({required this.tasks, this.timer = 9});

  @override
  List<Object> get props => [tasks, timer];
}
