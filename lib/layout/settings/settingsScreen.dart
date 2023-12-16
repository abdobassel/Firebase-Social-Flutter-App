import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';

// ignore: camel_case_types
class Settings_Screnn extends StatelessWidget {
  Settings_Screnn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://img.freepik.com/free-photo/triumphing-happy-guy-raises-clenched-fist-celebrates-winning-lottery-gets-message-confirming-holds-mobile-phone-browses-social-media-wears-yellow-hat-striped-jumper-always-stays-touch_273609-31312.jpg?w=996&t=st=1702504239~exp=1702504839~hmac=6874839c6adb6eb8ebd6bc4a9557968c850b02bc901934e7826e97b46251bb66'),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      CircleAvatar(
                        radius: 61,
                        child: CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/triumphing-happy-guy-raises-clenched-fist-celebrates-winning-lottery-gets-message-confirming-holds-mobile-phone-browses-social-media-wears-yellow-hat-striped-jumper-always-stays-touch_273609-31312.jpg?w=996&t=st=1702504239~exp=1702504839~hmac=6874839c6adb6eb8ebd6bc4a9557968c850b02bc901934e7826e97b46251bb66'),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('sssssssssssssss'),
                  Text(
                    'I Am Flutter Developer',
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Comments'),
                              Text(
                                '200',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
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
                              text: "Edit Profile", function: () {}))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
