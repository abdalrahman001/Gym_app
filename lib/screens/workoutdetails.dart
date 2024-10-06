import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:gym_tracker/cubit/states.dart';
import '../assets/widgets.dart';


class WorkoutDetailScreen extends StatelessWidget{
 final Workout workout;
 WorkoutDetailScreen({Key? key,required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context)=>AppCubit(),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context, state) =>Scaffold(
        appBar: AppBar(
          title: Text('Exercises in ${workout.name}'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: ListView.separated(
          itemCount: workout.exercises.length,
          itemBuilder: (context, index) {
            Exercise exercise = workout.exercises[index];
            return ListTile(
              title: Text(exercise.name),
              subtitle: Text(exercise.instructions),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    onPressed: () {
                        AppCubit.get(context).addExercise(context);
                    },
                    icon: Icon(Icons.swap_horiz),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppCubit.get(context).createDatabase();
            AppCubit.get(context).insertDatabase("1", 'blah', 'instructions', 'category');
            AppCubit.get(context).addExercise(context);

          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),


      ),

    )
);
  }
}
