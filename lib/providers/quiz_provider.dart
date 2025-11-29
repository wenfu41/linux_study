import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  List<Quiz> _quizzes = [];
  bool _isLoading = true;
  int _currentScore = 0;
  int _totalAnswered = 0;

  List<Quiz> get quizzes => _quizzes;
  bool get isLoading => _isLoading;
  int get currentScore => _currentScore;
  int get totalAnswered => _totalAnswered;

  QuizProvider() {
    loadQuizzes();
    loadProgress();
  }

  Future<void> loadQuizzes() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/data/quizzes.json',
      );
      final List<dynamic> data = json.decode(response);
      _quizzes = data.map((json) => Quiz.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading quizzes: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _currentScore = prefs.getInt('quiz_score') ?? 0;
    _totalAnswered = prefs.getInt('quiz_total') ?? 0;
    notifyListeners();
  }

  Future<void> updateProgress(bool isCorrect) async {
    _totalAnswered++;
    if (isCorrect) {
      _currentScore++;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_score', _currentScore);
    await prefs.setInt('quiz_total', _totalAnswered);
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _currentScore = 0;
    _totalAnswered = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_score', 0);
    await prefs.setInt('quiz_total', 0);
    notifyListeners();
  }
}
