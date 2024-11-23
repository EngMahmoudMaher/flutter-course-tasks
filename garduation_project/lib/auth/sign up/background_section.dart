import 'package:flutter/material.dart';

class BackgroundSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with circular corners
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55, // Takes up 55% of the screen height
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imag/back.jpg'),
              fit: BoxFit.cover, // Use BoxFit.cover to ensure the image fills the container
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30), // Circular edges on the bottom-left
              bottomRight: Radius.circular(30), // Circular edges on the bottom-right
            ),
          ),
        ),

        // Overlay content (Logo and Text)
        Positioned(
          top: 40, // Position the logo at the top of the container
          left: MediaQuery.of(context).size.width * 0.25, // Center the logo horizontally
          child: const Column(
            children: [
              Image(image: AssetImage('assets/imag/mobicare.png'), height: 250, width: 200),
              // You can replace the Image with your logo or any other widget
            ],
          ),
        ),
      ],
    );
  }
}
