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
    UserModel model =
        UserModel(email: email, phone: phone, name: name, uId: uId);
    emit(CreateUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print('succses');
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
