import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool textState = false;
  bool checkedBox = false;
  bool signIn = true;

  bool isPasswordVisible = false;

  void textUpdate(bool newTextState) {
    textState = newTextState;
    notifyListeners();
  }

  void checkedBoxUpdate(bool newcheckedBox) {
    checkedBox = newcheckedBox;
    notifyListeners();
  }

  void signInUpdate(bool newsignIn) {
    signIn = newsignIn;
    print(signIn);
    notifyListeners();
  }

  void PasswordVisibleUpdate(bool newPasswordVisible) {
    isPasswordVisible = newPasswordVisible;
    notifyListeners();
  }
}
