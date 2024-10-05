

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/screens/categorypage.dart';
import 'package:todoapp/screens/login.dart';

import '../blocs/comonCubit/currentuser_cubit.dart';
import '../models/userModel.dart';

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
      if(pref.containsKey('id')){
final user= await FirebaseFirestore.instance.collection('user').doc(pref.getString('id')).get();
final usermodel=UserModel.fromMap(user.data() as Map<String,dynamic>);
context.read<CurrentuserCubit>().updateUser(usermodel: usermodel);
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
