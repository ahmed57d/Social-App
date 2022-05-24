import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialUserModel model = SocialCubit.get(context).userModel!;
        var textController = TextEditingController();
        final now = DateTime.now();
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: defaultAppBar(
                context: context,
                title: 'Create Post',
                actions: [
                  defaultTextButton(
                    onPressed: () {
                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      } else {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      }
                    },
                    text: 'Post',
                  )
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                     CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        model.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                     Expanded(
                        child:  Text(
                          model.name!,
                      style: TextStyle(
                        height: 1.3,
                      ),
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        child: const Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '#tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
