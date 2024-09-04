import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late String name;
  late String Category;
  Exercise({required this.name,required this.Category});

}

Widget WorkoutUI ({required Workout workout,required BuildContext context}){

  return
     Container(
      padding:EdgeInsets.all(15)
      ,decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(20),border: Border.all(
      color: Colors.grey,
      width: 0.5
    )

    ) ,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(workout.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),SizedBox(height: 10,),
          Text("Last perfomed : ${workout.date}"),
            SizedBox(height: 10,),
                 ...workout.exercises.map((exercise){
               return Column(
                 children: [
                   Text(exercise.name,),
                   SizedBox(height: 5,)
                 ],
               );
               })

          ],


      ),


);}
void myprint(String s){
  print(s);
}
String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Example format: 2024-09-03
}
