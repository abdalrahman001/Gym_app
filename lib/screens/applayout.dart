import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:gym_tracker/cubit/diohelper.dart';
import 'package:gym_tracker/cubit/states.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            /*floatingActionButton:
            FloatingActionButton(
              onPressed: () {
                DioHelper.getdata(
                  url: 'v1/exercises?',  // Correct method call
                  query: {
                    'X-Api-Key' :'0W8iOKFt7H0oHdIsDeExWg==aaHNwW1nhvdzDubf',
                    'muscle': 'biceps',
                  },
                ).then((value) {
                  exercises=List<Map<String,dynamic>>.from(value?.data);
                  exercises.forEach((exercise) {
                    print(exercise['name']);
                  });

                }).catchError((error) {  // Correct way to handle errors
                  print('Error occurred');
                  print(error.toString());
                });
              },),*/

              /*appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeTheme();

                  },
                  icon: Icon(Icons.settings),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),*/
            body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
            backgroundColor: Theme.of(context).colorScheme.background,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onTap:(index)
              {
                AppCubit.get(context).bottomNavbarSwap(index);
                if (index==3){
                  AppCubit.get(context).emit(GetExercises());
                  AppCubit.get(context).getExercises();
                }
                },
              currentIndex: AppCubit.get(context).currentIndex,
              items:AppCubit.bottomItem,
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      ),
    );
  }
}
