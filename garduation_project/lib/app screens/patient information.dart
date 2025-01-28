import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/ui_items/custom_navigationbar.dart';

class PatientInfoPage extends StatefulWidget {
  const PatientInfoPage({Key? key}) : super(key: key);

  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  // Create controllers for each TextField
  final List<TextEditingController> _controllers =
      List.generate(8, (index) => TextEditingController());

  // Realtime Database instance
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // User ID for Firebase
  User? user = FirebaseAuth.instance.currentUser;

  // Data structure for storing fields
  final List<String> _fields = [
    "Name",
    "Age",
    "Gender",
    "Address",
    "Phone",
    "Email",
    "Emergency Contact"
  ];

  // Send data to Firebase when the user finishes typing
  void _sendDataToFirebase(int index, String data) {
    if (user != null) {
      String userId = user!.uid;

      // Update Realtime Database with the entered data
      _database.child('patient_info/$userId').update({
        _fields[index]: data,
      });
    }
  }

  // Load existing data from Firebase when the page is opened
  void _loadDataFromFirebase() async {
    if (user != null) {
      String userId = user!.uid;

      // Get data from Firebase Realtime Database
      DatabaseReference userRef = _database.child('patient_info/$userId');

      // Fetch data using once()
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        // Populate the TextEditingControllers with the existing data from Firebase
        for (int i = 0; i < _fields.length; i++) {
          if (data.containsKey(_fields[i])) {
            _controllers[i].text = data[_fields[i]] ?? '';
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Load existing data from Firebase when the page loads
    _loadDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            //------------------------ Background Decorations ------------------------//
            Positioned(
              child: Container(
                width: widthSize / 3.1,
                height: heightSize / 1.2,
                child: Image.asset(
                  'assets/imag/iteams/Ellipse 2.png',
                  semanticLabel: 'Ellipse 2',
                  fit: BoxFit.fill,
                ),
              ),
              right: 0,
              top: 50,
            ),
            Positioned(
              child: Container(
                width: widthSize / 3.1,
                height: heightSize / 1.2,
                child: Image.asset(
                  'assets/imag/iteams/Ellipse 2-1.png',
                  semanticLabel: 'Ellipse 2-1',
                  fit: BoxFit.fill,
                ),
              ),
              left: 0,
              top: 50,
            ),
            //------------------------ Main Content ------------------------//
            Positioned(
              left: 20,
              child: Container(
                width: widthSize - 40,
                height: heightSize / 1.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: widthSize * 0.9,
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              child: SvgPicture.asset(
                                'assets/imag/iteams/backiconleft.svg',
                                semanticsLabel: 'backiconleft',
                                width: widthSize / 20,
                                height: heightSize / 20,
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      //------------------------ Circle Avatar with Gradient ------------------------//
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF419389), Color(0xFF4DF1DD)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/imag/iteams/user-circle.svg',
                          width: widthSize * 0.08,
                          height: heightSize * 0.08,
                          color: Colors.white,
                        ),
                      ),

                      //------------------------ Name Below Avatar ------------------------//
                      const SizedBox(height: 20),
                      Text(
                        "Patient Information",
                        style: TextStyle(
                          fontSize: widthSize * 0.08,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                Color(0xFF419389),
                                Color(0xFF4DF1DD),
                                Color(0xFF419389),
                              ],
                            ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Loop through the fields
                      for (int i = 0; i < _fields.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Text Label
                              Text(
                                "${_fields[i]}:",
                                style: TextStyle(
                                  fontSize: widthSize * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10), // Space between text and textfield

                              // TextField with auto-submit and dynamic hint text
                              Expanded(
                                child: TextField(
                                  controller: _controllers[i],
                                  decoration: InputDecoration(
                                    hintText: _controllers[i].text.isEmpty
                                        ? ".................................."
                                        : _controllers[i]
                                            .text, // Display entered data
                                    hintStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (data) {
                                    // Send data to Realtime Database when text changes
                                    _sendDataToFirebase(i, data);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            CustomNavigationBar(
              widthSize: widthSize,
              heightSize: heightSize,
            ),
          ],
        ),
      ),
    );
  }
}
