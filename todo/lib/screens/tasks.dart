import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  final Function(String, String, String, String, String) onSubmit;

  NewPage({required this.onSubmit});

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskNoteController = TextEditingController();

  final List<String> hours =
  List<String>.generate(12, (i) => (i + 1).toString().padLeft(2, '0'));
  final List<String> minutes =
  List<String>.generate(60, (i) => i.toString().padLeft(2, '0'));
  final List<String> periods = ['AM', 'PM'];

  String selectedHour = '01';
  String selectedMinute = '00';
  String selectedPeriod = 'AM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                shadowColor: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add New Task',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Task Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _taskNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                ),
                                filled: true,
                                hintText: 'Enter task name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a task name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  print('Task Name: ${_taskNameController.text}');
                                  print('Selected Time: $selectedHour:$selectedMinute $selectedPeriod');
                                  print('Task Note: ${_taskNoteController.text}');
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Card(
                        color: Colors.orange,
                        elevation: 5,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: hours.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Center(
                                  child: Text(
                                    hours[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedHour = hours[index];
                                  });
                                },
                                selected: selectedHour == hours[index],
                                selectedTileColor: Colors.deepOrange,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Card(
                        color: Colors.orange,
                        elevation: 5,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: minutes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Center(
                                  child: Text(
                                    minutes[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedMinute = minutes[index];
                                  });
                                },
                                selected: selectedMinute == minutes[index],
                                selectedTileColor: Colors.deepOrange,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Card(
                        color: Colors.orange,
                        elevation: 5,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: periods.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Center(
                                  child: Text(
                                    periods[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedPeriod = periods[index];
                                  });
                                },
                                selected: selectedPeriod == periods[index],
                                selectedTileColor: Colors.deepOrange,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 5,
                shadowColor: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Task Note',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _taskNoteController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          ),
                          filled: true,
                          hintText: 'Enter task note',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              widget.onSubmit(
                                _taskNameController.text,
                                _taskNoteController.text,
                                selectedHour,
                                selectedMinute,
                                selectedPeriod,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
