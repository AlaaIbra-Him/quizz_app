import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:my_sec_app/models/quistion_model.dart';

class QuizProvider with ChangeNotifier {
  final Dio _dio = Dio();

  List<QuestionModel> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  String? _selectedAnswer;
  bool _isLoading = false;

  List<QuestionModel> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get answered => _answered;
  String? get selectedAnswer => _selectedAnswer;
  bool get isLoading => _isLoading;

  Future<void> fetchQuestions(int categoryId) async {
    _isLoading = true;
    notifyListeners();

    final url =
        "https://opentdb.com/api.php?amount=10&category=$categoryId&type=multiple";
    final response = await _dio.get(url);
    final results = response.data['results'] as List;

    _questions = results.map((e) => QuestionModel.fromJson(e)).toList();
    _currentIndex = 0;
    _score = 0;
    _answered = false;
    _selectedAnswer = null;
    _isLoading = false;
    notifyListeners();
  }

  void checkAnswer(String answer) {
    if (_answered) return;

    _answered = true;
    _selectedAnswer = answer;

    if (answer == _questions[_currentIndex].correctAnswer) {
      _score++;
    }
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _answered = false;
        _selectedAnswer = null;
        notifyListeners();
      }
    });
  }

  bool get isFinished => _currentIndex >= _questions.length - 1 && _answered;

  void resetQuiz() {
    _questions = [];
    _currentIndex = 0;
    _score = 0;
    _answered = false;
    _selectedAnswer = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> restartQuiz(int categoryId) async {
    await fetchQuestions(categoryId); 
  }
}
