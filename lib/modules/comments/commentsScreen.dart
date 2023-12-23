import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(builder: (context, state) {
      return Scaffold(
        appBar: DefaultAppBarSocial(
          context: context,
          title: 'Comments',
        ),
      );
    });
  }
}
