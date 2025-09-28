import 'package:flutter/material.dart';
import 'package:my_sec_app/provider/category_provider.dart';
import 'package:my_sec_app/provider/quiz_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_sec_app/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
