import 'package:social_firebase_course/models/login_model.dart';

abstract class LoginStates {}

class LoginitState extends LoginStates {}

class LoginSuccesState extends LoginStates {
  final ShopLoginModel? shopLoginModel;

  final String? uId;

  LoginSuccesState({
    this.shopLoginModel,
    this.uId,
  });
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginChangPasswordShowState extends LoginStates {}
