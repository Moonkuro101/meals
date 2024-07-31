import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealItemScreen extends StatelessWidget{
  const MealItemScreen({super.key,required this.meal});

  final Meal meal;



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar(title: Text(meal.title),),body: Text('Hi'),);
  }
}