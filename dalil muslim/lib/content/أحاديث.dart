import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(AhadithApp());
}

class AhadithApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahadith App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllAhadithPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AllAhadithPage extends StatefulWidget {
  @override
  _AllAhadithPageState createState() => _AllAhadithPageState();
}

class _AllAhadithPageState extends State<AllAhadithPage> {
  List<dynamic> ahadithData = [];
  List<dynamic> filteredAhadithData = [];

  @override
  void initState() {
    super.initState();
    loadAhadithData();
  }

  Future<void> loadAhadithData() async {
    try {
      String jsonData = await rootBundle.loadString('assets/adhkar.json');
      var data = json.decode(jsonData);
      setState(() {
        ahadithData = data;
        filteredAhadithData = data;
      });
    } catch (e) {
      print('Error reading Ahadith JSON file: $e');
    }
  }

  void filterAhadith(String query) {
    setState(() {
      filteredAhadithData = ahadithData.where((hadith) {
        return hadith['category'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'الأحاديث',
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
            image: AssetImage('assets/img/img_4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                strutStyle: StrutStyle(fontWeight: FontWeight.bold),
                cursorOpacityAnimates: true,
                canRequestFocus: true,
                cursorRadius: Radius.circular(25),
                onChanged: (value) => filterAhadith(value),
                decoration: InputDecoration(
                  enabled: true,

                  labelText: 'ابحث عن الحديث',
                  prefixIcon: Icon(Icons.search,color: Colors.white,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAhadithData.length,
                itemBuilder: (context, index) {
                  dynamic hadith = filteredAhadithData[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HadithPage(
                            ahadithData: filteredAhadithData,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              hadith['category'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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

class HadithPage extends StatefulWidget {
  final List<dynamic> ahadithData;
  final int initialIndex;

  HadithPage({
    required this.ahadithData,
    required this.initialIndex,
  });

  @override
  _HadithPageState createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'حديث',
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
        image: AssetImage('assets/img/img_4.png'),
    fit: BoxFit.cover,
    ),
    ),
    child: PageView.builder(
    controller: _pageController,
    itemCount: widget.ahadithData.length,
    onPageChanged: (int page) {
    setState(() {
    _currentPage = page;
    });
    },
    itemBuilder: (context, index) {
    dynamic hadith = widget.ahadithData[index];

    return SingleChildScrollView(
    child: Card(
    elevation: 4,
    color: Colors.white.withOpacity(0.8),
    margin: EdgeInsets.all(16),
    child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text(
    hadith['category'],
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 16),
    RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
    children: [
    TextSpan(
    text: hadith['array'][0]['text'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    ),
    ),
    ],
    ),
    ),
    SizedBox(height: 16),
    Text(
    'Count: ${hadith['array'][0]['count']}'
      ,style: TextStyle(
      fontSize: 16,
      color: Colors.grey,
    ),
      textAlign: TextAlign.center,
    ),
      ],
    ),
    ),
      ),
      );
    },
    ),
        ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              if (_currentPage < widget.ahadithData.length - 1)
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
