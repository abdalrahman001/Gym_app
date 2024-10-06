import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/states.dart';
import 'package:gym_tracker/screens/exerciseWidget.dart';
import 'package:gym_tracker/screens/history.dart';
import 'package:gym_tracker/screens/home.dart';
import 'package:gym_tracker/screens/profile.dart';
import 'package:gym_tracker/screens/templateworkout.dart';
import 'package:gym_tracker/themes/apptheme.dart';
import 'package:sqflite/sqflite.dart';
import '../assets/widgets.dart';
import '../screens/addexersisescreen.dart';
import '../screens/exersises.dart';
import 'diohelper.dart';

class AppCubit extends Cubit<AppStates> {
  ThemeData currentTheme = darkTheme;
  var Database;
  AppCubit() : super(InitStates());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

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

  Future<void> getExercises() async {
    emit(
        GetExercisesLoading()); // Emit loading state before making the API call

    try {
      final value = await DioHelper.getdata(
        url: 'exercises/',
        header: {
          "x-api-key": "il2SoM2zcXDiaKcyBdQbKxxY0JKWBomNR9uRkJ5q",
        },
        query: {
          "x-api-key": "il2SoM2zcXDiaKcyBdQbKxxY0JKWBomNR9uRkJ5q",
        },
      );

      // Check if the response data has 'exercises' as a list
      if (value?.data != null && value?.data.isNotEmpty) {
        print("notEmpty");

        // Loop through each exercise in the API response and insert it into the database
        for (var exerciseItem in value?.data) {
          // Insert each exercise into the database
          insertDatabase(
            exerciseItem['id'].toString(),
            // Assuming 'id' is part of the response
            exerciseItem['name'], // Exercise name
            exerciseItem['instructions'], // Instructions
            exerciseItem['muscle'], // Category or muscle group
          );
        }

        emit(
            GetExercisesSuccess()); // Emit success state after inserting data into the database
      } else {
        emit(GetExercisesEmpty()); // Emit empty state if no exercises found
      }
    } catch (error) {
      emit(GetExercisesError()); // Emit error state on failure
      print('Error occurred: ${error.toString()}');
    }
  }


  void exerciseUIPresses(Exercise exercise, context) {
    emit(NavigateToExerciseState());
    Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseWidget(exercise: exercise)));
  }

  void workoutUIPresses(context) {
    emit(StartWorkoutState());
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutTemplate()));
  }

  void addExercise(context) {
    emit(GetExercisesLoading());

    getExercises().then((value) {
        print('AppCubit ex is ${ex.isEmpty.toString()}');
        emit(ChoosingExerciseState());
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => ExercisesScreen(),
    ),
    );}
    );
  }
  void createDatabase()async{
     Database=await openDatabase(
      'ex.db',
      version: 1,
      onCreate: (Database,version) async {
        await Database.execute(
            'CREATE TABLE Exercise (id INTEGER PRIMARY KEY, name TEXT, instructions TEXT, category TEXT)');
        print("Created DB");
      },
        onOpen: (Database){
        print("DB OPENED");
        }
    );
  }

  void insertDatabase(String id, String name, String instructions, String category) async {
    await Database.transaction((txn) async {
      try {
        int value = await txn.rawInsert(
          'INSERT INTO Exercise(id, name, instructions, category) VALUES(?, ?, ?, ?)',
          [id, name, instructions, category],
        );
        print('Inserted: $value'); // Prints the inserted row's ID
      } catch (error) {
        print("Error inserting to DB: ${error.toString()}");
      }
    });
  }

  void deleteDatabase(){}
  void updateDatabase(){}
  void getDatabase(){}
}