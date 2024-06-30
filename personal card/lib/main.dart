import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: BirthDayCard(),
    debugShowCheckedModeBanner: false,
  ));
}

class BirthDayCard extends StatefulWidget {
  const BirthDayCard({super.key});

  @override
  State<BirthDayCard> createState() => _BirthDayCardState();
}

class _BirthDayCardState extends State<BirthDayCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff274460),
      body: SingleChildScrollView(
        // Removed unnecessary scrollDirection property as the default is vertical
        child: Column(
          children: [

            // Improved profile image presentation
            Center( // Center the avatar for better visual balance
              child: Container(margin:
              const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/stech.png'),
                  backgroundColor: Color(0xff274460),
                  radius: 90, // Adjusted radius for a more balanced look
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Mahmoud Maher",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lemon',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20,bottom: 100),
              child: Text(
                "Flutter Developer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'pacifico',
                ),
              ),
            ),

            // Extracted common input field style for reusability
            _buildInputField(
              hintText: '(+20)123456789',
              prefixIcon: Icons.phone,
            ),

            _buildInputField(
              hintText: 'learningjourney@stech',
              prefixIcon: Icons.email_sharp,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build input fields with consistent styling
  Widget _buildInputField({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return Container(
      margin:   const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: 410,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.black),
        ),
      ),
    );
  }
}