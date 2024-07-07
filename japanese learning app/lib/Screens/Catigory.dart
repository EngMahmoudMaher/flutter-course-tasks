import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lutter_training_course/Screens/ai%20tools/copilot.dart';
import 'package:lutter_training_course/Screens/ai%20tools/gemini.dart';
import 'package:lutter_training_course/Screens/colors/Colors.dart';
import 'package:lutter_training_course/Screens/Family/Family%20Members.dart';
import 'package:lutter_training_course/Screens/numbers/Members.dart';
import 'package:lutter_training_course/Screens/phrases/Phrases.dart';
import 'package:lutter_training_course/Screens/phrases/phrases%20sounds.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ai tools/chat gpt.dart';

void main() {
  runApp(const MyApp());
}

bool darkmode = false;
dynamic dark = Colors.black;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Category(),
    );
  }
}

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      darkmode = _themeMode == ThemeMode.dark;
      dark = darkmode ? Colors.black : Colors.white;
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    void handleMenuButtonPressed() {
      _advancedDrawerController.showDrawer();
    }

    return AdvancedDrawer(
      backdrop: Container(

        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              darkmode
                  ? Colors.purpleAccent
                  : (darkmode == false ? Colors.grey : dark),
              darkmode
                  ? Colors.black
                  : (darkmode == false ? Colors.white : dark)
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.purpleAccent,
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
                  'assets/images/tenor.gif',
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButtonBuilder(
                          text: 'Dark Mode',
                          icon: Icons.dark_mode_outlined,
                          onPressed: () {
                            _toggleTheme();
                          },
                          backgroundColor: Colors.blueGrey[700]!,
                          width: 220.0,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButton(
                          Buttons.Google,
                          text: "Contact me on Google",
                          onPressed: () async {
                            final Uri params = Uri(
                              scheme: 'mailto',
                              path: 'mahmoudmaher2042@gmail.com',
                              query:
                                  'subject=Hello&body=This is the body of the email',
                            );
                            final String url = params.toString();

                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButton(
                          text: "Contact me on Facebook",
                          Buttons.FacebookNew,
                          onPressed: () {
                            runUrl(
                                "https://www.facebook.com/profile.php?id=100012196924372&mibextid=ZbWKwL");
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButton(
                          Buttons.Hotmail,
                          text: "Contact on WhatsApp",
                          onPressed: () {
                            runUrl("https://wa.me/201024872780");
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButton(Buttons.GitHub, text: "Contact on GitHub",
                            onPressed: () {
                          runUrl("https://github.com/EngMahmoudMaher");
                        }),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButton(
                          Buttons.Microsoft,
                          text: "Contact on Microsoft",
                          onPressed: () {
                            runUrl("https://myaccount.microsoft.com/");
                          },
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SignInButton(
                          text: "Contact on LinkedIn",
                          Buttons.LinkedIn,
                          onPressed: () {
                            runUrl(
                                "https://www.linkedin.com/in/eng-mahmoud-maher-69997b287");
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(width: 220,
                          height: 40,
                          color: Colors.white,
                          child: Row(
                            children: [const Image(image: AssetImage("assets/images/ai tools/chatGpt.png"),width: 30,height: 30,),
                              Center(
                                child: TextButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (d){
                                    return const ChatGptApp();
                                  }));
                                }, child: Text("ChatGpt",style: TextStyle(
                                    color: darkmode ? Colors.orange : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,

                                ),
                                ),),
                              ),
                            ],
                          )
                            ,),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(width: 220,
                          height: 40,
                          color: Colors.purple,
                          child: Row(
                            children: [const Image(image: AssetImage("assets/images/ai tools/Gemini.png"),width: 30,height: 30,),
                              Center(
                                child: TextButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (d){
                                  return const GeminiApp();
                                }));}, child: Center(
                                  child: Text("Gemini",style: TextStyle(
                                      color: darkmode ? Colors.orange : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,

                                  ),
                                  ),
                                ),),
                              ),
                            ],
                          )
                          ,),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(width: 220,
                          height: 40,
                          color: Colors.white,
                          child: Row(
                            children: [const Image(image: AssetImage("assets/images/ai tools/copilot.png"),width: 30,height: 30,),
                              Center(
                                child: TextButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (d){
                                  return const CopilotApp();
                                }));}, child: Center(
                                  child: Text("Copilot",style: TextStyle(
                                    color: darkmode ? Colors.orange : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,

                                  ),
                                  ),
                                ),),
                              ),
                            ],
                          )
                          ,),
                      ),
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
                  child:  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(
                          'Terms of Service | Privacy Policy',
                          style: TextStyle(color:darkmode ? Colors.orange : Colors.black),
                        ),
                        const Divider(),
                        Text(
                          'Created By Eng/ Mahmoud Maher',
                          style: TextStyle(color:darkmode ? Colors.orange : Colors.black),
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        home: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Categories",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lemon',
                ),
              ),
            ),
            leading: IconButton(
              onPressed: handleMenuButtonPressed,
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
          body: ListView(
            children: [
              _buildCard(
                  'Members', 'assets/images/categories/numbers.png', const Numbers()),
              _buildCard('Family Members', 'assets/images/family_members/family.png',
                  const FamilyMembers()),
              _buildCard('Colors', 'assets/images/categories/colors.png', const ColorPage()),
              _buildCard(
                  'Phrases', 'assets/images/categories/phrases.png', const PhraseSounds()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String imagePath, Widget page) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imagePath,
                opacity: const AlwaysStoppedAnimation(0.8),
                fit: BoxFit.fitHeight,
                width: double.infinity,
                height: 180,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black54,
              ),
              width: double.infinity,
              height: 200.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void runUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}
