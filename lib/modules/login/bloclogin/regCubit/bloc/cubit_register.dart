import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/models/createuser.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/states_register.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(super.initialState);

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool ispassword = true;

  void changeShowPassword() {
    ispassword = !ispassword;
    emit(RegisterChangPasswordShowState());
  }

  void postRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      createUser(email: email, phone: phone, name: name, uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  // createUserFireStore

  void createUser(
      {required String email,
      required String uId,
      required String phone,
      required String name}) async {
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      isEmailVer: false,
      bio: 'Write Your bio here.....',
      image:
          'https://avatars.githubusercontent.com/u/37000856?s=400&u=869f0cd5eb86ab59ffee2c53ef195a35826e7827&v=4',
      cover:
          'https://img.freepik.com/free-photo/triumphing-happy-guy-raises-clenched-fist-celebrates-winning-lottery-gets-message-confirming-holds-mobile-phone-browses-social-media-wears-yellow-hat-striped-jumper-always-stays-touch_273609-31312.jpg?w=996&t=st=1702504239~exp=1702504839~hmac=6874839c6adb6eb8ebd6bc4a9557968c850b02bc901934e7826e97b46251bb66',
    );
    emit(CreateUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print('succses');
      emit(CreateUserSuccessState(uId: uId));
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
