import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garduation_project/colors/maincolors.dart';
import 'package:date_time_picker/date_time_picker.dart';  // Import the date_time_picker package
import 'package:url_launcher/url_launcher.dart';

import '../widgets/ui_items/custom_navigationbar.dart';

class ResultAndExaminationPage extends StatefulWidget {
  const ResultAndExaminationPage({super.key});

  @override
  State<ResultAndExaminationPage> createState() => _ResultAndExaminationPage();
}
final Uri _url = Uri.parse('https://drive.google.com/drive/folders/1bO7NL4nOvJeq6YxL9pS1gBCs3jWVtA_b');

class _ResultAndExaminationPage extends State<ResultAndExaminationPage> {
  final List<Map<String, String>> _medicalHistory = [];
  final _databaseRef = FirebaseDatabase.instance;

  // Function to load medical history data from Firebase
  Future<void> _loadMedicalHistory() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final dataSnapshot = await _databaseRef
          .ref()
          .child('users')
          .child(user.uid)
          .child('medical_Examinations')
          .get();

      if (dataSnapshot.exists) {
        final Map<dynamic, dynamic>? data =
        dataSnapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          setState(() {
            _medicalHistory.clear();
            data.forEach((key, value) {
              _medicalHistory.add({
                'id': key,
                'date': value['date'] ?? '',
                'illness': value['illness'] ?? '',
                'description': value['description'] ?? '',
                'url': value['drive_url'] ?? '',
              });
            });
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }

  // Function to delete a medical record
  Future<void> _deleteMedicalRecord(String id) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      await _databaseRef
          .ref()
          .child('users')
          .child(user.uid)
          .child('medical_Examinations')
          .child(id)
          .remove();

      setState(() {
        _medicalHistory.removeWhere((record) => record['id'] == id);
      });

      debugPrint("Record deleted successfully");
    } catch (e) {
      debugPrint("Error deleting record: $e");
    }
  }

  // Function to open the form dialog for editing or adding data
  void _openAddOrEditInfoForm(BuildContext context, [Map<String, String>? record]) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController illnessController = TextEditingController(text: record?['illness'] ?? '');
    final TextEditingController descriptionController = TextEditingController(text: record?['description'] ?? '');
    final TextEditingController driveUrlController = TextEditingController(text: record?['url'] ?? '');

    String selectedDate = record?['date'] ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: Text(
            record == null ? "Add Examinations Info" : "Edit Examinations Info",
            style: TextStyle(
              fontSize: 15,
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
        ),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),

                // DateTime Picker for date selection (First item)
                DateTimePicker(
                  type: DateTimePickerType.date,
                  initialValue: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  onChanged: (val) {
                    selectedDate = val;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please select a date";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),
                _buildTextField(illnessController, "Illness"),
                const SizedBox(height: 10),
                _buildTextField(descriptionController, "Description", true),
                const SizedBox(height: 10),
                // Button to launch Google Drive upload link (Styled like Save button)
                GestureDetector(
                  onTap: () {
                    // Fixed Google Drive upload link
                    _launchUrl();
                    },
                  child: Container(
                    width: 230,

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4DF1DD), Color(0xFF419389)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        "Upload files to Google Drive",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                if (record == null) {
                  await _saveDataToFirebase(
                    selectedDate,
                    illnessController.text,
                    descriptionController.text,
                    // Saving Drive URL
                  );
                } else {
                  await _updateDataInFirebase(
                    record['id']!,
                    selectedDate,
                    illnessController.text,
                    descriptionController.text,
                     // Updating Drive URL
                  );
                }
                Navigator.pop(context);
                _loadMedicalHistory();
              }
            },
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4DF1DD), Color(0xFF419389)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveDataToFirebase(String date, String illness, String description) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final databaseRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user.uid)
          .child('medical_Examinations');

      await databaseRef.push().set({
        'date': date,
        'illness': illness,
        'description': description,
        'url': 'https://drive.google.com/drive/folders/1bO7NL4nOvJeq6YxL9pS1gBCs3jWVtA_b', // Fixed value
      });

      debugPrint("Data saved successfully");
    } catch (e) {
      debugPrint("Error saving data: $e");
    }
  }

  Future<void> _updateDataInFirebase(String id, String date, String illness, String description) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final databaseRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user.uid)
          .child('medical_Examinations')
          .child(id);

      await databaseRef.update({
        'date': date,
        'illness': illness,
        'description': description,
        'drive_url': 'https://drive.google.com/drive/folders/1bO7NL4nOvJeq6YxL9pS1gBCs3jWVtA_b', // Fixed value
      });

      debugPrint("Data updated successfully");
    } catch (e) {
      debugPrint("Error updating data: $e");
    }
  }

// Custom function to launch URL
  void launchURL(String url) async {
    // You can use the url_launcher package to open URLs
    try {
      await launch(url);  // Ensure you've added the url_launcher package in your dependencies
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

// Helper function for text fields
  Widget _buildTextField(TextEditingController controller, String label, [bool isExpandable = false]) {
    return TextFormField(
      controller: controller,
      maxLines: isExpandable ? null : 1,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter $label";
        }
        return null;
      },
    );
  }

// Helper function for text fields

// Custom function to launch URL

  // Function to save new data to Firebase

  // Helper function for text fields

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: widthSize / 3.1,
                height: heightSize / 1.2,
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
                width: widthSize / 3.1,
                height: heightSize / 1.2,
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
                  Container(
                    width: widthSize - 40,
                    height: heightSize / 1.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.white70],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Column(
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
                        Container(
                          width: widthSize * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Examinations",
                                style: TextStyle(
                                  fontSize: widthSize * 0.09,
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
                        SizedBox(height: heightSize * 0.01),
                        Container(
                          width: widthSize - 40,
                          height: heightSize / 1.9,
                          child: ListView.builder(
                            itemCount: _medicalHistory.length,
                            itemBuilder: (context, index) {
                              final history = _medicalHistory[index];
                              return Card(
                                elevation: 5,
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date: ${history['date']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Illness: ${history['illness']}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Description: ${history['description']}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Files: https://drive.google.com/drive/folders/1bO7NL4nOvJeq6YxL9pS1gBCs3jWVtA_b",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: ProjectColors.mainColor,
                                            ),
                                            onPressed: () =>
                                                _openAddOrEditInfoForm(
                                                    context, history),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: ProjectColors.mainColor,
                                            ),
                                            onPressed: () =>
                                                _deleteMedicalRecord(
                                                    history['id']!),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _openAddOrEditInfoForm(context),
                          child: Container(
                            width: widthSize * 0.4,
                            height: widthSize * 0.08,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4DF1DD), Color(0xFF419389)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "Add Info",
                                style: TextStyle(
                                  fontSize: widthSize * 0.04,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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



Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}