import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_firebase_course/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/bloc_observer.dart';
import 'package:social_firebase_course/modules/login/loginscreen.dart';
import 'package:social_firebase_course/shared/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await cacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: lightTheme,
    );
  }
}
