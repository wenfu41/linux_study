import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../models/package_model.dart';

class PackageProvider with ChangeNotifier {
  List<LinuxPackage> _packages = [];
  bool _isLoading = true;

  List<LinuxPackage> get packages => _packages;
  bool get isLoading => _isLoading;

  PackageProvider() {
    loadPackages();
  }

  Future<void> loadPackages() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/data/packages.json',
      );
      final List<dynamic> data = json.decode(response);
      _packages = data.map((json) => LinuxPackage.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error loading packages: $e");
      _isLoading = false;
      notifyListeners();
    }
  }
}
