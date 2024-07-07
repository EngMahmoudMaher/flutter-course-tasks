import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dalil_muslim/%D8%A7%D9%84%D9%85%D9%82%D8%AF%D9%85%D8%A9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'content/أحاديث.dart';
import 'content/استماع.dart';
import 'content/القران.dart';
import 'content/تسبيح.dart';

void main() {
  runApp(MaterialApp(
    home: Splach(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

var _currentIndex = 0;
final List<StatelessWidget> Screens = [const QuranScreen(), AhadithApp(), const TasbihApp(), const TelegramBotApp()];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Screens = [const QuranScreen(), AhadithApp(), const TasbihApp(), const TelegramBotApp()];

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/img/img.png',
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SignInButtonBuilder(
                        text: 'home page',
                        icon: Icons.home,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (d) {
                            return const MyApp();
                          }));
                        },
                        backgroundColor: Colors.blueGrey[700]!,
                        width: 220.0,
                      ),
                      const Divider(),
                      SignInButtonBuilder(
                        text: 'بقاء القران في الخلفية',splashColor: Colors.black,

                        icon: Icons.play_arrow,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (d) {
                            return const MyApp();
                          }));
                        },
                        backgroundColor: Colors.redAccent.shade100,
                        width: 220.0,
                      ),
                      const Divider(),
                      SignInButton(
                        Buttons.Google,
                        text: "contact me on google",
                        onPressed: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'mahmoudmaher2042@gmail.com',
                            query:
                                'subject=Hello&body=This is the body of the email',
                          );
                          final String url = params.toString();

                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                          }
                        },
                      ),
                      const Divider(),
                      SignInButton(
                        text: "contact me on facebook",
                        Buttons.FacebookNew,
                        onPressed: () async {
                          const url =
                              "https://www.facebook.com/profile.php?id=100012196924372&mibextid=ZbWKwL";
                          if (await canLaunch(url)) await launch(url);
                        },
                      ),
                      const Divider(),
                      SignInButton(
                        Buttons.Hotmail,
                        text: "contact on whatsapp",
                        onPressed: () async {
                          const url =
                              "https://wa.me/201024872780";
                          if (await canLaunch(url)) await launch(url);
                        },
                      ),
                      const Divider(),
                      SignInButton(
                        Buttons.GitHub,
                        text: "contact on GitHub",
                        onPressed: () async {
                          const url = "https://github.com/mahmoudmaher2042";
                          if (await canLaunch(url)) await launch(url);
                        },
                      ),
                      const Divider(),
                      SignInButton(
                        Buttons.Microsoft,
                        text: "contact on  Microsoft ",
                        onPressed: () async {
                          const url = "https://myaccount.microsoft.com/";
                          if (await canLaunch(url)) await launch(url);
                        },
                      ),
                      const Divider(),
                      SignInButton(
                        Buttons.LinkedIn,
                        onPressed: () async {
                          const url =
                              "https://www.linkedin.com/in/mahmoud-maher-12451b231";
                          if (await canLaunch(url)) await launch(url);
                        },
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(
                          'Terms of Service | Privacy Policy',
                          style: TextStyle(color: Colors.black),
                        ),
                        Divider(),
                        Text(
                          'Created By Eng/ Mahmoud Maher',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() {
              _currentIndex = i;
            }),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(FlutterIslamicIcons.quran),
                title: const Text("القران الكريم"),
                selectedColor: Colors.purple,
              ),

              SalomonBottomBarItem(
                icon: const Icon(FlutterIslamicIcons.prayer),
                title: const Text("الأذكار"),
                selectedColor: Colors.pink,
              ),

              SalomonBottomBarItem(
                icon: const Icon(FlutterIslamicIcons.solidTasbih),
                title: const Text("السبحة"),
                selectedColor: Colors.orange,
              ),

              SalomonBottomBarItem(
                icon: const Icon(FlutterIslamicIcons.takbir),
                title: const Text("استماع"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ),
          body: Screens[_currentIndex]),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
