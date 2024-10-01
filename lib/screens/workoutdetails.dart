import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:gym_tracker/cubit/states.dart';
import '../assets/widgets.dart';
import 'addexersisescreen.dart';
import 'exersises.dart';


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
                      AppCubit.get(context).getExercises();
                      AppCubit.get(context).emit(ChoosingExerciseState());
                      Navigator.push(context, 
                      MaterialPageRoute(builder:(context)=> AddExercisesScreen(isReplacing: true,workout: workout,replaceIndex: index,))
                      );
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

          onPressed: (){
            AppCubit.get(context).emit(GetExercises());
            AppCubit.get(context).getExercises();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ExercisesScreen(),
              ),
            );

          },  // Call add exercise method
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),

    )
);
  }
}
