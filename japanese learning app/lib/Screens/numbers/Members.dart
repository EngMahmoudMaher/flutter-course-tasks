import 'package:flutter/material.dart';

import '../Catigory.dart';
import 'num1.dart';

void main() {
  runApp(const MyApp());
}

dynamic path = "audios/aud.mp3";
String num = '';
String num2 = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(), // Define a dark theme
      themeMode: ThemeMode.system, // Use system theme settings
      home: const Numbers(),
    );
  }
}

class Numbers extends StatefulWidget {
  const Numbers();

  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  final List<Map<String, dynamic>> _numbers = [
    {'name': 'Ichi', 'icon': '1', 'value': "audios/number_one_sound.mp3"},
    {'name': 'Ni', 'icon': '2', 'value': "audios/numbers/number_two_sound.mp3"},
    {
      'name': 'San',
      'icon': '3',
      'value': "audios/numbers/number_three_sound.mp3"
    },
    {
      'name': 'Shi',
      'icon': '4',
      'value': "audios/numbers/number_four_sound.mp3"
    },
    {
      'name': 'Go',
      'icon': '5',
      'value': "audios/numbers/number_five_sound.mp3"
    },
    {
      'name': 'Roku',
      'icon': '6',
      'value': "audios/numbers/number_sex_sound.mp3"
    },
    {
      'name': 'Shichi',
      'icon': '7',
      'value': "audios/numbers/number_seven_sound.mp3"
    },
    {
      'name': 'Hachi',
      'icon': '8',
      'value': "audios/numbers/number_eight_sound.mp3"
    },
    {
      'name': 'Kyuu',
      'icon': '9',
      'value': "audios/numbers/number_nine_sound.mp3"
    },
    {
      'name': 'Ju',
      'icon': '10',
      'value': "audios/numbers/number_ten_sound.mp3"
    },
  ]; // List to hold number details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios),color: darkmode ? Colors.orange : Colors.black,),

        backgroundColor:
            darkmode ? Colors.black : (darkmode == false ? Colors.white : dark),
        title: const Text(
          'Numbers',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'lemon',
          ),
        ),
      ),
      body: Container(
        color:
            darkmode ? Colors.black : (darkmode == false ? Colors.white : dark),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          children: List.generate(
            _numbers.length,
            (index) => Card(
              color: Colors.grey[800],
              child: InkWell(
                onTap: () {
                  path = _numbers[index]['value'];
                  num = _numbers[index]['name'];
                  num2 = _numbers[index]['icon'];

                  // Navigate to HomePage and pass specific data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcons(int.parse(_numbers[index]['icon'])),
                    const SizedBox(height: 10),
                    Text(
                      _numbers[index]['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'lemon',
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcons(int count) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: List.generate(
        count,
        (index) => const Icon(Icons.star, size: 30, color: Colors.white),
      ),
    );
  }
}
