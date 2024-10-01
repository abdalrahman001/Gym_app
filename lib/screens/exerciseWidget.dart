import 'package:flutter/material.dart';
import 'package:gym_tracker/assets/widgets.dart';

class ExerciseWidget extends StatelessWidget {
  ExerciseWidget({Key? key,required this.exercise}) : super(key: key);
  Exercise exercise;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name,style: TextStyle(color:Theme.of(context).colorScheme.secondary ),),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(padding: EdgeInsets.all(10),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Instructions",style: TextStyle(fontSize: 30)),
            SizedBox.fromSize(size:Size.fromHeight(30) ),
            Text(exercise.instructions,style: TextStyle(fontSize:15 ),),
          ],
        )),
    );
  }
}
