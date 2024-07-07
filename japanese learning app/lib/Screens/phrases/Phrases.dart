import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(home: Phrases(),));
}
class Phrases extends StatefulWidget {
  const Phrases({super.key});

  @override
  State<Phrases> createState() => _ColorState();
}

class _ColorState extends State<Phrases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colors"),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

