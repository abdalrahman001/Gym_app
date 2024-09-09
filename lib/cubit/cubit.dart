import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/states.dart';
import 'package:gym_tracker/screens/exerciseWidget.dart';
import 'package:gym_tracker/screens/exersises.dart';
import 'package:gym_tracker/screens/history.dart';
import 'package:gym_tracker/screens/home.dart';
import 'package:gym_tracker/screens/profile.dart';
import 'package:gym_tracker/themes/apptheme.dart';

import 'diohelper.dart';

class AppCubit extends Cubit<AppStates>{
  ThemeData currentTheme=darkTheme;
  AppCubit():super (InitStates());
  static AppCubit get(context){
    return BlocProvider.of(context);
  }
  List<Map<String,dynamic>> exercises=[];

  int currentIndex=0;

  void changeTheme(){
      if(currentTheme==darkTheme){
        print("Switching to light");
        currentTheme=lightTheme;
        emit(ChangeThemeState());
      }else{
        print("Switching to Dark");
        currentTheme=darkTheme;
        emit(ChangeThemeState());
      }

  }
  void bottomNavbarSwap(int index){
      currentIndex=index;
      emit(BottomBarChangingState());
  }
  List<Widget> screens=[
    Profile(),
    History(),
    Home(),
    Exersises.Exercises()
  ];
  static const List<BottomNavigationBarItem> bottomItem=[
  BottomNavigationBarItem(
  icon: Icon(Icons.account_circle), label: 'Profile'),
  BottomNavigationBarItem(
  icon: Icon(Icons.history), label: 'History'),
  BottomNavigationBarItem(
  icon: Icon(Icons.add), label: 'Workout'),
  BottomNavigationBarItem(
  icon: Icon(Icons.fitness_center), label: 'Exersises')
];
  void getExercises(){
    if (exercises.length==0){
        emit(GetExercises());
    }
    DioHelper.getdata(
      url: 'v1/exercises?',  // Correct method call
      query: {
        'X-Api-Key' :'0W8iOKFt7H0oHdIsDeExWg==aaHNwW1nhvdzDubf',

      },
    ).then((value) {
      emit(GetExercises());
      exercises=List<Map<String,dynamic>>.from(value?.data);
    }).catchError((error) {
      emit(GetExercisesError());
      print('Error occurred');
      print(error.toString());
    });
  }


  void exerciseUIPresses(Map<String,dynamic> exercise,context){
    emit(NavigateToExerciseState());
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ExerciseWidget(exercise: exercise,)));

  }
}
