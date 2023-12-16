import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_firebase_course/blocSocial/SocialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/constants.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        /* if (state is SocialNewPostState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewPostScreen();
          }));
        }*/
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.message), label: 'Chats'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.pen), label: 'Post'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.user), label: 'Users'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ]),
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_active_outlined)),
                TextButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: Text('Logout'))
              ],
            ),
            body: Conditional.single(
                context: context,
                conditionBuilder: (context) => true,
                widgetBuilder: (context) => cubit.screens[cubit.currentIndex],
                fallbackBuilder: (context) =>
                    Center(child: CircularProgressIndicator())));
      },
    );
  }
}

/*
  email verified
  Column(
                      children: [
                        //  if (model?.isEmailVer == false)
                        if (FirebaseAuth.instance.currentUser!.emailVerified ==
                            false)
                          Container(
                            height: 56,
                            color: Colors.amber.withOpacity(0.6),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: Text(
                                          'برجاء تأكيد البريد الالكتروني')),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  DefaultButton(
                                      text: 'تأكيد',
                                      function: () {
                                        FirebaseAuth.instance.currentUser
                                            ?.sendEmailVerification()
                                            .then((value) {
                                          ShowToast(
                                              text: 'check your mail',
                                              state: ToastStates.SUCCESS);
                                        }).catchError((error) {});
                                      },
                                      width: 100),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),


*/ 