import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';
import 'package:social_firebase_course/models/createuser.dart';
import 'package:social_firebase_course/modules/editprofile/editprofilescreen.dart';
import 'package:social_firebase_course/modules/newpost/new_postScreen.dart';

// ignore: camel_case_types
class Settings_Screnn extends StatelessWidget {
  Settings_Screnn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(builder: (context, state) {
      var userModel = SocialCubit.get(context).model;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: NetworkImage('${userModel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  CircleAvatar(
                    radius: 61,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 59,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${userModel!.name}'),
              Text(
                '${userModel!.bio}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Posts'),
                          Text(
                            '200',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Friends'),
                          Text(
                            '260',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Likes'),
                          Text(
                            '200',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Followers'),
                          Text(
                            '200',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: DefaultButton(
                          text: "Add Post",
                          function: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewPostScreen();
                            }));
                          })),
                  SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfileScreen();
                        }));
                      },
                      child: FaIcon(
                        FontAwesomeIcons.edit,
                        size: 20,
                      ))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
