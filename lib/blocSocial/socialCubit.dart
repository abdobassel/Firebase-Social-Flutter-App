import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/cache_helper/cache_helper.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/layout/chats/chatsScreen.dart';
import 'package:social_firebase_course/layout/feeds/feeds.dart';
import 'package:social_firebase_course/layout/settings/settingsScreen.dart';
import 'package:social_firebase_course/layout/users/usersScreen.dart';
import 'package:social_firebase_course/models/createuser.dart';
import "package:http/http.dart" as http;
import 'package:social_firebase_course/models/post_model.dart';
import 'package:social_firebase_course/modules/newpost/new_postScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  void getUserData() {
    uId = cacheHelper.getData(key: 'uId');

    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccesState());
      //  print(value.data());
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

//cover
  File? coverImage;
  Future<void> getImageCover() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverPickedSuccsessState());
    } else {
      print('no img selected');
      emit(SocialCoverPickedErrorState());
    }
  }

  //upload firestorasge cover img prof
  // will delete string coverurl and imgurl
  //and replace them by updateuser()
  // String profImgUrl = '';
  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profilImage!.path).pathSegments.last}')
        .putFile(profilImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //
        //  profImgUrl = value;
        updateUser(name: name, bio: bio, phone: phone, image: value);
        // emit(SocialUploadProfileImgSuccessState());
        print(value);
      }).catchError((erorr) {
        print(erorr.toString());
        emit(SocialUploadProfileImgErorrState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUploadProfileImgErorrState());
    });
  }

  // upload cover start
  // String coverUrl = '';
  void uploadCover({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverSuccessState());
        //  coverUrl = value;
        updateUser(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((erorr) {
        print(erorr.toString());
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUploadCoverErrorState());
    });
  }

  //update user
  //هنحذف الميثود دي ونعدل على اللي تحتها
  // لجعلهما دالة واحدة تحدذ البيانات كلها لتحديذ الصور ايضا
  /*
  void updateUserimgs({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateUserLoadingState());
    if (coverImage != null) {
      uploadCover();
    } else if (profilImage != null) {
      uploadProfileImage();
    } else if (coverImage != null && profilImage != null) {
      uploadCover();
      uploadProfileImage();
    } else {
      updateUser(name: name, bio: bio, phone: phone);
    }
  }*/

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) {
    UserModel updatedUser = UserModel(
      name: name,
      bio: bio,
      email: model!.email,
      uId: model!.uId,
      phone: phone,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      isEmailVer: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(updatedUser.toMap())
        .then((value) {
      getUserData();

      // emit(SocialUpdatesuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUpdateUserErrorState());
    });
  }
// Post Functions /////////////////

  File? postImage;
  Future<void> getPostImg() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostPickedSuccessState());
    } else {
      print('no img selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

// post with image
  void createPostImage({
    required String dateTime,
    required String txt,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, txt: txt, postImage: value);

        print(value);
      }).catchError((erorr) {
        print(erorr.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String txt,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      datePost: dateTime,
      name: model!.name,
      txt: txt,
      uId: model!.uId,
      postImage: postImage ?? '',
      image: model!.image,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc('1')
        .set(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void closeImgPost() {
    postImage = null;
    emit(SocialPostImageCloseState());
  }
//////////////////////////////////////////////////////////////////////////////////

  // test django Api
  void getdatatest() async {
    var response = await http.get(Uri.parse('http://10.0.2.2:8000/core/a'));

    //var pdfText = await json.decode(json.encode(response.body));
    var pdfText = await jsonDecode(response.body);
    // print(pdfText);
  }

  //end test django
}
