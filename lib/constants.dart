import 'package:flutter/material.dart';
import 'package:social_firebase_course/cache_helper/cache_helper.dart';
import 'package:social_firebase_course/modules/login/loginscreen.dart';

String? uId = '';

void signOut(context) {
  cacheHelper.removeData(key: 'uId').then((value) {
    if (value != null) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false);
      }
    }
  });
}
