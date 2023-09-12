part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetTasksEvent extends TasksEvent {}

class AddTaskEvent extends TasksEvent {}

class EditTaskEvent extends TasksEvent {
  final int index;

  const EditTaskEvent(this.index);
}

class DeleteTaskEvent extends TasksEvent {
  final int index;

  const DeleteTaskEvent(this.index);
}

class CompleteTaskEvent extends TasksEvent {
  final int index;

  const CompleteTaskEvent(this.index);
}

class ClearTasksEvent extends TasksEvent {}

class StopTimerEvent extends TasksEvent {}
