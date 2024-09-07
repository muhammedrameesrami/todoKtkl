import 'package:flutter/material.dart';
import 'package:todoapp/screens/createaccount.dart';

class Forgotpage extends StatefulWidget {
  const Forgotpage({super.key});

  @override
  State<Forgotpage> createState() => _ForgotpageState();
}

class _ForgotpageState extends State<Forgotpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Forgot Password',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),

            // Full Name TextField with shadow and increased width
            Center(
              child: SizedBox(
                width: 330, // Increased width
                child: Container(
                  decoration: BoxDecoration(
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
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Multi-line text with fixed width for 2-line layout
            Center(
              child: Container(
                width: 330, // Set width to make the text fit in 2 lines
                child: Text(
                  'Enter the email address you used to create your account and we will email you a link to reset your password',
                  textAlign: TextAlign.center, // Center-aligns the text
                  style:
                      TextStyle(fontSize: 12), // Adjust the font size if needed
                ),
              ),
            ),

            SizedBox(height: 20),

            // Continue Button with increased width
            Center(
              child: SizedBox(
                width: 330, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Add continue functionality
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

            // Register Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Createaccountpage(),
                        ));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
