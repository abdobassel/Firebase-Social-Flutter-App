import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/cache_helper/cache_helper.dart';
import 'package:social_firebase_course/components.dart';
import 'package:social_firebase_course/constants.dart';

import 'package:social_firebase_course/layout/social_layout.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/cubit_register.dart';
import 'package:social_firebase_course/modules/login/bloclogin/regCubit/bloc/states_register.dart';
import 'package:social_firebase_course/modules/login/loginscreen.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var mailcontroller = TextEditingController();

  var pwcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  var phonecontroller = TextEditingController();

  var formRegisterKey = GlobalKey<FormState>();

  bool passwordShow = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          cacheHelper.saveData(key: 'uId', value: state.uId)!.then((value) {
            ShowToast(text: ' تم التسجيل', state: ToastStates.SUCCESS);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return SocialLayout();
              //return Register();
            }), (route) => false);
          });
        } else if (state is RegisterErrorState) {
          ShowToast(
              text: "عفوا هناك خطأ في البيانات", state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
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
                        'Register',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formRegisterKey,
                      child: Column(
                        children: [
                          DefaultTextForm(
                              controller: namecontroller,
                              labeltext: "Full Name ",
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Name empty!!';
                                }
                                return null;
                              },
                              type: TextInputType.name,
                              prefix: Icons.person),
                          DefaultTextForm(
                              controller: mailcontroller,
                              labeltext: "email",
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email can not be empty';
                                }
                                return null;
                              },
                              type: TextInputType.emailAddress,
                              prefix: Icons.email),
                          SizedBox(
                            height: 20,
                          ),
                          DefaultTextForm(
                              showPassfunc: () {
                                setState(() {
                                  passwordShow = !passwordShow;
                                });
                              },
                              isPassword: passwordShow,
                              suffixIcon: passwordShow
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              controller: pwcontroller,
                              labeltext: "password",
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password empty!!';
                                }
                                return null;
                              },
                              type: TextInputType.visiblePassword,
                              prefix: Icons.lock),
                          DefaultTextForm(
                              controller: phonecontroller,
                              labeltext: "Phone",
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone empty!!';
                                }
                                return null;
                              },
                              type: TextInputType.phone,
                              prefix: Icons.phone)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: MaterialButton(
                          onPressed: () {
                            if (formRegisterKey.currentState!.validate()) {
                              RegisterCubit.get(context).postRegister(
                                  email: mailcontroller.text,
                                  password: pwcontroller.text,
                                  phone: phonecontroller.text,
                                  name: namecontroller.text);
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
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
                            Text("you have an account?"),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }), (route) => true);
                                },
                                child: Text("Login Now")),
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
