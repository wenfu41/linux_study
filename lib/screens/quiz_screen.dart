import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  bool _answered = false;
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.quizzes.isEmpty) {
          return const Center(child: Text("暂无练习题"));
        }

        final quiz = provider.quizzes[_currentIndex];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProgressCard(provider),
              const SizedBox(height: 24),
              Text(
                "问题 ${_currentIndex + 1} / ${provider.quizzes.length}",
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 8),
              Text(
                quiz.question,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(quiz.options.length, (index) {
                return _buildOptionCard(index, quiz, provider);
              }),
              const SizedBox(height: 24),
              if (_answered) _buildExplanationCard(quiz),
              const SizedBox(height: 24),
              if (_answered)
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex < provider.quizzes.length - 1) {
                      setState(() {
                        _currentIndex++;
                        _answered = false;
                        _selectedOptionIndex = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("恭喜！你已完成所有练习。")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    _currentIndex < provider.quizzes.length - 1 ? "下一题" : "完成",
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressCard(QuizProvider provider) {
    return Card(
      color: const Color(0xFF2C2C2C),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text("总答题", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  "${provider.totalAnswered}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text("正确率", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  provider.totalAnswered == 0
                      ? "0%"
                      : "${((provider.currentScore / provider.totalAnswered) * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                provider.resetProgress();
              },
              tooltip: "重置进度",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(int index, Quiz quiz, QuizProvider provider) {
    bool isSelected = _selectedOptionIndex == index;
    bool isCorrect = index == quiz.correctIndex;

    Color? borderColor;
    Color? backgroundColor;

    if (_answered) {
      if (isCorrect) {
        borderColor = Colors.green;
        backgroundColor = Colors.green.withOpacity(0.1);
      } else if (isSelected && !isCorrect) {
        borderColor = Colors.red;
        backgroundColor = Colors.red.withOpacity(0.1);
      }
    } else if (isSelected) {
      borderColor = Theme.of(context).colorScheme.primary;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: borderColor != null
            ? BorderSide(color: borderColor, width: 2)
            : BorderSide.none,
      ),
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: InkWell(
        onTap: _answered
            ? null
            : () {
                setState(() {
                  _selectedOptionIndex = index;
                  _answered = true;
                });
                provider.updateProgress(index == quiz.correctIndex);
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: _answered && isCorrect
                    ? Colors.green
                    : (_answered && isSelected ? Colors.red : Colors.grey[700]),
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(quiz.options[index])),
              if (_answered && isCorrect)
                const Icon(Icons.check_circle, color: Colors.green),
              if (_answered && isSelected && !isCorrect)
                const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationCard(Quiz quiz) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text(
                "解析",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(quiz.explanation),
        ],
      ),
    );
  }
}
