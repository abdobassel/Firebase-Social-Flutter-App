import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/models/createuser.dart';
import 'package:social_firebase_course/models/message_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  ChatDetailsScreen({super.key, required this.userModel});
  var messageController = TextEditingController();
  final _controler = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId!);

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
                body: Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        SocialCubit.get(context).isLoadingGetMesgs == false,
                    widgetBuilder: (context) => Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  controller: _controler,
                                  itemBuilder: (context, index) {
                                    var witchMessage = SocialCubit.get(context)
                                        .messages[index];

                                    if (SocialCubit.get(context).model!.uId ==
                                        witchMessage.senderId) {
                                      return BuildMyMessage(witchMessage);
                                    } else {
                                      return BuildMessage(witchMessage);
                                    }
                                  },
                                  itemCount:
                                      SocialCubit.get(context).messages.length,
                                ),
                              ),
                              if (SocialCubit.get(context).messageImg != null)
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: FileImage(
                                              SocialCubit.get(context)
                                                  .messageImg!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .closeImgMessage();
                                          },
                                        )),
                                  ],
                                ),
                              SizedBox(
                                height: 20,
                              ),
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
                                        if (SocialCubit.get(context)
                                                .messageImg ==
                                            null) {
                                          SocialCubit.get(context).SendMessages(
                                            dateTime: now,
                                            reciverId: userModel.uId!,
                                            text: messageController.text,
                                          );
                                          messageController.clear();
                                          _controler.animateTo(
                                              _controler
                                                  .position.maxScrollExtent,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.fastOutSlowIn);
                                        } else {
                                          SocialCubit.get(context)
                                              .UploadImageMessage(
                                            dateTime: now,
                                            recieverId: userModel.uId!,
                                            text: messageController.text,
                                          );

                                          SocialCubit.get(context)
                                              .closeImgMessage();
                                          messageController.clear();
                                          messageController.clear();
                                          _controler.animateTo(
                                              _controler
                                                  .position.maxScrollExtent,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.fastOutSlowIn);
                                        }
                                      },
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    MaterialButton(
                                      minWidth: 1.0,
                                      onPressed: () {
                                        var now = DateTime.now().toString();
                                        SocialCubit.get(context)
                                            .getMessageImage();
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    fallbackBuilder: (context) =>
                        Center(child: CircularProgressIndicator())));
          });
    });
  }

  Widget BuildMessage(MessageModel messageModel) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0),
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(10.0))),
            child: Text('${messageModel.txt}'),
          ),
        ),
      );
  Widget BuildMyMessage(MessageModel messageModel) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0),
                    bottomStart: Radius.circular(10.0),
                    topStart: Radius.circular(10.0))),
            child: Text('${messageModel.txt}'),
          ),
        ),
      );
}
