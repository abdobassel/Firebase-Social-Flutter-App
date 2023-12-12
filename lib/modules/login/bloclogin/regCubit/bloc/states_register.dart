import 'package:social_firebase_course/models/login_model.dart';

abstract class RegisterStates {}

class RegisteritState extends RegisterStates {}

class RegisterSuccesState extends RegisterStates {
  final ShopLoginModel? shopRegisterModel;

  RegisterSuccesState({this.shopRegisterModel});
}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterChangPasswordShowState extends RegisterStates {}

class CreateUserLoadingState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {
  final String? uId;

  CreateUserSuccessState({this.uId});
}

class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}
