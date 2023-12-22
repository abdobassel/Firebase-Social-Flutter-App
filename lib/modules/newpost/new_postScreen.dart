import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});
  var txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: DefaultAppBarSocial(
              context: context,
              title: 'Create Post',
              actions: [
                TextButton(
                    onPressed: () {
                      var now = DateTime.now();
                      print(now.toString());
                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                            dateTime: now.toString(), txt: txtController.text);
                      } else {
                        SocialCubit.get(context).createPostImage(
                            dateTime: now.toString(), txt: txtController.text);
                      }
                    },
                    child: Text(
                      'Post',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
                SizedBox(
                  width: 15,
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              if (state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
              if (state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 5,
                ),
              Row(children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://www.shorturl.at/img/shorturl-icon.png'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Abdo Bassel',
                    style: TextStyle(height: 1.3),
                  ),
                ),
              ]),
              Expanded(
                child: TextFormField(
                  controller: txtController,
                  decoration: InputDecoration(
                    hintText: 'What is on your mind bro....',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (SocialCubit.get(context).postImage != null)
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            SocialCubit.get(context).closeImgPost();
                          },
                        )),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.image),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Add Photo'),
                      ],
                    ),
                    onPressed: () {
                      SocialCubit.get(context).getPostImg();
                    },
                  )),
                  Expanded(
                      child: TextButton(
                    child: Text('# tags'),
                    onPressed: () {},
                  ))
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
