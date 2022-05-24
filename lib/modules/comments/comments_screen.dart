import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_post_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {



  CommentsScreen({required this.getPostModel});
  GetPostModel getPostModel;


  @override
  Widget build(BuildContext context) {

    var commentsController = TextEditingController();

    int counter = 0;


    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {

        log('Builder : ${counter++}');

        //CommentModel commentModel;
        var cubit = SocialCubit.get(context);
        //cubit.getPosts();
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Comments'
            ),
          ),
          body: ConditionalBuilder(
            condition: true,
            builder: (BuildContext context) { return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index)
                      {
                        return buildCommentsItem(getPostModel, context, index);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                      itemCount: getPostModel.comments!.length),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: TextFormField(
                            controller: commentsController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'write a comment ...',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).commentOnPost(comment: commentsController.text, postModel: getPostModel);
                            commentsController.clear();
                          },
                          minWidth: 1.0,
                          child: Icon(
                            IconBroken.Send,
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );},
            fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

          ),
        );
      },

    );
  }

  // var commenterId =
  Widget buildCommentsItem(GetPostModel postModel,BuildContext context, int index) {
    var model = SocialCubit.get(context).getCommentatorData(uId: postModel.comments![index].uId);
     // SocialUserModel model = SocialCubit.get(context).commentatorModel!;
    // var model = SocialCubit.get(context).userModel;
    var commentModel = postModel.comments![index];
    //var foundPlace = places.firstWhere((p) => p.id == widget.id);
    if(model == null){
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Column(
            children: [
              Text(
                '${model.name}',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
              Text(
                commentModel.comment,
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}















/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_post_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {



   CommentsScreen({required this.index}) ;
  int index;

  @override
  Widget build(BuildContext context) {
    var commentsController = TextEditingController();
    String? postId = SocialCubit.get(context).posts[index].postId;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        var cubit = SocialCubit.get(context);
        var getPostModel = cubit.posts[index];
        var model = cubit.userModel!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Comments'
            ),
          ),
          body: ConditionalBuilder(
            condition: true,
            builder: (BuildContext context) { return Column(
              children: [
                ListView.separated(
                    itemBuilder: (context,index)
                    {
                      var comments = SocialCubit.get(context).posts[index].comments! as CommentModel;
                      String? postId = SocialCubit.get(context).posts[index].postId;
                      return buildCommentsItem(model!,comments, context, postId);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15.0,
                    ),
                    itemCount: 0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: TextFormField(
                            controller: commentsController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'write a comment ...',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).commentOnPost(comment: commentsController.text, postModel: getPostModel!, postId: postId);
                          },
                          minWidth: 1.0,
                          child: Icon(
                            IconBroken.Send,
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );},
            fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

          ),
        );
      },

    );
  }

 // var commenterId =
  Widget buildCommentsItem(SocialUserModel model,CommentModel commentModel, context, String postId) {

    return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
            '${model.image}',
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            height: 1.4,
          ),
        ),
      ],
    ),
  );
  }

}
*/