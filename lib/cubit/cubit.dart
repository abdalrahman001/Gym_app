import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/states.dart';
import 'package:gym_tracker/screens/exersises.dart';
import 'package:gym_tracker/screens/history.dart';
import 'package:gym_tracker/screens/home.dart';
import 'package:gym_tracker/screens/profile.dart';
import 'package:gym_tracker/themes/apptheme.dart';

class AppCubit extends Cubit<AppStates>{
  ThemeData currentTheme=darkTheme;
  AppCubit():super (InitStates());
  static AppCubit get(context){
    return BlocProvider.of(context);
  }
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
    Exersises(),
    History(),
    Home(),
    Profile()
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

}