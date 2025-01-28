import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true; // Track loading state

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading; // Expose loading state

  authProvider() {
    _loadLoginState(); // Load login state during initialization
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _isLoading = false; // Once loading is complete, set loading to false
    notifyListeners();
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    _isLoggedIn = false;
    notifyListeners();
  }
}

class AppState with ChangeNotifier {
  bool textState = false;
  bool checkedBox = false;
  bool signIn = true;

  double TempState = 0.0;
  bool isTempStateReady = false;

  bool isPasswordVisible = false;

  void textUpdate(bool newTextState) {
    textState = newTextState;
    notifyListeners();
  }

  void checkedBoxUpdate(bool newCheckedBox) {
    checkedBox = newCheckedBox;
    notifyListeners();
  }

  void signInUpdate(bool newSignIn) {
    signIn = newSignIn;
    notifyListeners();
  }

  void PasswordVisibleUpdate(bool newPasswordVisible) {
    isPasswordVisible = newPasswordVisible;
    notifyListeners();
  }

  final DatabaseReference dbr = FirebaseDatabase.instance.ref();

  AppState() {
    _listenToDataChanges(); // Start listening to Firebase changes
  }

  void _listenToDataChanges() {
    dbr.child("Data").onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map;
        final temperature = double.tryParse(data["Temperature"].toString()) ?? 0.0;

        TempState = temperature;
        isTempStateReady = true;
        notifyListeners();
      }
    });
  }

  void TempStateUpdate(double newTempState) {
    TempState = newTempState;
    isTempStateReady = true;
    notifyListeners();
  }
}
