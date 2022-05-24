import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/users/user_profile.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/social_app/social_user_model.dart';
import '../../shared/components/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
    onTap: () {
      navigateTo(context, UserProfile(userModel: model,));
    },
    child: Padding(
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
    ),
  );
}