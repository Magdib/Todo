import 'package:hive/hive.dart';

part 'TaskModel.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String taskbody;
  @HiveField(1)
  final bool isfinished;

  Task({required this.taskbody, this.isfinished = false});
}
