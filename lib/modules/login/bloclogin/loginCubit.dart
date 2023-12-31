import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/modules/login/bloclogin/loginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(super.initialState);

  static LoginCubit get(context) => BlocProvider.of(context);

  bool ispassword = true;

  void changeShowPassword() {
    ispassword = !ispassword;
    emit(LoginChangPasswordShowState());
  }

//10.0.2.2
  void postLogin({required String email, required String password}) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);

      uId = value.user?.uid;
      // object to access data
      //    print(shopLoginModel?.data?.token.toString());

      emit(LoginSuccesState(uId: value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
