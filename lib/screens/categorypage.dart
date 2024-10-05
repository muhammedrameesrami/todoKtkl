import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cbservices/cbservices.dart';
import 'package:todoapp/controller/todoctrler.dart';
import 'package:todoapp/models/userModel.dart';
import 'package:todoapp/screens/settingsscreen.dart';
import 'package:todoapp/screens/sportpage.dart';

import '../blocs/comonCubit/currentuser_cubit.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // Controllers for text fields
  TextEditingController titleController = TextEditingController();
  TextEditingController tasksController = TextEditingController();

  // Variable to store selected icon
  IconData? selectedIcon;
  List<Map<String, dynamic>> categories = [];

  // Instance of Dbservice
  final Dbservice dbService = Dbservice();

  // List of icon names and their corresponding icons
  final List<String> iconNames = [
    'star',
    'favorite',
    'person',
    'settings',
    'notifications',
    'search',
    'info',
    // Add other icon names here
  ];

  final List<IconData> iconList = [
    Icons.add_circle,
    Icons.home,
    Icons.settings,
    Icons.star,
    Icons.favorite,
    Icons.person,
    Icons.settings,
    Icons.notifications,
    Icons.search,
    Icons.info,
    // Add corresponding IconData objects here
  ];

  // Function to get the icon based on the name
  IconData getIconByName(String name) {
    int index = iconNames.indexOf(name);
    return index != -1 ? iconList[index] : Icons.help; // Default icon
  }

  @override
  void initState() {
    super.initState();
    // Initialize the database
    dbService.initialisedb().then((_) {
      _loadCategories();
    });
  }

  // Function to load categories from database
  Future<void> _loadCategories() async {
    final List<Map<String, dynamic>> results = await dbService.getValues();
    setState(() {
      categories = results;
    });
  }

  // Function to show popup with dropdown and text fields
  void _showAddPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                height: 260, // Adjust height to fit dropdown and text fields
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Dropdown for selecting an icon
                    DropdownButton<String>(
                      value: selectedIcon != null
                          ? iconNames[iconList.indexOf(selectedIcon!)]
                          : null,
                      hint: Text('Select Icon'),
                      isExpanded: true,
                      underline: SizedBox.shrink(), // Remove the underline
                      items: iconNames.map((String name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Row(
                            children: [
                              Icon(
                                getIconByName(name),
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedIcon =
                              getIconByName(newValue!); // Update selected icon
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // TextField for Title
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        border: InputBorder.none, // Remove border
                      ),
                    ),
                    SizedBox(height: 10),
                    // TextField for Tasks
                    TextField(
                      controller: tasksController,
                      decoration: InputDecoration(
                        hintText: '0 task',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        border: InputBorder.none, // Remove border
                      ),
                      keyboardType:
                          TextInputType.number, // Set input type to numbers
                    ),
                    BlocBuilder<CurrentuserCubit, UserModel?>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (selectedIcon != null &&
                                titleController.text.isNotEmpty &&
                                tasksController.text.isNotEmpty) {
                              String taskId = FirebaseFirestore.instance
                                  .collection('task')
                                  .doc()
                                  .id;
                              // Add data to Firestore
                              await FirebaseFirestore.instance
                                  .collection('task')
                                  .doc(taskId)
                                  .set({
                                'userId': state!.id,
                                'id': taskId, // Unique ID for the task
                                'title': titleController
                                    .text, // Title from the input field
                                'icon': iconNames[iconList.indexOf(
                                    selectedIcon!)], // Selected icon name
                                'taskCount': int.parse(tasksController
                                    .text), // Task count (converted to int)
                              });
                              // await dbService.addvalues(
                              //   name: titleController.text,
                              //   icon: iconNames[iconList.indexOf(selectedIcon!)],
                              //   details: tasksController.text,
                              // );
                              titleController.clear();
                              tasksController.clear();
                              setState(() {
                                selectedIcon = null; // Reset the selected icon
                              });
                              Navigator.of(context).pop();
                              _loadCategories(); // Reload categories after adding
                            }
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settingspage(),
                  ));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('asset/images/ney.jpg'),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
        title: Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Container(
            height: 100, // Adjust height as needed
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('asset/images/ney.jpg'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '"The memories is a shield and life helper"',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Tamim Al-Barghouty'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('task')
                            .where('userId',
                                isEqualTo:'dx6K0FemYgWzjcXs0Khf0a7F1gN2')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(child: Text('Error fetching data'));
                          }

                          if (!snapshot.hasData) {
                            return Center(child: Text('No tasks found'));
                          }

                          final List<DocumentSnapshot> tasks = snapshot.data!.docs;

                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: tasks.length +
                                1, // categories.length + 1 // Add 1 for the "Add" icon
                            itemBuilder: (context, index) {
                              if (index == 0 ) {
                                // Always show the "Add" button at the first index
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                    onPressed: _showAddPopup,
                                  ),
                                );
                              }

                              final categoryData = tasks[index - 1];
                              final String title = categoryData['title'] ?? 'Untitled';
                              final int taskCount = categoryData['taskCount'] ?? 0;
                              final IconData icon =
                                  getIconByName(categoryData['icon'] ?? 'help');
                              //hive
                              // final category =
                              //     categories[index - 1]; // Adjust index for categories
                              // IconData iconData = Icons.help; // Default icon
                              // try {
                              //   iconData =
                              //       getIconByName(category['icon'] ?? ''); // Get icon by name
                              // } catch (e) {
                              //   // Handle exception if icon is not valid
                              // }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Ctegorydetailscreen(
                                          taskId:
                                              categoryData.id, // Pass the task title
                                          icon: icon, // Pass the selected icon
                                          name: 'nam', details: 'sds',
                                        ),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              icon,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              title,
                                              // category['name'] ?? 'No Title',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              '$taskCount tasks',
                                              // '${category['details'] ?? '0'} task',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () {
                                            // Handle action when the more icon is tapped
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
          ),
        ],
      ),
    );
  }
}
