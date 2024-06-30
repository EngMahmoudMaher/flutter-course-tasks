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
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 70),
            ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 2, // Adjust the border width as needed
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/stech.png'),
                    backgroundColor: Color(0xff274460),
                    foregroundColor: Colors.white,
                    radius: 160, // Adjust the radius as needed
                    // You can add a child widget here if you want, like an icon or image
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Mahmoud Maher",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lemon',
                )),
            const SizedBox(
              height: 10,
            ),
            const Text("Flutter Developer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'pacifico',
                )),
            const SizedBox(
              height: 90,
            ),
            Container(
              width: 410,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: '(+20)123456789',
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.phone, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 410,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'learningjourney@stech',
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  prefixIcon: Icon(Icons.email_sharp, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
