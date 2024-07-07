import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:lutter_training_course/Screens/numbers/Members.dart';
import '../Catigory.dart';

void main() {
  runApp(MyApp());
}

List<String> numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
List<String> japaneseNumbers = [
  'Ichi',
  'Ni',
  'San',
  'Shi',
  'Go',
  'Roku',
  'Shichi',
  'Hachi',
  'Kyuu',
  'Juu',
];
List<String> pathes = [
  "audios/numbers/number_one_sound.mp3",
  "audios/numbers/number_two_sound.mp3",
  "audios/numbers/number_three_sound.mp3",
  "audios/numbers/number_four_sound.mp3",
  "audios/numbers/number_five_sound.mp3",
  "audios/numbers/number_six_sound.mp3",
  "audios/numbers/number_seven_sound.mp3",
  "audios/numbers/number_eight_sound.mp3",
  "audios/numbers/number_nine_sound.mp3",
  "audios/numbers/number_ten_sound.mp3"
];

final player = AudioPlayer();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(), // Define a dark theme
      themeMode: ThemeMode.system, // Use system theme settings
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

          title:  Center(child: Text('Alert',style:
            TextStyle(fontWeight: FontWeight.bold
            ,fontSize: 20
            ,
            fontFamily:'lemon',
            color:darkmode ? Colors.white : Colors.black,

          ))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,style:
               TextStyle(fontWeight: FontWeight.bold
              ,fontSize: 20,
                fontFamily:'lemon',
                color:darkmode ? Colors.white : Colors.black,
              ),),
              Text(num,style:
               TextStyle(fontWeight: FontWeight.bold
              ,fontSize: 20
                  ,
                  fontFamily:'lemon',
                  color:darkmode ? Colors.white : Colors.black,

              ),),
            ],
          ),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (s){
                      return const Numbers();
                    }));
                  },
                  child:  Text('Listen',style:
                  TextStyle(fontWeight: FontWeight.bold
                    ,fontSize: 20
                    ,
                    fontFamily:'lemon',
                    color:darkmode ? Colors.white : Colors.black,

                  )),
                ),
                TextButton(
                  onPressed: () {
                    // Handle OK button press
                    Navigator.of(context).pop();
                  },
                  child:  Text('Cancel',style:
                  TextStyle(fontWeight: FontWeight.bold
                    ,fontSize: 20
                    ,
                    fontFamily:'lemon',
                    color:darkmode ? Colors.white : Colors.black,

                  )),
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
      player.play(AssetSource(path));
      setState(() {
        isPlaying = true;
      });
    }
  }



  bool _isDarkMode = darkmode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios),color: darkmode ? Colors.orange : Colors.black,),

        backgroundColor: darkmode ? Colors.black : Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Listen Numbers',
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
        color:

        darkmode ? Colors.black : (darkmode == false ? Colors.white : dark),
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
                        'assets/images/tenor.gif'), // Replace with your image
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      num,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.orange : Colors.black,
                        fontFamily: 'lemon',
                      ),
                    ),
                  ),
                  Text(
                    num2,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'lemon',
                      color: _isDarkMode ? Colors.orange : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.skip_previous),
                          onPressed: ()  {
                            for (int i = 0; i <= japaneseNumbers.length; i++) {
                              if (num == japaneseNumbers[i]&&i!=0) {
                                setState(() {
                                  _showAlertDialog( japaneseNumbers[i -1],  numbers[i -1]);
                                });
                                break;
                              }

                            }
                          },
                          color: _isDarkMode ? Colors.orange : Colors.black,
                        ),
                        IconButton(
                          iconSize: 50,
                          icon:
                              Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed:()  {
                        for (int i = 0; i <= japaneseNumbers.length; i++) {
                        if (num == japaneseNumbers[i]) {
                        setState(() {
                          _playPause();
                        });
                        break;
                        }

                        }
                        },
                          color: _isDarkMode ? Colors.orange : Colors.black,
                        ),
                        IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.skip_next),
                          onPressed: () {
                            for (int i = 0; i <= japaneseNumbers.length; i++) {
                              if (num == japaneseNumbers[i]) {
                                setState(() {
                                  _showAlertDialog( japaneseNumbers[i +1],  numbers[i +1]);
player.setSourceAsset(pathes[i+1]);
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
