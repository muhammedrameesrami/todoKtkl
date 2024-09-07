import 'package:flutter/material.dart';

class Ctegorydetailscreen extends StatefulWidget {
  final String name;
  final IconData icon;
  final String details;

  const Ctegorydetailscreen({
    Key? key,
    required this.name,
    required this.icon,
    required this.details,
  }) : super(key: key);

  @override
  State<Ctegorydetailscreen> createState() => _CtegorydetailscreenState();
}

class _CtegorydetailscreenState extends State<Ctegorydetailscreen> {
  // List to store tasks
  final List<Map<String, dynamic>> _tasks = [];

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController _taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _taskController,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your task...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final taskText = _taskController.text;
                    if (taskText.isNotEmpty) {
                      setState(() {
                        _tasks.add({
                          'task': taskText,
                          'isCompleted': false,
                        });
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Icon(widget.icon, size: 50, color: Colors.black),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.details,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildSectionTitle('Today'),
          ..._tasks
              .where((task) => task['isCompleted'] == false)
              .map((task) => _buildTaskItem(
                    task['task'],
                    task['isCompleted'],
                    _tasks.indexOf(task),
                  )),
          _buildSectionTitle('Completed'),
          ..._tasks
              .where((task) => task['isCompleted'] == true)
              .map((task) => _buildTaskItem(
                    task['task'],
                    task['isCompleted'],
                    _tasks.indexOf(task),
                  )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String task, bool isCompleted, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 12), // Space between avatar and icon/text
          GestureDetector(
            onTap: () => _toggleTaskCompletion(index),
            child: Icon(
              isCompleted ? Icons.check_circle : Icons.circle_outlined,
              size: 25,
              color: isCompleted ? Colors.green : Colors.grey[400],
            ),
          ),
          SizedBox(width: 12), // Space between icon and text
          Expanded(
            child: Text(
              task,
              style: TextStyle(
                fontSize: 16,
                color: isCompleted ? Colors.black : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
