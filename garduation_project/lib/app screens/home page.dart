import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference dbr = FirebaseDatabase.instance.ref();
  bool isLedOn = false; // Track LED state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildCurvedBackground(),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  title: const Text("Smart Sensor & LED Control"),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: dbr.child("Data").onValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData &&
                          snapshot.data!.snapshot.value != null &&
                          !snapshot.hasError) {
                        final data = snapshot.data!.snapshot.value as Map;
                        final temperature =
                            double.tryParse(data["Temperature"].toString()) ??
                                0.0;
                        final humidity =
                            double.tryParse(data["Humidity"].toString()) ?? 0.0;

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildCircularIndicator(
                                    title: "Temperature",
                                    value: temperature,
                                    unit: "°C",
                                    gradientColors: [
                                      Colors.tealAccent,
                                      Colors.teal
                                    ],
                                  ),
                                  _buildCircularIndicator(
                                    title: "Humidity",
                                    value: humidity,
                                    unit: "%",
                                    gradientColors: [
                                      Colors.lightBlueAccent,
                                      Colors.blue
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              _buildLedStatus(),
                              const SizedBox(height: 20),
                              _buildLedControlButton(),
                            ],
                          ),
                        );
                      }

                      return const Center(
                        child: Text("Failed to load data"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the background with curves on the top and bottom.
  Widget _buildCurvedBackground() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the individual circular indicator card.
  Widget _buildCircularIndicator({
    required String title,
    required double value,
    required String unit,
    required List<Color> gradientColors,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 10.0,
            percent: (value / 100).clamp(0.0, 1.0),
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  unit,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            linearGradient: LinearGradient(colors: gradientColors),
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildLedStatus() {
    return Text(
      isLedOn ? "LED is ON" : "LED is OFF",
      style: TextStyle(
        fontSize: 18,
        color: isLedOn ? Colors.red : Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLedControlButton() {
    return ElevatedButton.icon(
      onPressed: toggleLedState,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLedOn ? Colors.redAccent : Colors.greenAccent,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      icon: Icon(
        isLedOn ? Icons.lightbulb : Icons.lightbulb_outline,
        color: Colors.white,
        size: 30,
      ),
      label: Text(
        isLedOn ? 'Turn Off' : 'Turn On',
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  void toggleLedState() {
    setState(() {
      isLedOn = !isLedOn;
    });
    dbr.child("LED").set({"switch": isLedOn}).then((_) {
      print("LED state updated successfully.");
    }).catchError((error) {
      print("Failed to update LED state: $error");
    });
  }
}
