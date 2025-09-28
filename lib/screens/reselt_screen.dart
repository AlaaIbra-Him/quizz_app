// import 'package:flutter/material.dart';
// import 'package:my_sec_app/provider/quiz_provider.dart';
// import 'package:my_sec_app/screens/category_screen.dart';
// import 'package:provider/provider.dart';

// class ResultScreen extends StatelessWidget {
//   final int categoryId; 
//   final String categoryName;

//   const ResultScreen({
//     super.key,
//     required this.categoryId,
//     required this.categoryName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final quizProvider = Provider.of<QuizProvider>(context, listen: false);

//     return Scaffold(
//       backgroundColor: Colors.green[400],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Congratulations! ",
//               style: TextStyle(
//                 fontSize: 28,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Your Score: ${quizProvider.score}/${quizProvider.questions.length}",
//               style: const TextStyle(fontSize: 22, color: Colors.white),
//             ),
//             const SizedBox(height: 40),

//             ElevatedButton(
//               onPressed: () async {
//                 await quizProvider.restartQuiz(categoryId);
//                 Navigator.pop(context); 
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.green,
//               ),
//               child: const Text("Restart Quiz"),
//             ),
//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () {
//                 quizProvider.resetQuiz();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CategoryScreen()),
//                   (route) => false,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.green,
//               ),
//               child: const Text("Back to Categories"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
