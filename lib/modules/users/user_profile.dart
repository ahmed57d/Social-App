import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/social_app/social_user_model.dart';
import '../../shared/styles/icon_broken.dart';

class UserProfile extends StatelessWidget {
  SocialUserModel? userModel;
   UserProfile({required this.userModel}) ;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        //var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 210.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 160.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${userModel?.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            '${userModel?.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${userModel?.name}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${userModel?.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '165',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '99',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child: Text('Add Photos'),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: ()
                      {},
                      child: Icon(
                        IconBroken.Edit,
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
