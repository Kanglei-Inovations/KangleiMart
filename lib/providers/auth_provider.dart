import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
  });
}

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;

  String? get token {
    return _token;
  }

  String? get userId {
    return _userId;
  }
  User? get user {
    return user;
  }
  bool get isAuth {
    return token != null;
  }

  Future<void> login(String email, String password) async {
    // Simulate login logic
    _token = 'fake_token';
    _userId = 'fake_user_id';
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    // Simulate signup logic
    _token = 'fake_token';
    _userId = 'fake_user_id';
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}
