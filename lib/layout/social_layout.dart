import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen());
          }
          },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentindex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
