import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/app%20screens/medical_history.dart';
import 'package:garduation_project/app%20screens/patient%20information.dart';
import 'package:garduation_project/app%20screens/results.dart';
import 'package:garduation_project/widgets/ui_items/custom_navigationbar.dart';

class userDataPage extends StatelessWidget {
  const userDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid; // Get the user ID dynamically
    int? userNumericId = userId?.hashCode;
    String? userName = user?.displayName ??
        "UserName"; // Use default "UserName" if not available

    // Prevent back navigation

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: widthSize,
            height: heightSize,
            child: Stack(
              children: [
                //------------------------ Right Elips ------------
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
                //------------------------ Left Elips ------------
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
                //------------------------------ Rectangle ----------
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      Container(
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
                      ),
                      //---------------------------- User Icon & Name -------------
                      Positioned(
                        child: Column(
                          children: [
                            Container(
                              width: widthSize * 0.9,
                              padding: EdgeInsets.only(left: 10, top: 10),
                              // decoration: BoxDecoration(border: Border.all()),
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
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Person Icon with Gradient Color
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF419389),
                                    Color(0xFF4DF1DD)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/imag/iteams/user-circle.svg',
                                width: 80,
                                height: 80,
                                color: Colors.white,
                              ),
                            ),

                            // Username Text with Gradient
                            Text(
                              userName, // Change this as per the dynamic username
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      Color(0xFF419389),
                                      Color(0xFF4DF1DD),
                                      Color(0xFF419389)
                                    ],
                                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                              ),
                            ),
                            //----------------------- Id Label ------------

                            Text(
                              'Id: ${userNumericId ?? "Loading..."}', // Display the user ID or "Loading..." if not available
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      Color(0xFF419389),
                                      Color(0xFF4DF1DD),
                                      Color(0xFF419389)
                                    ],
                                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------- Cards --------------------
                      Positioned(
                        top: 250,
                        left: 30,
                        right: 30,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 40,
                            childAspectRatio: 1,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final List<Map<String, dynamic>> cardData = [
                              {
                                "title": "Patient Information",
                                "gradient": [
                                  Color(0xFF419389),
                                  Color(0xFF4DF1DD)
                                ],
                                "destination": PatientInfoPage(),
                              },
                              {
                                "title": "Medical History",
                                "gradient": [
                                  Color(0xFF419389),
                                  Color(0xFF4DF1DD)
                                ],
                                "destination": MedicalHistoryPage(),
                              },
                              {
                                "title": "Current Health State",
                                "gradient": [
                                  Color(0xFF419389),
                                  Color(0xFF4DF1DD)
                                ],
                                "destination": CurrentHealthStatePage(),
                              },
                              {
                                "title": "Results and Examination",
                                "gradient": [
                                  Color(0xFF419389),
                                  Color(0xFF4DF1DD)
                                ],
                                "destination": ResultAndExaminationPage(),
                              },
                            ];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => cardData[index]
                                        ['destination'] as Widget,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: cardData[index]['gradient']
                                        as List<Color>,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    cardData[index]['title'] as String,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign
                                        .center, // Center text horizontally
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //------------------- NavBar ------------
                CustomNavigationBar(
                  widthSize: widthSize,
                  heightSize: heightSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentHealthStatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Health State")),
      body: Center(
        child: Text("Welcome to Current Health State",
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

