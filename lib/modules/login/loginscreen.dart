import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/cache_helper/cache_helper.dart';
import 'package:social_firebase_course/components.dart';
import 'package:social_firebase_course/constants.dart';
import 'package:social_firebase_course/layout/social_layout.dart';
import 'package:social_firebase_course/modules/login/bloclogin/loginCubit.dart';
import 'package:social_firebase_course/modules/login/bloclogin/loginStates.dart';
import 'package:social_firebase_course/modules/login/register.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var emailcontroller = TextEditingController();

  // var emailcontroller = TextEditingController();

  var pwcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          print(state.error);
          ShowToast(text: state.error.toString(), state: ToastStates.ERROR);
        } else if (state is LoginSuccesState) {
          cacheHelper.saveData(key: 'uId', value: state.uId)!.then((value) {
            ShowToast(
                text: 'تم تسجيل الدخول بنجاح مبروك',
                state: ToastStates.SUCCESS);
            SocialCubit.get(context).getUserData();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return SocialLayout();
              //return Register();
            }), (route) => false);
          });
          /*
          ShowToast(
              text: 'تم تسجيل الدخول بنجاح مبروك',
              state: ToastStates.SUCCESS);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const SocialLayout();
            //return Register();
          }), (route) => false);
          */
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          DefaultTextForm(
                              controller: emailcontroller,
                              labeltext: "email",
                              validate: (value) {
                                if (value != null) {
                                  if (value!.isEmpty) {
                                    return 'Email can not be empty';
                                  }
                                  return null;
                                }
                              },
                              type: TextInputType.emailAddress,
                              prefix: Icons.email),
                          SizedBox(
                            height: 20,
                          ),
                          DefaultTextForm(
                              showPassfunc: () {
                                cubit.changeShowPassword();
                              },
                              isPassword: cubit.ispassword,
                              suffixIcon: cubit.ispassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              controller: pwcontroller,
                              labeltext: "Password",
                              validate: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Password Is Too Short';
                                  }
                                  return null;
                                }
                              },
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.postLogin(
                                      email: emailcontroller.text,
                                      password: pwcontroller.text);
                                }
                              },
                              type: TextInputType.visiblePassword,
                              prefix: Icons.lock),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            state is! LoginLoadingState,
                        widgetBuilder: (context) => DefaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.postLogin(
                                  email: emailcontroller.text,
                                  password: pwcontroller.text);
                            }
                          },
                          text: 'login',
                          isUperCase: true,
                          radius: 15,
                        ),
                        fallbackBuilder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have account?"),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Register();
                                    //return Register();
                                  }), (route) => true);
                                },
                                child: Text("Rigester Now")),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
