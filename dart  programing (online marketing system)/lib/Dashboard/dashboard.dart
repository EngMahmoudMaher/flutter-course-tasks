import 'dart:io';

import 'package:training/user/screens/user.dart';

import 'admin/screens/panel.dart';

void dashboardSelection() {
  print(" \t \t ..........welcome to our online market......... \t \t ");
  print(" 1 - user screen ");
  print(" 2 - admin screen ");
  print(" 3 - exit order \n");
  stdout.write("enter selection : ");
  int selection = int.parse(stdin.readLineSync()!);
  switch (selection) {
    case 1:
      UserScreen();
      break;
    case 2:
      adminPanel();
      break;
    case 3:
      exit(0);// Exit the program

  }
}
