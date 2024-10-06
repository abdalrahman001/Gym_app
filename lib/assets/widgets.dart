import 'package:flutter/material.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:intl/intl.dart';

import '../screens/workoutdetails.dart';

class Workout{
  late String name;
  late String date;
  List <Exercise> exercises=[];
  Workout({required this.name,required this.date});
  void addExersise(Exercise exercise){
    exercises.add(exercise);
  }
}
class Exercise {
  late String instructions;
  late String name;
  late String category;

  Exercise({
    required this.name,
    required this.category,
    required this.instructions,
  });


}
Widget WorkoutUI({required Workout workout, required BuildContext context}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutDetailScreen(workout: workout),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Last performed: ${workout.date}"),
          SizedBox(height: 10),
          ...workout.exercises.map((exercise) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.name),
                SizedBox(height: 5),
              ],
            );
          }),
        ],
      ),
    ),
  );
}

void myprint(String s){
  print(s);
}
String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Example format: 2024-09-03
}
  Widget ExerciseUI(Exercise ex, context) {
    return InkWell(
      onTap: () {
        AppCubit.get(context).exerciseUIPresses(ex, context);
      },
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ex.name,  // Display the exercise name
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),  // Add spacing between texts if needed
              Text(
                ex.category,  // Display the exercise instructions
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget ExerciseUIWorkout(Exercise ex, context, {required Workout workout, bool isReplacing = false}) {
  return InkWell(
    onTap: () {
      if (isReplacing) {
        // If replacing, replace an existing exercise in the workout
        workout.exercises[0] = ex; // Replace the first exercise (can be customized)
      } else {
        // Otherwise, add the new exercise to the workout
        workout.addExersise(ex);
      }

      // Go back to the WorkoutDetailScreen
      Navigator.pop(context);
    },
    child: SizedBox(
      height: 90,
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ex.name,  // Display the exercise name
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              ex.category,  // Display the exercise instructions
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    ),
  );
}
