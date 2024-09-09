import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/assets/widgets.dart';
import 'package:gym_tracker/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:gym_tracker/cubit/states.dart';

class Exersises extends StatelessWidget {
  const Exersises.Exercises({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        late List<Map<String,dynamic>> myexercises=AppCubit.get(context).exercises;
        return Scaffold(
          appBar: AppBar(
            title:( Text("Exercises",style: TextStyle(color: Theme.of(context).colorScheme.secondary),)),
            backgroundColor: Theme.of(context).colorScheme.background,
            ),
          body:
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Expanded(
                child: ConditionalBuilder(
                  condition: myexercises.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => ExerciseUI(myexercises[index],context),
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
                    itemCount: myexercises.length,
                    physics: BouncingScrollPhysics(),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ));
      }
    );
  }
}
