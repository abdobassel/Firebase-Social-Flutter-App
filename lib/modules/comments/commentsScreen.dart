import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_firebase_course/blocSocial/socialCubit.dart';
import 'package:social_firebase_course/blocSocial/socialStates.dart';
import 'package:social_firebase_course/components.dart';
import 'package:social_firebase_course/models/coment_model.dart';
import 'package:social_firebase_course/models/post_model.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, required this.postModel});
  var commentController = TextEditingController();
  final PostModel postModel;
  CommentModel? commentModel;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getComments(SocialCubit.get(context).postid);

      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: DefaultAppBarSocial(
                context: context,
                title: 'Comments',
              ),
              body: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      SocialCubit.get(context).commentsModels.length > 0,
                  widgetBuilder: (context) => Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: SocialCubit.get(context)
                                          .commentsModels
                                          .length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          CommentsItemBuilder(),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: commentController,
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2)),
                                            hintText: 'Write a Comment',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith()),
                                        onFieldSubmitted: (
                                          data,
                                        ) {
                                          var now = DateTime.now().toString();

                                          data = commentController.text;
                                          SocialCubit.get(context)
                                              .createComment(
                                                  postId:
                                                      SocialCubit.get(context)
                                                          .postid,
                                                  textComment: data,
                                                  commentDate: now);
                                          commentController.clear();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  fallbackBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      )),
            );
          });
    });
  }
}

class CommentsItemBuilder extends StatelessWidget {
  CommentsItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('vvvvvvv'),
    );
  }
}
