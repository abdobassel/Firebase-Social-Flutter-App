import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/cubit_register.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/states_register.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text('Heelo')),
        );
      },
    );
  }
}
