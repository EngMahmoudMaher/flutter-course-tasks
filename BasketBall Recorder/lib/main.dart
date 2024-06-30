import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: BasketBallRecord(),
    debugShowCheckedModeBanner: false,
  ));
}

int TeamA = 0;
int TeamB = 0;

class BasketBallRecord extends StatefulWidget {
  const BasketBallRecord({super.key});

  @override
  State<BasketBallRecord> createState() => _BasketBallRecordState();
}

class _BasketBallRecordState extends State<BasketBallRecord> {
  void _incrementTeamA(int points) {
    setState(() {
      TeamA += points;
    });
  }

  void _incrementTeamB(int points) {
    setState(() {
      TeamB += points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "BasketBall Points Recorder",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'lemon',
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/basket.png"),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 700,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                          child: Text(
                            "Team A",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              fontFamily: 'lemon',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            TeamA.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 250,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: const Text(
                              'Add 1 Point',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lemon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _incrementTeamA(1),
                            tileColor: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: const Text(
                              'Add 2 Points',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lemon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _incrementTeamA(2),
                            tileColor: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: const Text(
                              'Add 3 Points',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lemon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _incrementTeamA(3),
                            tileColor: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.blueGrey,
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Team B",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              fontFamily: 'lemon',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            TeamB.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 250,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: const Text(
                              'Add 1 Point',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lemon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _incrementTeamB(1),
                            tileColor: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: const Text(
                              'Add 2 Points',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lemon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _incrementTeamB(2),
                            tileColor: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: const Text(
                              'Add 3 Points',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lemon',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _incrementTeamB(3),
                            tileColor: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25), // Vertical margin
              child: SizedBox(
                width: 220,
                height: 60,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.orange),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.orange),
                      ),
                    ),
                    // Add shadow
                    elevation: WidgetStateProperty.all(5.0),
                    shadowColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      TeamA = 0;
                      TeamB = 0;
                    });
                  },
                  child: const Text(
                    "Reset Result",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'lemon',
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
