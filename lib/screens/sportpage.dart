import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/snackbar.dart';

import '../blocs/todoBloc/todo_bloc.dart';

class Ctegorydetailscreen extends StatefulWidget {
  final String taskId; // Task ID from Firestore
  final String name;
  final IconData icon;
  final String details;

  const Ctegorydetailscreen({
    Key? key,
    required this.taskId, // Pass the task ID
    required this.name,
    required this.icon,
    required this.details,
  }) : super(key: key);

  @override
  State<Ctegorydetailscreen> createState() => _CtegorydetailscreenState();
}

class _CtegorydetailscreenState extends State<Ctegorydetailscreen> {
  final TextEditingController _taskController = TextEditingController();
  final CollectionReference _subtaskCollection = FirebaseFirestore.instance
      .collection('subtasks'); // Reference to Firestore collection

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _taskController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your subtask...',
                  ),
                ),
                const SizedBox(height: 10),
                BlocConsumer<TodoBloc, TodoState>(
                  listener: (context, state) {
                    if (state is ToDoSuccess) {
                      Navigator.of(context).pop();
                    }
                    if (state is ToDoFailure) {
                      showSnackBarMessage(message: 'failed', context: context);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is ToDoLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () async {
                        final taskText = _taskController.text;
                        if (taskText.isNotEmpty) {
                          context.read<TodoBloc>().add(AddSubTaskEvent(
                              taskId: widget.taskId, task: taskText.trim()));

                          // await _subtaskCollection.add({
                          //   'task': taskText,
                          //   'isCompleted': false,
                          //   'taskId': widget.taskId, // Link to parent task
                          // });
                          // Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add Subtask'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          widget.name,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _subtaskCollection
            .where('taskId',
                isEqualTo: widget.taskId) // Fetch subtasks for this task
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var tasks = snapshot.data!.docs;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Row(
                children: [
                  Icon(widget.icon, size: 50, color: Colors.black),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.details,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Today'),
              ...tasks
                  .where((task) => !task['isCompleted'])
                  .map((task) => _buildTaskItem(
                        task['task'],
                        task['isCompleted'],
                        task.id,
                      )),
              _buildSectionTitle('Completed'),
              ...tasks
                  .where((task) => task['isCompleted'])
                  .map((task) => _buildTaskItem(
                        task['task'],
                        task['isCompleted'],
                        task.id,
                      )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
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

  Widget _buildTaskItem(String task, bool isCompleted, String subtaskId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is ToDoSuccess) {
                showSnackBarMessage(message: 'update added', context: context);
              }
              if (state is ToDoFailure) {
                showSnackBarMessage(message: 'faild', context: context);
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<TodoBloc>().add(UpdateSubTaskEvent(subTaskId: subtaskId,
                      taskId: widget.taskId, task: task,));
                  // await _subtaskCollection.doc(subtaskId).update({
                  //   'isCompleted': !isCompleted, // Toggle completion status
                  // });
                },
                child: Icon(
                  isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  size: 25,
                  color: isCompleted ? Colors.green : Colors.grey[400],
                ),
              );
            },
          ),
          const SizedBox(width: 12),
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
