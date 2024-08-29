import 'package:flutter/material.dart';
import 'package:meals_app/screens/areas_screen.dart';

void main() {
  runApp(const MealsApp());
}



class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mael App',
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AreasScreen(),

      

    );
  }
}