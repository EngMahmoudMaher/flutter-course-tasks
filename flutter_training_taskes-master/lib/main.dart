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
      backgroundColor: Color(0xffd2bcd5),
      body: Column(
        children: [
          SizedBox(
            height: 110,
          ),
          Container(
              width: 420,
              height: 420,
              child: Image(image: AssetImage("assets/images/love.png"))),
          SizedBox(
            height:70,
          ),
          Center(
            child: Text(
              "  Happy\nBirthday",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lemon'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "learning journey",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
