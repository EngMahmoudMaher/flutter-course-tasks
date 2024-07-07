import 'package:flutter/material.dart';
import 'package:lutter_training_course/Screens/Family/FamilySounds.dart';

import '../Catigory.dart';

void main() {
  runApp(const MyApp());
}

dynamic FamilyPath = "";
String JapaneseName='';
String englishName = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const FamilyMembers(),
    );
  }
}

class FamilyMembers extends StatefulWidget {
  const FamilyMembers();

  @override
  _FamilyMembersState createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
  final List<Map<String, dynamic>> _familyMembers = [
    {'name': 'Chichi', 'icon': 'assets/images/family_members/family_father.png', 'value': "audios/family_members/father.wav", 'englishName': 'Father'},
    {'name': 'Haha', 'icon': 'assets/images/family_members/family_mother.png', 'value': "audios/family_members/mother.wav", 'englishName': 'Mother'},
    {'name': 'Ani', 'icon': 'assets/images/family_members/family_older_brother.png', 'value': "audios/family_members/older brother.wav", 'englishName': 'Older Brother'},
    {'name': 'Ane', 'icon': 'assets/images/family_members/family_older_sister.png', 'value': "audios/family_members/older sister.wav", 'englishName': 'Older Sister'},
    {'name': 'Otouto', 'icon': 'assets/images/family_members/family_younger_brother.png', 'value': "audios/family_members/younger brother.wav", 'englishName': 'Younger Brother'},
    {'name': 'Imouto', 'icon': 'assets/images/family_members/family_younger_sister.png', 'value': "audios/family_members/younger sister.wav", 'englishName': 'Younger Sister'},
    {'name': 'Musuko', 'icon': 'assets/images/family_members/family_son.png', 'value': "audios/family_members/son.wav", 'englishName': 'Son'},
    {'name': 'Musume', 'icon': 'assets/images/family_members/family_daughter.png', 'value': "audios/family_members/daughter.wav", 'englishName': 'Daughter'},
    {'name': 'Sofu', 'icon': 'assets/images/family_members/family_grandfather.png', 'value': "audios/family_members/grand father.wav", 'englishName': 'Grandfather'},
    {'name': 'Sobo', 'icon': 'assets/images/family_members/family_grandmother.png', 'value': "audios/family_members/grand mother.wav", 'englishName': 'Grandmother'},
  ]; // List to hold family member details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios),color: darkmode ? Colors.orange : Colors.black,),
        backgroundColor:darkmode? Colors.black : Colors.white,
        title: Text(
          'Family Members',
          style: TextStyle(
            color:darkmode ? Colors.orange : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'lemon',
          ),
        ),
      ),
      body: Container(
        color: darkmode? Colors.black : Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          children: List.generate(
            _familyMembers.length,
                (index) => Card(
              color: Colors.grey[800],
              child: InkWell(
                onTap: () {
                  FamilyPath = _familyMembers[index]['value'];
                  JapaneseName = _familyMembers[index]['name'];
                  englishName = _familyMembers[index]['englishName'];

                  // Navigate to FamilySounds and pass specific data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FamilySounds(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _familyMembers[index]['icon'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _familyMembers[index]['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'lemon',
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        _familyMembers[index]['englishName'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'lemon',
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
