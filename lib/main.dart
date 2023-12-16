import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_firebase_course/appBloc/appcubit.dart';
import 'package:social_firebase_course/appBloc/appstates.dart';
import 'package:social_firebase_course/blocSocial/SocialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/cache_helper/cache_helper.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/bloc_observer.dart';
import 'package:social_firebase_course/layout/social_layout.dart';
import 'package:social_firebase_course/modules/login/bloclogin/loginCubit.dart';
import 'package:social_firebase_course/modules/login/bloclogin/loginStates.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/cubit_register.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/states_register.dart';
import 'package:social_firebase_course/modules/login/loginscreen.dart';
import 'package:social_firebase_course/shared/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await cacheHelper.init();
  Widget widget;
  uId = cacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  SocialCubit(SocialinitState())..getUserData()),
          BlocProvider(create: (context) => RegisterCubit(RegisteritState())),
          BlocProvider(create: (context) => LoginCubit(LoginitState())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: startWidget,
          theme: lightTheme,
        ));
  }
}








/*



 */