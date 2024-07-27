import 'package:flutter/material.dart';
import 'tasks.dart';

class TargetPage extends StatefulWidget {
  @override
  _TargetPageState createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  final List<Map<String, String>> _tasks = [];

  void _addTask(String name, String note, String hour, String minute, String period) {
    setState(() {
      _tasks.add({
        'name': name,
        'note': note,
        'time': '$hour:$minute $period',
      });
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _markAsCompleted(int index) {
    setState(() {
      _tasks[index]['completed'] = 'true';
    });
  }

  void _editTask(int index, String name, String note, String hour, String minute, String period) {
    setState(() {
      _tasks[index] = {
        'name': name,
        'note': note,
        'time': '$hour:$minute $period',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          final isCompleted = task['completed'] == 'true';
          return Card(
            color: isCompleted ? Colors.grey : Colors.white,
            child: ListTile(
              title: Text(
                task['name']!,
                style: TextStyle(
                  decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task['note']!),
                  Text(task['time']!),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPage(
                            onSubmit: (name, note, hour, minute, period) {
                              _editTask(index, name, note, hour, minute, period);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteTask(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      _markAsCompleted(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPage(onSubmit: _addTask),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
