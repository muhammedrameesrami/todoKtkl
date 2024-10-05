import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/blocs/authbloc/auth_bloc.dart';
import 'package:todoapp/blocs/comonCubit/currentuser_cubit.dart';
import 'package:todoapp/blocs/todoBloc/todo_bloc.dart';
import 'package:todoapp/controller/authController.dart';
import 'package:todoapp/controller/todoController.dart';
import 'package:todoapp/repository/authRepository.dart';
import 'package:todoapp/repository/todorepository.dart';
import 'package:todoapp/screens/categorypage.dart';
import 'package:todoapp/screens/createaccount.dart';
import 'package:todoapp/screens/forgot.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/screens/settingsscreen.dart';
import 'package:todoapp/screens/splashScreen.dart';
import 'package:todoapp/screens/sportpage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
      value) =>
      runApp((MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  controller: AuthController(
                      repository:
                      AuthRepository(firebaseAuth: FirebaseAuth.instance)))),
          BlocProvider(create: (context) => TodoBloc(controller: Todocontroller(repository: Todorepository(firebaseAuth: FirebaseAuth.instance,firestore: FirebaseFirestore.instance))),)
      , BlocProvider(create: (context) =>CurrentuserCubit() ,),

        ],
        child: MaterialApp(theme: ThemeData.light(),darkTheme: ThemeData.dark(),themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ))),);
}
