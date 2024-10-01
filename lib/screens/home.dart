import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:gym_tracker/cubit/states.dart';
import '../assets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Workout> myWorkouts = [];
    for (int i = 0; i < 7; i++) {
      myWorkouts
          .add(Workout(name: 'Workout$i', date: formatDate(DateTime.now())));
      for (int j = 0; j < 7; j++) {
        myWorkouts[i]
            .addExersise(Exercise(name: 'Shoulder$j', category: 'Press$j', instructions: ''));
      }
    }
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Workouts",style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
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
            body:
               Container(
                 padding: EdgeInsets.all(10),
                 child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Theme.of(context).colorScheme.primary,),
                      width: MediaQuery.of(context).size.width,
                        child: TextButton(onPressed: (){}, child: 
                        Text('Start an empty workout',style: TextStyle(color: Theme.of(context).colorScheme.secondary,),))),

                    Expanded(
                      child: ListView.separated(
                          itemCount: myWorkouts.length,
                          itemBuilder: (context, index) {
                            return WorkoutUI(
                                workout: myWorkouts[index], context: context);
                          },
                          separatorBuilder: (context, index) => SizedBox.fromSize(
                                size: Size(20, 10),
                              )),
                    ),
                  ],
              ),
               ),

            backgroundColor: Theme.of(context).colorScheme.background,

          );
        },
      ),
    );
  }
}
