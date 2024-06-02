import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user; // Declare a user variable

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user; // Define a getter for the user

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      _isLoggedIn = true;
      notifyListeners();
    } catch (error) {
      _isLoggedIn = false;
      print('Login Error: $error');
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Set isLoggedIn to true after successful signup
      _isLoggedIn = true;
      // Update the user variable with the newly created user
      _user = userCredential.user;
      notifyListeners();
    } catch (error) {
      // Handle signup errors, if any
      print('Signup Error: $error');
      throw error; // Rethrow the error to handle it in the UI
    }
  }


  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void checkAuthStatus() {
    // Add logic to check if the user is logged in (e.g., check a token)
    // For now, we'll assume the user is not logged in
    _isLoggedIn = false;
    notifyListeners();
  }
}
