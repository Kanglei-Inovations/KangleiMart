import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;

  String? get token {
    return _token;
  }

  String? get userId {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  Future<void> login(String email, String password) async {
    // Implement login logic here
    // Set _token and _userId accordingly
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    // Implement signup logic here
    // Set _token and _userId accordingly
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}
