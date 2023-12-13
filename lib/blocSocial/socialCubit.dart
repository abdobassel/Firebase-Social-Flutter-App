import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/layout/chats/chatsScreen.dart';
import 'package:social_firebase_course/layout/feeds/feeds.dart';
import 'package:social_firebase_course/layout/settings/settingsScreen.dart';
import 'package:social_firebase_course/layout/users/usersScreen.dart';
import 'package:social_firebase_course/models/createuser.dart';
import "package:http/http.dart" as http;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(super.initialState);

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  List<Widget> screens = [
    FeedsScrenn(),
    Chats_Screnn(),
    UsersScrenn(),
    Settings_Screnn(),
  ];
  List<String> titles = [
    'Feeds ',
    'chats',
    'users',
    'Settings',
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  void getUserData() async {
    emit(SocialGetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccesState());
      print(value.data());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  // test django Api
  void getdatatest() async {
    var response = await http.get(Uri.parse('http://10.0.2.2:8000/core/a'));

    //var pdfText = await json.decode(json.encode(response.body));
    var pdfText = await jsonDecode(response.body);
    // print(pdfText);
  }

  //end test django
}
