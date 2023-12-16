import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';

class Chats_Screnn extends StatelessWidget {
  const Chats_Screnn({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (context) => SocialCubit(SocialinitState()),
        child: BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (BuildContext context, state) {
              return Center(child: Text('data'));
            }));
  }
}
