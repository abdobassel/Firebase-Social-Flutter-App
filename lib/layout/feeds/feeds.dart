import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/models/createuser.dart';
import 'package:social_firebase_course/models/post_model.dart';
import 'package:social_firebase_course/modules/comments/commentsScreen.dart';

class FeedsScrenn extends StatelessWidget {
  FeedsScrenn({super.key});
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Conditional.single(
              context: context,
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator()),
              conditionBuilder: (context) =>
                  SocialCubit.get(context).posts.isNotEmpty,
              widgetBuilder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 10.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Image(
                          image: NetworkImage(imgLink),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        )
                      ]),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BuildPostItem(
                            context,
                            SocialCubit.get(context).model!,
                            SocialCubit.get(context).posts[index],
                            index);
                      },
                      itemCount: SocialCubit.get(context).posts.length,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget BuildPostItem(context, UserModel model, PostModel postModel, index) =>
      Card(
        color: Colors.white,
        margin: EdgeInsets.all(8.0),
        elevation: 10.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${postModel.name}',
                              style: TextStyle(height: 1.3),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                        Text(
                          '${postModel.datePost}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 25,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 2,
                color: Colors.grey[350],
                width: double.infinity,
              ),
            ),
            if (postModel.txt != '')
              Text(
                '${postModel.txt}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            /*  
             // tags 
              Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Container(
                width: double.infinity,
                child: Wrap(children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                        height: 20.0,
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Text(
                          '#dddddddd',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),*/

            if (postModel.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage('${postModel.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_outline,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .getComments(SocialCubit.get(context).postId[index]);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CommentsScreen(
                          postModel: postModel,
                        );
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add_comment_outlined,
                            size: 16,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).commentsNum[index]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 2,
              color: Colors.grey[350],
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            onFieldSubmitted: (data) {
                              var now = DateTime.now().toString();
                              data = commentController.text;
                              SocialCubit.get(context).createComment(
                                  postId:
                                      SocialCubit.get(context).postId[index],
                                  textComment: data,
                                  commentDate: now);
                              commentController.clear();
                            },
                            // maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write a Comment...',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[250],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePosts(SocialCubit.get(context).postId[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  String img1 =
      'https://img.freepik.com/free-photo/triumphing-happy-guy-raises-clenched-fist-celebrates-winning-lottery-gets-message-confirming-holds-mobile-phone-browses-social-media-wears-yellow-hat-striped-jumper-always-stays-touch_273609-31312.jpg?w=996&t=st=1702504239~exp=1702504839~hmac=6874839c6adb6eb8ebd6bc4a9557968c850b02bc901934e7826e97b46251bb66';
  String imglink2 =
      'https://img.freepik.com/premium-photo/field-hockey-players-during-tournament-game_23-2149668592.jpg?w=1060';
  String imgLink =
      'https://img.freepik.com/free-photo/sale-fashion-discounts-online-shopping-concept-overjoyed-dark-skinned-woman-chooses-clothes-clothing-store-rejoices-big-sales-holds-mobile_273609-32763.jpg?w=996&t=st=1702504153~exp=1702504753~hmac=f67edea3266dbac5673a758245d77f367a93a1ac231fa6caa9dcce3a93b66bf0';
  String img3 =
      'https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?w=996&t=st=1702504117~exp=1702504717~hmac=c238c1d01d796ed206154f80ad83891663b160f8db17a008f521e7e24491b41d';
}
// الدقيقة 45ud