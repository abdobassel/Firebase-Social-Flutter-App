import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/appBloc/appstates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(super.initialState);

  static AppCubit get(context) => BlocProvider.of(context);
}
