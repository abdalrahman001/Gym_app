import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/states.dart';
import 'package:gym_tracker/screens/exerciseWidget.dart';
import 'package:gym_tracker/screens/history.dart';
import 'package:gym_tracker/screens/home.dart';
import 'package:gym_tracker/screens/profile.dart';
import 'package:gym_tracker/screens/templateworkout.dart';
import 'package:gym_tracker/themes/apptheme.dart';
import '../assets/widgets.dart';
import '../screens/exersises.dart';
import 'diohelper.dart';

class AppCubit extends Cubit<AppStates> {
  ThemeData currentTheme = darkTheme;

  AppCubit() : super(InitStates());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  List<Map<String, dynamic>> exercises = [];
  List<Exercise> ex = [];
  int currentIndex = 0;

  void changeTheme() {
    if (currentTheme == darkTheme) {
      print("Switching to light");
      currentTheme = lightTheme;
      emit(ChangeThemeState());
    } else {
      print("Switching to Dark");
      currentTheme = darkTheme;
      emit(ChangeThemeState());
    }
  }

  void bottomNavbarSwap(int index) {
    currentIndex = index;
    emit(BottomBarChangingState());
  }

  List<Widget> screens = [
    Profile(),
    History(),
    Home(),
    ExercisesScreen()
  ];

  static const List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profile'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'History'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'Workout'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.fitness_center),
        label: 'Exercises'
    ),
  ];

  void getExercises() {
    if (exercises.isEmpty) {
      emit(GetExercises());
    }

    DioHelper.getdata(
      url: '/api/v2/exercisebaseinfo/', // Correct API endpoint
      query: {},
    ).then((value) {
      emit(GetExercises());

      // Assuming value?.data contains the API response body
      List<dynamic> data = value?.data['results'];  // Extract the list of exercises from 'results'

      // Convert the response into a list of Exercise objects
      ex = data.map((exerciseData) {
        return Exercise.fromJson(exerciseData);
      }).toList();

      // Printing the exercises to verify parsing
      for (var exercise in ex) {
       // print('Name: ${exercise.name}, Category: ${exercise.category}');
      }

      emit(GetExercises());
    }).catchError((error) {
      emit(GetExercisesError());
      print('Error occurred: ${error.toString()}');
    });
  }

  void exerciseUIPresses(Exercise exercise, context) {
    emit(NavigateToExerciseState());
    Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseWidget(exercise: exercise)));
  }

  void workoutUIPresses(context) {
    emit(StartWorkoutState());
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutTemplate()));
  }
}