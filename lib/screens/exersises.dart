import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../assets/widgets.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Exercise> exercises=AppCubit.get(context).ex;
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
                    condition: exercises.isNotEmpty,
                    // Show loading while API call is in progress
                    builder: (context) => ListView.separated(
                          itemBuilder: (context, index) =>
                              ExerciseUI(exercises[index], context),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemCount: exercises.length,
                          physics: BouncingScrollPhysics(),
                        ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator())),
              ),
            ],
          ),
        );
      },
    );
  }
}
