class Question {
  final String questionText;
  final int questionAnswer;

  const Question({
    required this.questionText,
    required this.questionAnswer,
  });

  @override
  String toString() {
    return 'Question{questionText: $questionText, questionAnswer: $questionAnswer}';
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'questionAnswer': questionAnswer,
    };
  }
}
