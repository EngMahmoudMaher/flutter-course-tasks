import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:collection/collection.dart';

void main() {
  runApp( QuranScreen());
}

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المصحف الشريف',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.transparent, // Remove app bar color
          elevation: 0, // Remove app bar shadow
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: QuranHomePage(),
    );
  }
}

class QuranHomePage extends StatefulWidget {
  @override
  _QuranHomePageState createState() => _QuranHomePageState();
}

class _QuranHomePageState extends State<QuranHomePage> {
  List<dynamic> quranData = [];
  Map<String, String> progressData = {};
  PageController _pageController = PageController(initialPage: 0);

  // Search functionality
  String searchText = '';

  @override
  void initState() {
    super.initState();
    loadQuranData();
  }

  Future<void> loadQuranData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/quran.json');
      var data = json.decode(jsonData);
      List<dynamic> surahs = data['data']['surahs'];

      setState(() {
        quranData = surahs;
      });

      loadProgressData(); // Load progress data after setting quranData
    } catch (e) {
      print('Error reading Quran JSON file: $e');
    }
  }

  Future<void> loadProgressData() async {
    if (progressData.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? progressString = prefs.getString('progress');

      if (progressString != null) {
        Map<String, dynamic> decodedData = json.decode(progressString);
        setState(() {
          progressData = decodedData.cast<String, String>();
        });
      }
    }
  }

  Future<void> saveProgressData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String progressString = json.encode(progressData);
    await prefs.setString('progress', progressString);
  }

  void saveSurah(String surahName) {
    String surahNumber = quranData
        .firstWhere((surah) => surah['name'] == surahName)['number']
        .toString();

    setState(() {
      progressData[surahNumber] = surahName;
    });
    saveProgressData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Surah Saved'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    saveProgressData(); // Save progress data before disposing the page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSurahs = quranData.where((surah) {
      final name = surah['name'].toString().toLowerCase();
      final searchTextLower = searchText.toLowerCase();
      return name.contains(searchTextLower);
    }).toList();

    loadProgressData(); // Load progress data every time the build method is called

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'المصحف الشريف',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search Surah',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (filteredSurahs.length / 2).ceil(),
                itemBuilder: (context, index) {
                  int startIndex = index * 2;
                  int endIndex = startIndex + 1;
                  List<dynamic> surahs =
                  filteredSurahs.sublist(startIndex, endIndex + 1);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (surahs.length > 0)
                              SurahCard(
                                surah: surahs[0],
                                onSave: saveSurah,
                              ),
                            SizedBox(width: 16.0),
                            if (surahs.length > 1)
                              SurahCard(
                                surah: surahs[1],
                                onSave: saveSurah,
                              ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SurahCard extends StatelessWidget {
  final dynamic surah;
  final Function(String) onSave;

  const SurahCard({
    Key? key,
    required this.surah,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMakki = surah['type'] == 'Makki';

    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 300),
              child: SurahAyahsPage(
                surah: surah['name'],
                onSave: onSave,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  surah['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  isMakki ? 'Makki' : 'Madinah',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SurahAyahsPage extends StatefulWidget {
  final String surah;
  final Function(String) onSave;

  const SurahAyahsPage({
    Key? key,
    required this.surah,
    required this.onSave,
  }) : super(key: key);

  @override
  State<SurahAyahsPage> createState() => _SurahAyahsPageState();
}

class _SurahAyahsPageState extends State<SurahAyahsPage> {
  List<dynamic> quranData = [];
  Map<String, String> progressData = {};

  @override
  void initState() {
    super.initState();
    loadQuranData();

  }

  Future<void> loadQuranData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/quran.json');
      var data = json.decode(jsonData);
      List<dynamic> surahs = data['data']['surahs'];

      setState(() {
        quranData = surahs;
      });
    } catch (e) {
      print('Error reading Quran JSON file: $e');
    }
  }







  void navigateToNextSurah() {
    int currentSurahIndex =
    quranData.indexWhere((surah) => surah['name'] == widget.surah);
    if (currentSurahIndex < quranData.length - 1) {
      String nextSurah = quranData[currentSurahIndex + 1]['name'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SurahAyahsPage(
            surah: nextSurah,
            onSave: widget.onSave,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Save progress data before disposing the page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> ayahs = quranData
        .firstWhere((surah) => surah['name'] == widget.surah)['ayahs'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black, // Set the color of the back icon
        ),
        title: Text(
          widget.surah,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/img_5.png'), // Replace with your background image
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            dynamic ayah = ayahs[index];
            String ayahText = ayah['text'];

            if (widget.surah != 'At-Tawbah') {
              ayahText = ayahText;
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                ayahText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToNextSurah,
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

