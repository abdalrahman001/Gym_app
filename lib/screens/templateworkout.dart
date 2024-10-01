import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/cubit/cubit.dart';

import '../assets/widgets.dart';

class WorkoutTemplate extends StatelessWidget {
   WorkoutTemplate({Key? key,this.workout}) : super(key: key);

   final Workout? workout;
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        padding:EdgeInsets.all(5),
        children: [
          Expanded(
            child: ConditionalBuilder(
              condition: workout!.exercises.isNotEmpty,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => ExerciseUI(AppCubit.get(context).ex[index],context),
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                itemCount:  workout!.exercises.length,
                physics: BouncingScrollPhysics(),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      )
        );


  }
}
