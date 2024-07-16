import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final Color color;
  final String tune;
  final String path;

  const CustomContainer({
    super.key,
    required this.color,
    required this.tune,
    required this.path,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _player.play(AssetSource(widget.path));
      },
      child: Container(
        color: widget.color,
        height: 125,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.tune,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
