import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/apiDio/apidio.dart';
import 'package:social_firebase_course/models/login_model.dart';
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

      emit(RegisterSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
