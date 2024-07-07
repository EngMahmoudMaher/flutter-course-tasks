import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../Catigory.dart';

void main() {
  runApp(const MyApp());
}

final List<Map<String, String>> phrases = [
  {"title": "are_you_coming", "path": "audios/phrases/are_you_coming.wav"},
  {"title": "dont_forget_to_subscribe", "path": "audios/phrases/dont_forget_to_subscribe.wav"},
  {"title": "i_love_anime", "path": "audios/phrases/i_love_anime.wav"},
  {"title": "i_love_programming", "path": "audios/phrases/i_love_programming.wav"},
  {"title": "programming_is_easy", "path": "audios/phrases/programming_is_easy.wav"},
  {"title": "what_is_your_name", "path": "audios/phrases/what_is_your_name.wav"},
  {"title": "where_are_you_going", "path": "audios/phrases/where_are_you_going.wav"},
  {"title": "yes_iam_coming", "path": "audios/phrases/yes_im_coming.wav"},
];

final player = AudioPlayer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phrase Sounds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const PhraseSounds(),
    );
  }
}

class PhraseSounds extends StatefulWidget {
  const PhraseSounds({super.key});

  @override
  State<PhraseSounds> createState() => _PhraseSoundsState();
}

class _PhraseSoundsState extends State<PhraseSounds> {
  bool isPlaying = false;
  bool isPaused = false;
  String? currentlyPlayingPath;

  @override
  void initState() {
    super.initState();
  }

  void _playPause(String path) {
    if (isPlaying && currentlyPlayingPath == path) {
      player.pause();
      setState(() {
        isPaused = true;
        isPlaying = false;
      });
    } else if (isPaused && currentlyPlayingPath == path) {
      player.resume();
      setState(() {
        isPaused = false;
        isPlaying = true;
      });
    } else {
      player.play(AssetSource(path));
      setState(() {
        currentlyPlayingPath = path;
        isPlaying = true;
        isPaused = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: darkmode ? Colors.deepOrange : Colors.black,
        ),
        backgroundColor:darkmode ? Colors.black : Colors.white,
        title:  Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Phrase Sounds',
              style: TextStyle(
                color: darkmode ? Colors.deepOrange : Colors.black,
                fontFamily: 'lemon',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color:darkmode ? Colors.black : Colors.white,
        child: ListView.builder(
          itemCount: phrases.length,
          itemBuilder: (context, index) {
            final phrase = phrases[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                title: Text(
                  phrase['title']!,
                  style:  TextStyle(
                    color:darkmode ? Colors.deepOrange : Colors.black,
                    fontFamily: 'lemon',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isPlaying && currentlyPlayingPath == phrase['path']
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  color: darkmode ? Colors.deepOrange : Colors.black,
                  onPressed: () {
                    _playPause(phrase['path']!);
                  },
                ),
                tileColor: Colors.grey[900],
              ),
            );
          },
        ),
      ),
    );
  }
}
