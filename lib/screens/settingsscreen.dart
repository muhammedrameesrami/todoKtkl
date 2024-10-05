import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/blocs/comonCubit/currentuser_cubit.dart';
import 'package:todoapp/models/userModel.dart';
import 'package:todoapp/screens/login.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showImageSourceSelection() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Select Image Source'),
            actions: [
              TextButton(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Settings'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('asset/images/ney.jpg') as ImageProvider,
                  backgroundColor: Colors.blue,
                  radius: 25,
                ),
                SizedBox(
                  width: 30,
                ),
                BlocBuilder<CurrentuserCubit, UserModel?>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(
                          state!.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.email,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    );
                  },
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    onPressed: _showImageSourceSelection,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Hi! my name is Malak, I'm a community manager\nfrom Rabat Morocco ",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  ),
                ),
                Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () async {
                      SharedPreferences prefrence = await SharedPreferences
                          .getInstance();
                      prefrence.remove("email");
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => Loginpage(),), (
                            route) =>
                        false,);
                    },
                    icon: Icon(Icons.logout),
                  ),
                ),
                Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                  ),
                ),
                Text(
                  'General',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                  ),
                ),
                Text(
                  'Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.error),
                  ),
                ),
                Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
