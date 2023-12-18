import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';
import 'package:social_firebase_course/models/createuser.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).model;
          var profileImage = SocialCubit.get(context).profilImage;

          var coverImage = SocialCubit.get(context).coverImage;
          nameController.text = model?.name ?? 'name';
          bioController.text = model?.bio ?? 'name';
          return Scaffold(
            appBar: DefaultAppBarSocial(
                context: context,
                title: 'Edit Profile',
                actions: [
                  TextButton(
                      onPressed: () {
                        SocialCubit.get(context).uploadProfileImage();
                      },
                      child: Text(
                        'Update',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      )),
                  SizedBox(
                    width: 15,
                  )
                ]),
            body: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${model?.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: IconButton(
                                    icon: FaIcon(FontAwesomeIcons.camera),
                                    onPressed: () {
                                      SocialCubit.get(context).getImageCover();
                                    },
                                  )),
                            ],
                          )),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 61,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 59,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${model?.image}')
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.camera),
                                onPressed: () {
                                  SocialCubit.get(context).getImageprofile();
                                },
                              )),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  DefaultTextForm(
                      controller: nameController,
                      labeltext: 'User Name',
                      validate: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Name Is Required';
                          }
                          return null;
                        }
                      },
                      type: TextInputType.text,
                      prefix: FontAwesomeIcons.user),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextForm(
                      controller: bioController,
                      labeltext: 'Write Bio',
                      validate: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Bio Is Short';
                          }
                          return null;
                        }
                      },
                      type: TextInputType.text,
                      prefix: FontAwesomeIcons.infoCircle),
                ],
              ),
            ),
          );
        });
  }
}
