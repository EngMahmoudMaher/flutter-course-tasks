import 'package:flutter/material.dart';
import 'package:garduation_project/colors/maincolors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator; // Validator function
  final bool obscureText; // For password visibility toggle
  final TextInputType keyboardType; // Keyboard type
  final InputDecoration decoration; // Input decoration
  final VoidCallback? onPressed; // Action when icon is pressed

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.validator,
    this.obscureText = false, // Default to false
    this.keyboardType = TextInputType.text, // Default to text input
    this.decoration = const InputDecoration(), // Default decoration
    this.onPressed, // Optional onPressed action
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextField_State();
}

class _CustomTextField_State extends State<CustomTextField> {
  late TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(); // Initialize controller
    _obscureText = widget.obscureText; // Set initial obscureText state
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Transform.scale(
      scale: 0.9,
      child: Container(
        width: widthSize / 1.2, // Adjust the width as needed
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: ProjectColors.secondTextColor, // Border color
            width: 3.0, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: Row(
          children: [
            Icon(
              widget.icon, // Icon passed to the widget
              color: ProjectColors.secondTextColor,
              size: widthSize / 15,
            ),
            const SizedBox(width: 8.0), // Space between icon and TextField
            Expanded(
              child: TextFormField(
                controller: _controller,
                keyboardType: widget.keyboardType, // Handle keyboard type
                obscureText: _obscureText, // For password visibility toggle
                style: TextStyle(
                  color: ProjectColors.textColor, // Text color
                  fontSize: widthSize / 20,
                ),
                decoration: widget.decoration.copyWith(
                  // Use custom decoration
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: ProjectColors.secondTextColor, // Hint text color
                    fontSize: widthSize / 25,
                  ),
                  suffixIcon: widget.obscureText
                      ? IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: ProjectColors.secondTextColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : null, // If not obscureText, no suffix icon
                  border: InputBorder.none, // Remove the underline
                ),
                validator: widget.validator, // Apply custom validator
              ),
            ),
          ],
        ),
      ),
    );
  }
}
