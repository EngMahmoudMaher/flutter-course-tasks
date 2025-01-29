import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_time_picker/date_time_picker.dart';  // Import the date_time_picker package

import '../widgets/ui_items/custom_navigationbar.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final List<Map<String, String>> _reminders = [];
  final _databaseRef = FirebaseDatabase.instance;

  // Function to load reminders from Firebase
  Future<void> _loadReminders() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final dataSnapshot = await _databaseRef
          .ref()
          .child('users')
          .child(user.uid)
          .child('reminders')
          .get();

      if (dataSnapshot.exists) {
        final Map<dynamic, dynamic>? data =
        dataSnapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          setState(() {
            _reminders.clear();
            data.forEach((key, value) {
              _reminders.add({
                'id': key,
                'note': value['note'] ?? '',
                'date': value['date'] ?? '',
              });
            });
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }

  // Function to delete a reminder from Firebase
  Future<void> _deleteReminder(String id) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      await _databaseRef
          .ref()
          .child('users')
          .child(user.uid)
          .child('reminders')
          .child(id)
          .remove();

      setState(() {
        _reminders.removeWhere((record) => record['id'] == id);
      });

      debugPrint("Reminder deleted successfully");
    } catch (e) {
      debugPrint("Error deleting reminder: $e");
    }
  }

  // Function to open the form dialog for adding or editing reminders
  void _openAddOrEditReminderForm(BuildContext context, [Map<String, String>? reminder]) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController noteController = TextEditingController(text: reminder?['note'] ?? '');
    String selectedDateTime = reminder?['date'] ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: Text(
            reminder == null ? "Add Reminder" : "Edit Reminder",
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
                _buildTextField(noteController, "Reminder Note"),
                const SizedBox(height: 10),

                // DateTime Picker for date and time selection
                DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  initialValue: selectedDateTime,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date and Time',
                  onChanged: (val) {
                    selectedDateTime = val;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please select a date and time";
                    }
                    return null;
                  },
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
                if (reminder == null) {
                  await _saveDataToFirebase(
                    noteController.text,
                    selectedDateTime,
                  );
                } else {
                  await _updateDataInFirebase(
                    reminder['id']!,
                    noteController.text,
                    selectedDateTime,
                  );
                }
                Navigator.pop(context);
                _loadReminders();
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

  // Function to save new reminder to Firebase
  Future<void> _saveDataToFirebase(String note, String dateTime) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final databaseRef = _databaseRef
          .ref()
          .child('users')
          .child(user.uid)
          .child('reminders');

      await databaseRef.push().set({
        'note': note,
        'date': dateTime,
      });

      debugPrint("Reminder saved successfully");
    } catch (e) {
      debugPrint("Error saving reminder: $e");
    }
  }

  // Function to update existing reminder in Firebase
  Future<void> _updateDataInFirebase(String id, String note, String dateTime) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final databaseRef = _databaseRef
          .ref()
          .child('users')
          .child(user.uid)
          .child('reminders')
          .child(id);

      await databaseRef.update({
        'note': note,
        'date': dateTime,
      });

      debugPrint("Reminder updated successfully");
    } catch (e) {
      debugPrint("Error updating reminder: $e");
    }
  }

  // Helper function for text fields
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
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
                                "Reminders",
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
                            itemCount: _reminders.length,
                            itemBuilder: (context, index) {
                              final reminder = _reminders[index];
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
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date and Time: ${reminder['date']}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Note: ${reminder['note']}",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () =>
                                                  _openAddOrEditReminderForm(
                                                      context, reminder),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () =>
                                                  _deleteReminder(reminder['id']!),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _openAddOrEditReminderForm(context),
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
                                "Add Reminder",
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
