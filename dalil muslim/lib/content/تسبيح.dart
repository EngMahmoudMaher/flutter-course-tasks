import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TasbihApp());
}

class TasbihApp extends StatelessWidget {
  const TasbihApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasbih App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _loadCounter(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TasbihPage(counter: snapshot.data ?? 0);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<int> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('counter') ?? 0;
  }
}

String select = "";
int count = 0;

class TasbihPage extends StatefulWidget {
  final int counter;

  const TasbihPage({super.key, required this.counter});

  @override
  _TasbihPageState createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int counter;
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    counter = widget.counter;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void incrementCounter() {
    setState(() {
      counter++;
      _saveCounter(counter);
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
      _saveCounter(counter);
    });
  }

  Future<void> _saveCounter(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/img/img_2.png'), // Replace with your own image path
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: TextField(style: const TextStyle(color: Colors.grey),
                      controller: inputController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'انقر لاضافة التسبيح٫٫٫٫',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          gapPadding: 25
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 25,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'العداد: $counter',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: fromCssColor('rgb(230, 240, 10)'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ScaleTransition(
                            scale: _animation,
                            child: Container(
                              width: 180,
                              height: 220,
                              decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle),
                              child: TextButton(
                                onPressed: () {
                                  if (inputController.text == '') {
                                    select = 'اذكر الله';
                                  } else {
                                    select = inputController.text;
                                  }

                                  count++;
                                  incrementCounter();
                                  _animationController.forward(from: 0.0);
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                ),
                                child: Text(
                                  select,
                                  style: TextStyle(
                                      color: Colors.blueAccent.shade200,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: TextButton(
                                onPressed: () {
                                  resetCounter();
                                },
                                child: const Icon(Icons.restart_alt)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
