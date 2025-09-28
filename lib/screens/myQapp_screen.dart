// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:my_sec_app/models/Category_Model.dart';

// class myQapp extends StatefulWidget {
//   const myQapp({super.key});

//   @override
//   State<myQapp> createState() => _myQappState();
// }

// class _myQappState extends State<myQapp> {
//   final String baseUrl = "https://opentdb.com";
//   final String endPoint = "/api_category.php";
//   final Dio _dioService = Dio();
//   List<CategoryModel> _categories = [];

//   @override
//   void initState() {
//     super.initState();
//     _dioService.get(baseUrl + endPoint).then((value) {
//       print(value);
//       final data = value as Map<String, dynamic>;
//       final category = data['trivia_categories'] as List;

//       _categories = category.map((ele) {
//         return CategoryModel.fromJson(ele);
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
