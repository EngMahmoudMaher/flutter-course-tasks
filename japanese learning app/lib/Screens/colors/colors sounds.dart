import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../Catigory.dart';
import 'Colors.dart';

void main() {
  runApp(const MyApp());
}

List<String> japaneseColors = [
  'Aka', 'Ao', 'Kiiro', 'Midori', 'Kuro', 'Shiro', 'Murasaki', 'Orenji', 'Pinku', 'Chairo',
];

List<String> englishColors = [
  'Red', 'Blue', 'Yellow', 'Green', 'Black', 'White', 'Purple', 'Orange', 'Pink', 'Brown',
];

List<String> pathes = [
  "audios/colors/red.wav", "audios/colors/blue.wav", "audios/colors/yellow.wav", "audios/colors/green.wav",
  "audios/colors/black.wav", "audios/colors/white.wav", "audios/colors/purple.wav", "audios/colors/orange.wav",
  "audios/colors/pink.wav", "audios/colors/brown.wav"
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
      home: const ColorSounds(),
    );
  }
}

class ColorSounds extends StatefulWidget {
  const ColorSounds({super.key});

  @override
  State<ColorSounds> createState() => _ColorSoundsState();
}

class _ColorSoundsState extends State<ColorSounds> {
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
                      return const ColorPage();
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
      player.play(AssetSource(ColorPath));
      setState(() {
        isPlaying = true;
      });
    }
  }

  final bool _isDarkMode = darkmode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios), color: darkmode ? Colors.orange : Colors.black),
        backgroundColor: darkmode ? Colors.black : Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Listen Colors',
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
                      JapaneseColor,
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
                    "{$englishColor}",
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
                            for (int i = 0; i < japaneseColors.length; i++) {
                              if (JapaneseColor == japaneseColors[i] && i != 0) {
                                setState(() {
                                  _showAlertDialog(japaneseColors[i - 1], englishColors[i - 1]);
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
                            for (int i = 0; i < japaneseColors.length; i++) {
                              if (JapaneseColor == japaneseColors[i]) {
                                setState(() {
                                  _showAlertDialog(japaneseColors[i + 1], englishColors[i + 1]);
                                });
                                break;
                              }
                            }
                          },
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
