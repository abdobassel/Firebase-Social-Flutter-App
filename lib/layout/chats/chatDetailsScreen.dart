import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/models/createuser.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  ChatDetailsScreen({super.key, required this.userModel});
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${userModel.name}')
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    BuildMessage(),
                    BuildMyMessage(),
                    Spacer(),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type Messages Here...',
                              ),
                            ),
                          ),
                          MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              var now = DateTime.now().toString();
                              SocialCubit.get(context).SendMessages(
                                  dateTime: now,
                                  reciverId: userModel.uId!,
                                  text: messageController.text);
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Widget BuildMessage() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0),
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10.0))),
          child: Text('Hello Dear'),
        ),
      );
  Widget BuildMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0),
                  bottomStart: Radius.circular(10.0),
                  topStart: Radius.circular(10.0))),
          child: Text('Hello Dear'),
        ),
      );
}
