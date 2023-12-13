import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';

class FeedsScrenn extends StatelessWidget {
  FeedsScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(10.0),
          elevation: 10.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(alignment: Alignment.bottomRight, children: [
            Image(
              image: NetworkImage(imglink2),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Communicate With Friends',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          ]),
        ),
        Card(
          margin: EdgeInsets.all(10.0),
          elevation: 10.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(img1),
            )
          ]),
        ),
      ],
    );
  }

  String img1 =
      'https://img.freepik.com/free-photo/triumphing-happy-guy-raises-clenched-fist-celebrates-winning-lottery-gets-message-confirming-holds-mobile-phone-browses-social-media-wears-yellow-hat-striped-jumper-always-stays-touch_273609-31312.jpg?w=996&t=st=1702504239~exp=1702504839~hmac=6874839c6adb6eb8ebd6bc4a9557968c850b02bc901934e7826e97b46251bb66';
  String imglink2 =
      'https://img.freepik.com/premium-photo/field-hockey-players-during-tournament-game_23-2149668592.jpg?w=1060';
  String imgLink =
      'https://img.freepik.com/free-photo/sale-fashion-discounts-online-shopping-concept-overjoyed-dark-skinned-woman-chooses-clothes-clothing-store-rejoices-big-sales-holds-mobile_273609-32763.jpg?w=996&t=st=1702504153~exp=1702504753~hmac=f67edea3266dbac5673a758245d77f367a93a1ac231fa6caa9dcce3a93b66bf0';
  String img3 =
      'https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?w=996&t=st=1702504117~exp=1702504717~hmac=c238c1d01d796ed206154f80ad83891663b160f8db17a008f521e7e24491b41d';
}
