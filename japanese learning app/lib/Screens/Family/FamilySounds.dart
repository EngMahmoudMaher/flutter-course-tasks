import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../Catigory.dart';
import 'Family Members.dart';


void main() {
  runApp(const MyApp());
}

List<String> numbers = [
  "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
];

List<String> japaneseFamilyMembers = [
   'Chichi','Haha', 'Ani', 'Ane', 'Otouto', 'Imouto', 'Musuko', 'Musume', 'Sofu', 'Sobo',
];

List<String> englishFamilyMembers = [
   'Father','Mother', 'older Brother', 'older Sister', 'younger Brother', 'younger Sister', 'son', 'Daughter', 'Grandfather', 'Grandmother',
];

List<String> pathes = [
  "audios/family_members/father.wav", "audios/family_members/mother.wav", "audios/family_members/older brother.wav", "audios/family_members/older sister.wav",
  "audios/family_members/younger brother.wav", "audios/family_members/younger sister.wav", "audios/family_members/son.wav", "audios/family_members/daughter.wav",
  "audios/family_members/grand father.wav", "audios/family_members/grand mother.wav"
];

final player = AudioPlayer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(), // Define a dark theme
      themeMode: ThemeMode.system, // Use system theme settings
      home: const FamilySounds(),
    );
  }
}

class FamilySounds extends StatefulWidget {
  const FamilySounds({super.key});

  @override
  State<FamilySounds> createState() => _FamilySoundsState();
}

class _FamilySoundsState extends State<FamilySounds> {
  bool isPlaying = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
  }

  void _showAlertDialog(String title, String num) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: darkmode ? Colors.deepOrange : Colors.white,
          title: Center(
            child: Text(
              'Alert',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'lemon',
                color: darkmode ? Colors.white : Colors.black,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'lemon',
                  color: darkmode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                num,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'lemon',
                  color: darkmode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (s) {
                      return  const FamilyMembers();
                    }));
                  },
                  child: Text(
                    'Listen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'lemon',
                      color: darkmode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle OK button press
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'lemon',
                      color: darkmode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _playPause() {
    if (isPlaying) {
      player.pause();
      setState(() {
        isPaused = true;
        isPlaying = false;
      });
    } else if (isPaused) {
      player.resume();
      setState(() {
        isPaused = false;
        isPlaying = true;
      });
    } else {
      player.play(AssetSource(FamilyPath));
      setState(() {
        isPlaying = true;
      });
    }
  }

  final bool _isDarkMode = darkmode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () {Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios),color: darkmode ? Colors.orange : Colors.black,),

        backgroundColor: darkmode ? Colors.black : Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Listen Family Members',
              style: TextStyle(
                color: _isDarkMode ? Colors.orange : Colors.black,
                fontFamily: 'lemon',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: darkmode ? Colors.black : (darkmode == false ? Colors.white : dark),
        child: Column(
          children: [
            // Now Playing Section
            Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 200,
                    backgroundImage: AssetImage(
                      'assets/images/tenor.gif',
                    ), // Replace with your image
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      JapaneseName,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.orange : Colors.black,
                        fontFamily: 'lemon',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "{$englishName}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.orange : Colors.black,
                        fontFamily: 'lemon',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.skip_previous),
                          onPressed: () {
                        for (int i = 0; i < japaneseFamilyMembers.length; i++) {
                        if (JapaneseName == japaneseFamilyMembers[i]&&i!=0) {
                        setState(() {
                        _showAlertDialog(japaneseFamilyMembers[i- 1], englishFamilyMembers[i - 1]);
                        });
                        break;
                        }

                        }
                        },
                          color: _isDarkMode ? Colors.orange : Colors.black,
                        ),
                        IconButton(
                          iconSize: 50,
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () {
                            _playPause();
                          },
                          color: _isDarkMode ? Colors.orange : Colors.black,
                        ),
                        IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.skip_next),
                          onPressed: () {
                            for (int i=0;i<10;i++)
                              {
                            if (JapaneseName== japaneseFamilyMembers[i]) {
                              setState(() {
                                _showAlertDialog(japaneseFamilyMembers[i + 1], englishFamilyMembers[i + 1]);
                              });
                              break;
                            }
                          }},
                          color: _isDarkMode ? Colors.orange : Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Playlist Section
          ],
        ),
      ),
    );
  }
}
