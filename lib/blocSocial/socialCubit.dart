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
import 'package:social_firebase_course/models/coment_model.dart';
import 'package:social_firebase_course/models/createuser.dart';
import "package:http/http.dart" as http;
import 'package:social_firebase_course/models/message_model.dart';
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
    if (index == 1 || index == 3) {
      getAllUsers();
    }
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
        .add(postModel.toMap())
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

//get posts
  List<PostModel> posts = [];

  List<String> postId = [];
  List<int> likes = [];
  List<int> commentsNum = [];
  String postid = '';

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datePost')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // post id => likes
        String postid = element.id;

        commentsCount(postid);
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);

          postId.add(element.id);

          posts.add(PostModel.fromJson(element.data()));

          emit(SocialGetPostsSuccesState());
          /*  element.reference.collection('comments').get().then((value) {
            commentsNum.add(value.docs.length);

            emit(SocialGetPostsSuccesState());
          }).catchError((error) {});*/
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
        });
      });
      emit(SocialGetPostsSuccesState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void commentsCount(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      commentsNum.add(value.docs.length);
      emit(SocialGetPostsSuccesState());
    }).catchError((onError) {
      print("Error fetching comments: $onError");
    });
  }

  // likesPost
  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  // comments
  List<CommentModel> commentsModels = [];
  void createComment(
      {required String textComment,
      required String postId,
      required String commentDate,
      String? name,
      String? image}) {
    CommentModel commentModel = CommentModel(
      commentDate: commentDate,
      name: model!.name,
      comment: textComment,
      uId: model!.uId,
      image: model!.image,
      postId: postid,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(uId)
        .set(commentModel.toMap())
        .then((value) {
      commentsModels.add(commentModel);
      emit(SocialCommentPostSuccessState());
      print(commentsModels.length);
    }).catchError((error) {
      emit(SocialCommentPostErrorState());
    });
  }

  List<String> commentList = [];

  void getComments(String postId) {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .orderBy('commentDate')
        .get()
        .then((value) {
      commentsModels = [];

      value.docs.forEach((element) {
        commentList.add(element.id);
        commentsModels.add(CommentModel.fromJson(element.data()));
      });
      print(commentsModels.length);
      emit(SocialGetCommentsSuccesState());
    }).catchError((error) {
      emit(SocialGetCommentsErrorState(error));
    });
  }

// users And Chats
  List<UserModel> users = [];
  void getAllUsers() {
    emit(SocialGetAllUserLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccesState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

// messages
  void SendMessages(
      {required String dateTime,
      required String reciverId,
      required String text,
      String? imageMessage}) {
    MessageModel messageModel = MessageModel(
        ReceiverId: reciverId,
        txt: text,
        dateTime: dateTime,
        imageMessage: imageMessage ?? '',
        senderId: model!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccesState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    // another user same chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccesState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  //get Messages chats
  List<MessageModel> messages = [];
  bool isLoadingGetMesgs = false;
  void getMessages({required String receiverId}) {
    isLoadingGetMesgs = true;
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      isLoadingGetMesgs = false;

      emit(SocialGetMessageSuccesState());
    });
  }

  // mssg img
  File? messageImg;
  Future<void> getMessageImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      messageImg = File(pickedFile.path);
      emit(SociaMessagePickedSuccessState());
    } else {
      print('no img message selected');
      emit(SociaMessagePickedErrorState());
    }
  }

  void UploadImageMessage({
    String? text,
    required String? recieverId,
    required String dateTime,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'users/chats/messages/${Uri.file(messageImg!.path).pathSegments.last}')
        .putFile(messageImg!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        SendMessages(
            dateTime: dateTime,
            reciverId: recieverId!,
            text: text ?? '',
            imageMessage: value);
      }).catchError((erorr) {
        print(erorr.toString());
        emit(SocialUploadMessageImgErorrState());
      });
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUploadCoverErrorState());
    });
  }

  void closeImgMessage() {
    messageImg = null;
    emit(SocialMessageImageCloseState());
  }
}
