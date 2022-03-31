class Question {
  final int id;
  final String questionText;
  final int questionAnswer;

  const Question({
    required this.id,
    required this.questionText,
    required this.questionAnswer,
  });

  @override
  String toString() {
    return 'Question{questionText: $questionText, questionAnswer: $questionAnswer}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'questionAnswer': questionAnswer,
    };
  }
}
