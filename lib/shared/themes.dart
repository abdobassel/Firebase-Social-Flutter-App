import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.green,
  primarySwatch: Colors.blue,
  fontFamily: 'cairo',
  useMaterial3: true,
  progressIndicatorTheme:
      ProgressIndicatorThemeData(circularTrackColor: Colors.blue),
  inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: const Color.fromARGB(255, 196, 207, 216)),
      hintStyle: TextStyle(color: Colors.blue)),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white),
      backgroundColor: Colors.white),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.3,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Color(0xff313737),
  useMaterial3: true,
  appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Color(0xff313737)),
      backgroundColor: Color(0xff313737)),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: 16,
      height: 1.3,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff313737),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
  ),
);
