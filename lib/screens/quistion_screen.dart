import 'package:flutter/material.dart';
import 'package:my_sec_app/provider/quiz_provider.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const QuestionsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<QuizProvider>(
        context,
        listen: false,
      ).fetchQuestions(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (provider.isFinished) {
      return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          title: const Text("Result", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 100),
              const SizedBox(height: 20),
              const Text(
                "Congratulations!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "You scored ${provider.score} out of ${provider.questions.length}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Score: ${(provider.score / provider.questions.length * 100).toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                ),
                child: const Text("Back to Categories"),
              ),
            ],
          ),
        ),
      );
    }

    final question = provider.questions[provider.currentIndex];
    final answers = question.allAnswers;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Question ${provider.currentIndex + 1}/${provider.questions.length}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ...answers.map((answer) {
              final isCorrect = answer == question.correctAnswer;
              final isSelected = answer == provider.selectedAnswer;

              Color? color;
              if (provider.answered && isSelected) {
                color = isCorrect ? Colors.green : Colors.red;
              } else if (provider.answered && isCorrect) {
                color = Colors.green;
              }

              return Card(
                color: color,
                child: ListTile(
                  title: Text(answer),
                  onTap: () {
                    provider.checkAnswer(answer);
                  },
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "quize"),
        ],
      ),
    );
  }
}
