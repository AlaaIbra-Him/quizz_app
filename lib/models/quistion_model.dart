class QuestionModel {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }

  List<String> get allAnswers {
    final answers = [...incorrectAnswers, correctAnswer];
    answers.shuffle();
    return answers;
  }
}
