

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/cubit.dart';
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
            appBar: AppBar(
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
            ),
            body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
            backgroundColor: Theme.of(context).colorScheme.background,
            bottomNavigationBar: BottomNavigationBar(
              onTap:(index)
              {AppCubit.get(context).bottomNavbarSwap(index);},
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
