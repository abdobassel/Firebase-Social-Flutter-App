import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/layout/chats/chatDetailsScreen.dart';
import 'package:social_firebase_course/models/createuser.dart';

class Chats_Screnn extends StatelessWidget {
  Chats_Screnn({super.key});

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

Widget BuildChatUser(UserModel model, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatDetailsScreen(userModel: model);
          }));
        },
        child: Row(
          children: [
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage('${model.image}')),
            SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: TextStyle(height: 1.3),
            ),
            Spacer(),
            FaIcon(
              FontAwesomeIcons.solidCircle,
              color: Colors.green,
              size: 16,
            ),
            SizedBox(
              width: 10,
            ),
            FaIcon(
              FontAwesomeIcons.phone,
              size: 16,
              color: Colors.grey[250],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
