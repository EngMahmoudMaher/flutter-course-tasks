import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garduation_project/app%20screens/homepage.dart';
import 'package:garduation_project/app%20screens/setting_app.dart';
import 'package:garduation_project/app%20screens/user_data.dart';
import 'package:garduation_project/auth/sign%20in/signin.dart';
import 'package:garduation_project/introduction%20screen/splach.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check if the user is already logged in
  bool isLoggedIn = await _getLoginState();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

Future<bool> _getLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomePage() : const SplashScreen(),
      routes: {
        'HomePage': (context) => const HomePage(),
        'SigninPage': (context) => const SigninPage(),
        'SettingPage': (context) => const SettingPage(),
        'userDataPage': (context) => const userDataPage(),
      },
    );
  }
}
