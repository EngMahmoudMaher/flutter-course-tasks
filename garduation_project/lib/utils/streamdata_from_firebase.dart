import 'package:flutter/material.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class StreamDataFrom_Firebase extends StatefulWidget {
  @override
  _StreamDataFrom_FirebaseState createState() =>
      _StreamDataFrom_FirebaseState();
}

class _StreamDataFrom_FirebaseState extends State<StreamDataFrom_Firebase> {
  final DatabaseReference dbr = FirebaseDatabase.instance.ref();
  bool isLedOn = false; // Track LED state

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final widthSize = MediaQuery.of(context).size.width;
    return StreamBuilder(
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
              double.tryParse(data["Temperature"].toString()) ?? 0.0;
          final humidity = double.tryParse(data["Humidity"].toString()) ?? 0.0;

          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: appState.textState
                      ? humidity.toStringAsFixed(1)
                      : temperature.toStringAsFixed(1),
                  style: TextStyle(
                    color: Color(0xffB7B7B7),
                    fontSize: widthSize / 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0.0, -15.0),
                    child: Text(
                      appState.textState ? "" : '\u1d3c',
                      style: TextStyle(
                          fontSize: widthSize / 40, color: Color(0xffB7B7B7)),
                    ),
                  ),
                ),
                TextSpan(
                  text: appState.textState ? "%" : 'C',
                  style: TextStyle(
                      color: Color(0xffB7B7B7),
                      fontSize: widthSize / 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: Text("Failed to load data"),
        );
      },
    );
  }
}
