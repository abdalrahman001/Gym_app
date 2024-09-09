import 'package:flutter/material.dart';

class ExerciseWidget extends StatelessWidget {
  ExerciseWidget({Key? key,required this.exercise}) : super(key: key);
  Map<String,dynamic> exercise;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise['name'],style: TextStyle(color:Theme.of(context).colorScheme.secondary ),),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(padding: EdgeInsets.all(10),
        child: Text(exercise['instructions'],style: TextStyle(fontSize:15 ),)),
    );
  }
}
