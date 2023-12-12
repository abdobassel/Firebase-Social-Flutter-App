import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/models/createuser.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(super.initialState);

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model;

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
}
