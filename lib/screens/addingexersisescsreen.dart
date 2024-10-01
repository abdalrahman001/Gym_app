import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/assets/widgets.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:gym_tracker/cubit/states.dart';

class Exercises extends StatelessWidget {
  final bool isReplacing;  // Flag to indicate if it's a replacement
  final int? replaceIndex; // Optional index if replacing an exercise

  // Constructor to accept whether adding or replacing
  const Exercises({Key? key, required this.isReplacing, this.replaceIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // Retrieve the list of exercises from the AppCubit
        List<Exercise> exercises = AppCubit.get(context).ex;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Select Exercise",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: exercises.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        // When the user selects an exercise
                        if (isReplacing && replaceIndex != null) {
                          // If replacing an exercise, return with the selected one
                          Navigator.pop(context, {'exercise': exercises[index], 'replaceIndex': replaceIndex});
                        } else {
                          // If adding a new exercise, just return the selected one
                          Navigator.pop(context, {'exercise': exercises[index]});
                        }
                      },
                      child: ExerciseUI(exercises[index], context),  // Display exercise UI
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: exercises.length,
                    physics: BouncingScrollPhysics(),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator()),  // Show loader if no exercises
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
