import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_firebase_course/blocSocial/SocialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';
import 'package:social_firebase_course/constants.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              actions: [
                TextButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: Text('Logout'))
              ],
            ),
            body: Conditional.single(
                context: context,
                conditionBuilder: (context) => model != null,
                widgetBuilder: (context) => Column(
                      children: [
                        if (model?.isEmailVer == false)
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
                          )
                      ],
                    ),
                fallbackBuilder: (context) =>
                    Center(child: CircularProgressIndicator())));
      },
    );
  }
}
