import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../models/script_model.dart';

class ScriptProvider with ChangeNotifier {
  List<ScriptTopic> _topics = [];
  bool _isLoading = true;

  List<ScriptTopic> get topics => _topics;
  bool get isLoading => _isLoading;

  ScriptProvider() {
    loadTopics();
  }

  Future<void> loadTopics() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/data/scripts.json',
      );
      final List<dynamic> data = json.decode(response);
      _topics = data.map((json) => ScriptTopic.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading scripts: $e");
      _isLoading = false;
      notifyListeners();
    }
  }
}
