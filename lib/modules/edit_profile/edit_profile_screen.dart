import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;

    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var bioController = TextEditingController();

    nameController.text = userModel!.name!;
    bioController.text = userModel.bio!;
    phoneController.text = userModel.phone!;



    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: defaultAppBar(
                context: context,
                title: 'Edit Profile',
                actions: [
                  defaultTextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    text: 'Update',
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 210.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: const Radius.circular(4.0),
                                    topRight: const Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: const Icon(
                                    IconBroken.Camera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                profileImage == null
                                    ? NetworkImage(userModel.image!)
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: const Icon(
                                  IconBroken.Camera,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    },
                                    text: 'Upload profile '),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    onPressed: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    text: 'Upload cover '),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    Label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                    Label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                    Label: 'phone',
                    prefix: IconBroken.Call,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
