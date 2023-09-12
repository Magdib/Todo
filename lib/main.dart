import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Pages/Home/bloc/tasks_bloc.dart';
import 'package:todoapp/core/Helper/StartUpFunction.dart';
import 'package:todoapp/core/theme/AppTheme.dart';
import 'package:todoapp/core/theme/ThemeFun.dart';
import 'Pages/Shared/CustomMaterialApp.dart';
import 'Pages/settings/Controllers/ThemeCubit/theme_cubit.dart';

void main() async {
  await startUpFunction();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksBloc>(
            create: (context) => TasksBloc()..add(GetTasksEvent())),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is SaveThemeState) {
            return CustomMaterialApp(
              theme: ThemeFun().getThemeData(),
            );
          } else {
            return CustomMaterialApp(
                theme: ThemeFun().getThemeData() ?? AppTheme.theme);
          }
        },
      ),
    );
  }
}
