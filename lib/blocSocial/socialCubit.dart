import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/layout/chats/chatsScreen.dart';
import 'package:social_firebase_course/layout/feeds/feeds.dart';
import 'package:social_firebase_course/layout/settings/settingsScreen.dart';
import 'package:social_firebase_course/layout/users/usersScreen.dart';
import 'package:social_firebase_course/models/createuser.dart';
import "package:http/http.dart" as http;
import 'package:social_firebase_course/modules/newpost/new_postScreen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(super.initialState);

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model;

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScrenn(),
    Chats_Screnn(),
    NewPostScreen(),
    UsersScrenn(),
    Settings_Screnn(),
  ];

  List<String> titles = ['Feeds ', 'chats', 'Add Post', 'users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
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

  //images profile and cover picked
  var picker = ImagePicker();

  File? profilImage;
  Future<void> getImageprofile() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profilImage = File(pickedFile.path);
      emit(SociaProfilePickedSuccessState());
    } else {
      print('no img selected');
      emit(SociaProfilePickedErrorState());
    }
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
