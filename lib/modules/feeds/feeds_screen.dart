import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_post_model.dart';
import 'package:social_app/modules/comments/comments_screen.dart';
import 'package:social_app/modules/fullscreen_image/fullscreen_image.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../cubit/appcubit.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/showing-tablet-s-blank-screen_155003-21288.jpg?t=st=1651991372~exp=1651991972~hmac=ec636217ccbb8afadcfcbd5325d01b990a644805ef3893225f7011c0bcfa4a10&w=1380'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index], context,index),
                  itemCount: SocialCubit.get(context).posts.length, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator.adaptive()),
        );
      },

    );
  }


  Widget buildPostItem(GetPostModel getPostModel,context, int index,) {
    var userModel = SocialCubit.get(context).userModel!;
    //var postModel = SocialCubit.get(context).posts[index];
   // bool isLiked = getPostModel.likes.contains(userModel.uId);
    var comment = getPostModel.comments?.length ?? 0;




    return Card(

      color: AppCubit.get(context).isDark ? Colors.white : HexColor('393a3b'),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(getPostModel.image!),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${getPostModel.name}',
                            style: TextStyle(
                              height: 1.3,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        '${getPostModel.dateTime}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              height: 1.3,
                            ),
                      ),
                    ],
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${getPostModel.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 5.0,
                ),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 5.0,
                        ),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(
                            onPressed: () {},
                            height: 30.0,
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 5.0,
                        ),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(
                            onPressed: () {},
                            height: 30.0,
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 5.0,
                        ),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(
                            onPressed: () {},
                            height: 30.0,
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(getPostModel.postImage != "")
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage(getPostModel.postImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(postimage: getPostModel.postImage!,),
                        ));
                  },
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 20.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(

                              'Likes'

                              //style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 20.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(

                              comment.toString(),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: ()
                      {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(SocialCubit.get(context).userModel!.image!),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'write a comment',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      height: 1.3,
                                    ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      onTap: ()
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(getPostModel: getPostModel,),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        LikeButton(
                          size: 20.0,
                          likeCount: getPostModel.likes.length,
                          isLiked: getPostModel.likes.contains(userModel.uId),
                          onTap: (isLiked)
                          async{
                            SocialCubit.get(context).postLike(postIndex: index);
                            return !isLiked;
                          },
                          //likeCount: SocialCubit.get(context).posts[index].likes.length,
                             //SocialCubit.get(context).postLike(postIndex: index);
                        ),
                        /*Icon(
                          getPostModel.likes.contains(userModel.uId)
                          ?Icons.favorite
                          :IconBroken.Heart,
                          size: 20.0,
                          color: Colors.red,
                        ),*/
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
