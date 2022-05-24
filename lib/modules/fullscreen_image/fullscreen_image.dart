import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_app/layout/cubit/cubit.dart';

import '../../models/social_app/social_post_model.dart';

class FullScreenImage extends StatelessWidget {
  var postimage;
   FullScreenImage({Key? key,required this.postimage }) : super(key: key, );


  //GetPostModel getPostModel = SocialCubit.get(context).posts;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(postimage),
        enablePanAlways:true ,
      ),
    );
  }
}