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
        builder: (BuildContext context, state) {
          var model = SocialCubit.get(context).model;
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
                                image: NetworkImage('${model?.cover}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      CircleAvatar(
                        radius: 61,
                        child: CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage('${model?.image}'),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${model?.name}'),
                  Text(
                    '${model?.bio}',
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
