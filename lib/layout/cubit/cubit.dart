import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import '../../models/social_app/messege_model.dart';
import '../../models/social_app/social_user_model.dart';
import '../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  SocialPostModel? PostModel;
  GetPostModel? getPostModel;
  String uId = CacheHelper.getData(key: 'uId') ?? '';

  void getUserData() {

    log(uId);
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentindex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1)
      getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentindex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;

  var picker = ImagePicker();

////////profile image picker//////////
  Future getProfileImage() async {
    emit(SocialProfileImagePickedLoadingState());
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      log(profileImage!.path);
      emit(SocialProfileImagePickedSuccessState());
      log('Success');
      print(profileImage);
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if(coverImage != null)
  //   {
  //     uploadCoverImage();
  //   }else if (profileImage != null)
  //   {
  //     uploadProfileImage();
  //   }else if (coverImage != null && profileImage != null)
  //   {
  //
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  //
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    userModel = SocialUserModel(
      name: name,
      phone: phone,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
      bio: bio,
      isEmailVerified: userModel?.isEmailVerified,
      uId: userModel?.uId,
      email: userModel?.email,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(userModel!.toMap())
        .then((value) {
      // todo: remove me
      // emit(SocialGetUserSuccessState());
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel = SocialPostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      postId: null,
    );
    //Ignore Android studio it is used, Would you trust Android studio more than me??
    String postId = '';

    FirebaseFirestore.instance
        .collection('posts')
        .add(PostModel!.toMap())
        .then((value) {
      postId = value.id;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(value.id)
          .update({'postId': value.id});
      emit(SocialCreatePostSuccessState());
      log(text);
      log(userModel!.image.toString());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

/*value.docs.forEach((element) async{
        posts.add(PostModel = SocialPostModel.fromJson(await element.data()));*/
  List<GetPostModel> posts = [];


  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) async {
      for (int i = 0; i < value.docs.length; i++) {
        var postDoc = value.docs[i];

        // get likes
        await postDoc.reference
            .collection('likes')
            .where(
              'like',
              isEqualTo: true,
            )
            .get()
            .then((value) {
          posts.add(getPostModel = GetPostModel.fromJson(
            json: postDoc.data(),
            postId: postDoc.id,
            likes: value.docs.map((e) => e.id).toList(),
          ));
        });
        // comments
        await postDoc.reference
            .collection('comments')
            .orderBy('milSecEpoch', descending: false)
            .get()
            .then((commentValue) {
          posts[i].comments = [];

          for (var commentDoc in commentValue.docs) {
            posts[i].comments!.add(
              CommentModel(
                comment: commentDoc.data()['comment'],
                uId: commentDoc.data()['uId'],
                milSecEpoch: commentDoc.data()['milSecEpoch'],
              ),
            );
          }
        }).catchError((error) {
          log('error when get post comments: ${error.toString()}');
        });

      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void postLike({required int postIndex}) {
    String? postId = posts[postIndex].postId;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      //emit(SocialPostLikeSuccessState());
    }).catchError((error) {
      emit(SocialPostLikeErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    emit(SocialGetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime',descending: true)
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
    }



    void commentOnPost({
      required String comment,
      required GetPostModel postModel,
    }) async {
      var commentModel = CommentModel(
        comment: comment,
        uId: userModel!.uId!,
        milSecEpoch: DateTime.now().millisecondsSinceEpoch,
      );

      // upload comment in Firebase
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postModel.postId)
          .collection('comments')
          .doc()
          .set(commentModel.toMap())
          .then((_) {
        // add comment to post model
        postModel.comments!.add(commentModel);
        emit(SocialPostCommentSuccessState());
      }).catchError((error) {
        log('error when commentPost: ${error.toString()}');
        emit(SocialPostCommentErrorState(error.toString()));
      });
    }


    void Logout()
    {
      CacheHelper.removeData(key: 'uId');
      emit(SocialLogOutSuccessState());
    }

  // SocialUserModel? commentatorModel; // null

  // Future<SocialUserModel?> getCommentatorData({required String commentatorId}) async {
  //
  //
  //   emit(SocialGetCommentatorLoadingState());
  //   await FirebaseFirestore.instance.collection('users').doc(commentatorId).get().then((value) {
  //     commentatorModel = SocialUserModel.fromJson(value.data()!);
  //     // emit(SocialGetCommentatorSuccessState());
  //   }).catchError((error) {
  //     print(error);
  //     // emit(SocialGetCommentatorErrorState(error.toString()));
  //   });
  // }

  SocialUserModel? getCommentatorData({required String uId}) {
    if(uId == userModel!.uId)
      return userModel!;
    try{
      return users.firstWhere((user) => user.uId==uId);
    } catch (e){
      return null;
    }
  }



  }

  /*Future<bool> changedata(status,index) async {
    //your code
    postLike(postIndex: index);
    emit(SocialLikeButtonTapSuccessState());
    return Future.value(!status);

  }*/





/*  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }*/

// List likes = [];
//
// void getLikes(String postId)
// {
//   FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc().get().then((value)
//   {
//     likes.add(value.data());
//     emit(SocialGetPostLikeSuccessState());
//     print(value.data());
//     print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeheheheh');
//   }).catchError((error)
//   {
//     emit(SocialGetPostLikeErrorState(error.toString()));
//   });
// }



/*void likeButtonTap(bool isliked, int likecount)
{
  if (isliked == false)
    likecount++;
  else
    likecount--;

  emit(SocialLikeButtonTapSuccessState());
}*/


/*void postComment({required postId, required userId, required commentText})
    {
      FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(userId).set(commentText).then((value)
      {
        emit(SocialPostCommentSuccessState());
      }).catchError((error)
      {
        emit(SocialPostCommentErrorState(error));
      });
    }*/