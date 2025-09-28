import 'package:flutter/material.dart';
import 'package:my_sec_app/screens/category_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CategoryScreen());
  }
}
