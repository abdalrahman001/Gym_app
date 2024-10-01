import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/assets/widgets.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:gym_tracker/cubit/states.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);  // Fixed the constructor

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(AppCubit.get(context).ex.isEmpty){
          print("Empty");
        }else{
          print("NotEmpty");
        }
      },
      builder: (context, state) {
        List<Exercise> exercises = AppCubit.get(context).ex;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Exercises",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: exercises.isNotEmpty,  // Check if exercises list is not empty
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => ExerciseUI(exercises[index], context),  // Build ExerciseUI for each exercise
                    separatorBuilder: (context, index) => SizedBox(height: 20),  // Add space between items
                    itemCount: exercises.length,  // Number of exercises
                    physics: BouncingScrollPhysics(),  // Add bounce effect to scrolling
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator()),  // Show loader if exercises are not loaded
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
