import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/authbloc/auth_bloc.dart';
import 'package:todoapp/core/snackbar.dart';
import 'package:todoapp/screens/categorypage.dart';
import 'package:todoapp/screens/createaccount.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Center(
                child: Image.asset(
                  'asset/images/mimooo.jpg',
                  height: 150,
                ),
              ),
              SizedBox(height: 50),
              // Email TextField with shadow and increased width
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
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "email is missing";
                      }
                      return null;
                    },
                      controller: email,
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
              // Password TextField with shadow and increased width
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
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "password is missing";
                        }
                        return null;
                      },
                      controller: password,
                      autofillHints: const [AutofillHints.password],
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
              // Forgot Password text
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Add forgot password functionality
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Continue Button with increased width
              Center(
                child: SizedBox(
                  width: 330, // Adjust the width as needed
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                     if(state is AuthSuccess){
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Category(),), (route) => false,);
                     }
                     if(state is AuthFailure){
                       showSnackBarMessage(message: 'error on login ', context: context);
                     }
                    },
                    builder: (context, state) {
                      if(state is AuthLoading){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return ElevatedButton(
                        onPressed: () {
                          print('111111111111');
                          if(email.text.isNotEmpty&&password.text.isNotEmpty){
                         context.read<AuthBloc>().add(loginEvent(email: email.text.trim(), password: password.text.trim()));}
                          else{
                            showSnackBarMessage(message: 'please fill the field ', context: context);
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
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Register Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account?"),
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
      ),
    );
  }
}
