import 'package:flutter/material.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:provider/provider.dart';

class ButtonGroup extends StatefulWidget {
  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  bool isButton1Pressed = false; // State for the first button

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        // First Button
        StatefulGradientRoundedButton(
          width: 150,
          height: 40,
          borderRadius: 30,
          isPressed: appState.textState,
          onPressed: () {
            appState.textUpdate(true);
            print(appState.textState);
          },
          otherButtonPressed: () {
            appState.textUpdate(false);
          },
          child: Text(
            'Temperature',
            style: TextStyle(
              fontSize: 18,
              color: appState.textState ? Color(0xffD9D9D9) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Second Button
        StatefulGradientRoundedButton(
          width: 150,
          height: 40,
          borderRadius: 30,
          isPressed: !appState.textState,
          onPressed: () {
            appState.textUpdate(false);
            print(appState.textState);
          },
          otherButtonPressed: () {
            appState.textUpdate(true);
          },
          child: Text(
            'Humidity',
            style: TextStyle(
              fontSize: 18,
              color: appState.textState ? Colors.white : Color(0xffD9D9D9),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class StatefulGradientRoundedButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isPressed; // Indicates if this button is pressed
  final VoidCallback onPressed; // Callback for this button
  final VoidCallback otherButtonPressed; // Callback for the other button
  final Widget child;

  const StatefulGradientRoundedButton({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.isPressed,
    required this.onPressed,
    required this.otherButtonPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(); // Trigger this button's action
        otherButtonPressed(); // Trigger the other button's action
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            colors: isPressed
                ? [Colors.white, Colors.white]
                : [Colors.cyanAccent.shade200, Colors.teal.shade400],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? Colors.white
                  : Colors.cyanAccent.shade100.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
