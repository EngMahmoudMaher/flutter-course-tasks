import 'package:flutter/material.dart';
import '../Catigory.dart';
import 'colors sounds.dart';
void main() {
  runApp(const MyApp());
}

dynamic ColorPath = "";
String JapaneseColor='';
String englishColor = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ColorPage(),
    );
  }
}

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  final List<Map<String, dynamic>> _colors = [
    {'name': 'Haiiro', 'color': Colors.grey, 'value': 'audios/colors/gray.wav', 'englishName': 'Gray'},
    {'name': 'Aka', 'color': Colors.red, 'value': 'audios/colors/red.wav', 'englishName': 'Red'},
    {'name': 'Midori', 'color': Colors.green, 'value': 'audios/colors/green.wav', 'englishName': 'Green'},
    {'name': 'Chairo', 'color': Colors.brown, 'value': 'audios/colors/brown.wav', 'englishName': 'Brown'},
    {'name': 'Shiro', 'color': Colors.white, 'value': 'audios/colors/white.wav', 'englishName': 'White'},
    {'name': 'Kuro', 'color': Colors.black, 'value': 'audios/colors/black.wav', 'englishName': 'Black'},
    {'name': 'Kiiro', 'color': Colors.yellow, 'value': 'audios/colors/yellow.wav', 'englishName': 'Yellow'},
    {'name': 'Kogecha', 'color': const Color(0xFFD3B774), 'value': 'audios/colors/dusty yellow.wav', 'englishName': 'Dusty Yellow'},
  ]; // List to hold color details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios), color: darkmode ? Colors.deepOrange : Colors.black),
        backgroundColor:darkmode ? Colors.black : Colors.white,
        title:  Text(
          'Colors',
          style: TextStyle(
            color: darkmode ? Colors.orange : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'lemon',
          ),
        ),
      ),
      body: Container(
        color: darkmode ? Colors.black : Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          children: List.generate(
            _colors.length,
                (index) => Card(
              color: _colors[index]['color'],
              child: InkWell(
                onTap: () {
                  ColorPath = _colors[index]['value']; // Clear the FamilyPath since it's not used in ColorPage
                  JapaneseColor = _colors[index]['name'];
                  englishColor = _colors[index]['englishName'];

                  // Navigate to FamilySounds and pass specific data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ColorSounds(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _colors[index]['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'lemon',
                          color:darkmode ? Colors.cyanAccent : Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        _colors[index]['englishName'],
                        style:TextStyle(
                          fontSize: 20,
                          fontFamily: 'lemon',
                          color:darkmode ? Colors.cyanAccent : Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                        ),
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
}
