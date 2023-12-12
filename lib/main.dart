import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_firebase_course/cache_helper/cache_helper.dart';
import 'package:social_firebase_course/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/bloc_observer.dart';
import 'package:social_firebase_course/layout/social_layout.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/cubit_register.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/states_register.dart';
import 'package:social_firebase_course/modules/login/loginscreen.dart';
import 'package:social_firebase_course/shared/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await cacheHelper.init();
  Widget widget;
  var uId = cacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
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
        BlocProvider(create: (context) => RegisterCubit(RegisteritState())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: lightTheme,
      ),
    );
  }
}
