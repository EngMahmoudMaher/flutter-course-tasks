import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/widgets/ui_items/glowing_rectangle.dart';
import 'package:firebase_database/firebase_database.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<Map<String, String>> _cardData = [
    {'image': 'assets/imag/fighter.jpg', 'title': 'DR/Ayman Soliman', 'subtitle': 'Supervisor'},
    {'image': 'assets/imag/fighter.jpg', 'title': 'ENG/ Mohamed Elsayed', 'subtitle': 'Teaching Assistant'},
    {'image': 'assets/imag/fighter.jpg', 'title': 'ENG/ Mahmoud Maher', 'subtitle': 'Mobile App Developer'},
    {'image': 'assets/imag/fighter.jpg', 'title': 'ENG/ Ahmed Maher', 'subtitle': 'Mobile App Developer'},
    {'image': 'assets/imag/fighter.jpg', 'title': 'ENG/ Mahmoud Saad', 'subtitle': 'AI Developer'},
    {'image': 'assets/imag/fighter.jpg', 'title': 'ENG/ Moustafa Salama', 'subtitle': 'AI Developer'},
    {'image': 'assets/imag/fighter.jpg', 'title': 'ENG/ Eman Taha', 'subtitle': 'EMBEDDED  Developer'},
  ];

  final _databaseRef = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    double WidthSize = MediaQuery.of(context).size.width;
    double HeightSize = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: WidthSize,
            height: HeightSize,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: WidthSize / 3,
                    height: HeightSize / 1.1,
                    child: Image.asset(
                      'assets/imag/iteams/Ellipse 2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  right: 0,
                  top: 50,
                ),
                Positioned(
                  child: Container(
                    width: WidthSize / 3.1,
                    height: HeightSize / 1.2,
                    child: Image.asset(
                      'assets/imag/iteams/Ellipse 2-1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  left: 0,
                  top: 50,
                ),
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      GlowingRectangle(
                        width: WidthSize - 40,
                        height: HeightSize / 1.18,
                        bottomLeftRadius: 50,
                        bottomRightRadius: 50,
                        innerColor: Colors.white,
                        shadowColor: Colors.black.withOpacity(0.4),
                      ),
                      Positioned(
                        top: 10,
                        child: Column(
                          children: [
                            Container(
                              width: WidthSize * 0.9,
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: SvgPicture.asset(
                                      'assets/imag/iteams/backiconleft.svg',
                                      width: WidthSize / 20,
                                      height: HeightSize / 20,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: WidthSize * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mobicare Team",
                                    style: TextStyle(
                                      fontSize: WidthSize * 0.09,
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
                                ],
                              ),
                            ),
                            SizedBox(height: HeightSize * 0.01),
                            Container(
                              width:400,
                              height: 600,
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two cards per row
                                  crossAxisSpacing: 0,
                                  mainAxisExtent: 200,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: _cardData.length,
                                itemBuilder: (context, index) {
                                  final card = _cardData[index];
                                  return Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            card['image']!,
                                            fit: BoxFit.cover,
                                            height: 120, // Adjust the height of the image
                                            width: double.infinity,
                                          ),

                                          Center(
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  colors: [
                                                    Color(0xFF4DF1DD),
                                                    Color(0xFF419389)
                                                  ],
                                                  tileMode: TileMode.mirror,
                                                ).createShader(bounds);
                                              },
                                              child: Center(
                                                child: Text(
                                                  card['title']!,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'intro',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              card['subtitle']!,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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
    );
  }
}
