

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/screens/categorypage.dart';
import 'package:todoapp/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if(pref.containsKey('email')){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Category(),), (route) => false,);
      }else{
   Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage(),));}
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('asset/images/mimooo.jpg')));
  }
}
