import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/layout/chats/chatDetailsScreen.dart';
import 'package:social_firebase_course/layout/chats/chatsScreen.dart';
import 'package:social_firebase_course/models/createuser.dart';

class UsersScrenn extends StatelessWidget {
  const UsersScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                SocialCubit.get(context).users.length > 0,
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
            widgetBuilder: (context) => ListView.builder(
              itemBuilder: (context, index) =>
                  BuildChatUser(SocialCubit.get(context).users[index], context),
              itemCount: SocialCubit.get(context).users.length,
              physics: BouncingScrollPhysics(),
            ),
          );
        });
  }
}
