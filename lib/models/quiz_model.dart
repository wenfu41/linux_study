class Quiz {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  Quiz({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'] as String,
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'] as int,
      explanation: json['explanation'] as String,
    );
  }
}
