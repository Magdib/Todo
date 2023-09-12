import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/core/constant/HiveData.dart';
import 'package:todoapp/model/TaskModel.dart';

import 'BlocObserver.dart';

startUpFunction() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox(HiveData.dataBox);
  await Hive.openBox<Task>(HiveData.tasksBox);

  Bloc.observer = MyBlocObserver();
}
