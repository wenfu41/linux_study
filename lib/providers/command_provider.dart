import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../models/command_model.dart';

class CommandProvider with ChangeNotifier {
  List<LinuxCommand> _commands = [];
  List<LinuxCommand> _filteredCommands = [];
  bool _isLoading = true;

  List<LinuxCommand> get commands => _filteredCommands;
  bool get isLoading => _isLoading;

  CommandProvider() {
    loadCommands();
  }

  Future<void> loadCommands() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/data/commands.json',
      );
      final List<dynamic> data = json.decode(response);
      _commands = data.map((json) => LinuxCommand.fromJson(json)).toList();
      _filteredCommands = _commands;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading commands: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchCommands(String query) {
    if (query.isEmpty) {
      _filteredCommands = _commands;
    } else {
      _filteredCommands = _commands.where((command) {
        return command.name.toLowerCase().contains(query.toLowerCase()) ||
            command.description.toLowerCase().contains(query.toLowerCase()) ||
            command.fullDescription.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  List<String> get categories {
    return _commands.map((e) => e.category).toSet().toList();
  }

  List<LinuxCommand> getCommandsByCategory(String category) {
    return _commands.where((e) => e.category == category).toList();
  }
}
