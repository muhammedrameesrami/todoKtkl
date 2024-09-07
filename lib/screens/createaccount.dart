import 'package:flutter/material.dart';
import 'package:todoapp/cbservices/loginservice.dart';
import 'package:todoapp/screens/categorypage.dart';
import 'package:todoapp/screens/login.dart';

class Createaccountpage extends StatefulWidget {
  const Createaccountpage({super.key});

  @override
  State<Createaccountpage> createState() => _CreateaccountpageState();
}

class _CreateaccountpageState extends State<Createaccountpage> {
  final _formKey = GlobalKey<FormState>();
  String? fullName, email, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with Back Button
              Center(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),

              // Full Name TextField
              Center(
                child: SizedBox(
                  width: 330,
                  child: Container(
                    decoration: _inputDecoration(),
                    child: TextFormField(
                      decoration: _inputFieldDecoration('Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onSaved: (value) => fullName = value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Email TextField
              Center(
                child: SizedBox(
                  width: 330,
                  child: Container(
                    decoration: _inputDecoration(),
                    child: TextFormField(
                      decoration: _inputFieldDecoration('Email'),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Password TextField
              Center(
                child: SizedBox(
                  width: 330,
                  child: Container(
                    decoration: _inputDecoration(),
                    child: TextFormField(
                      obscureText: true,
                      decoration: _inputFieldDecoration('Password'),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) => password = value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Confirm Password TextField
              Center(
                child: SizedBox(
                  width: 330,
                  child: Container(
                    decoration: _inputDecoration(),
                    child: TextFormField(
                      obscureText: true,
                      decoration: _inputFieldDecoration('Confirm Password'),
                      validator: (value) {
                        if (value != password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) => confirmPassword = value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Continue Button
              Center(
                child: SizedBox(
                  width: 330,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Insert the user data into the database
                        Map<String, dynamic> newUser = {
                          'fullName': fullName,
                          'email': email,
                          'password': password,
                        };

                        await DBHelper().insertUser(newUser);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Category(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 90, 159),
                      shape: RoundedRectangleBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Loginpage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Common Input Decoration Box
  BoxDecoration _inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    );
  }

  // Common Input Field Decoration
  InputDecoration _inputFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      fillColor: Colors.white,
      filled: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
