import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:gym_tracker/cubit/diohelper.dart';
import 'package:gym_tracker/cubit/states.dart';
import 'package:gym_tracker/screens/addexersisescreen.dart';
import 'package:gym_tracker/screens/exersises.dart';


import 'screens/applayout.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          print('staring application with ${AppCubit.get(context).currentTheme}');
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppCubit.get(context).currentTheme,

            home: AppLayout(),
          );
        },
      ),
    );
  }
}
