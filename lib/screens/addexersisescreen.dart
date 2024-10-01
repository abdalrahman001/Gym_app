import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/assets/widgets.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:gym_tracker/cubit/states.dart';

class AddExercisesScreen extends StatelessWidget {
  final bool isReplacing;  // Flag to indicate if it's a replacement
  final int? replaceIndex; // Optional index if replacing an exercise
  final Workout workout;
  const AddExercisesScreen({Key? key, required this.isReplacing, this.replaceIndex,required this.workout }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Exercise> exercises = AppCubit.get(context).ex;  // Fetch exercises

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
