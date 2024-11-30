import 'package:flutter/material.dart';
import 'package:garduation_project/colors/maincolors.dart';
import 'package:garduation_project/provider/appstate.dart';
import 'package:provider/provider.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({super.key});
  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  // Track the state of the checkbox
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    final appState = Provider.of<AppState>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: appState.checkedBox,
            onChanged: (bool? value) {
              isChecked = value ?? false;
              appState.checkedBoxUpdate(isChecked);
            },
            side: BorderSide(color: ProjectColors.mainColor),
            activeColor: ProjectColors.mainColor, // Customize active color
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
        ),
        Text(
          'Remember me', // Label text
          style: TextStyle(
              color: ProjectColors.mainColor, fontSize: widthSize / 30),
        ),
      ],
    );
  }
}
