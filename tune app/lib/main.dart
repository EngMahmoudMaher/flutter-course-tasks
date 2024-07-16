import 'package:flutter/material.dart';
import 'customs/custom container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TunePlayer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TunePlayer extends StatefulWidget {
  const TunePlayer({super.key});

  @override
  State<TunePlayer> createState() => _TunePlayerState();
}

class _TunePlayerState extends State<TunePlayer> {
  final List<Map<String, dynamic>> _tunes = [
    {'color': Colors.red, 'tune': 'Tune 1', 'path': 'note1.wav'},
    {'color': Colors.white, 'tune': 'Tune 2', 'path': 'note2.wav'},
    {'color': Colors.yellow, 'tune': 'Tune 3', 'path': 'note3.wav'},
    {'color': Colors.green, 'tune': 'Tune 4', 'path': 'note4.wav'},
    {'color': Colors.purpleAccent, 'tune': 'Tune 5', 'path': 'note5.wav'},
    {'color': Colors.brown, 'tune': 'Tune 6', 'path': 'note6.wav'},
    {'color': Colors.blue, 'tune': 'Tune 7', 'path': 'note7.wav'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.5,
          title: const Center(
              child: Text(
            'Tune Player',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        body: ListView.builder(
          itemCount: _tunes.length,
          itemBuilder: (context, index) {
            final tune = _tunes[index];
            return CustomContainer(
              color: tune['color'],
              tune: tune['tune'],
              path: tune['path'],
            );
          },
        ),
      ),
    );
  }
}
