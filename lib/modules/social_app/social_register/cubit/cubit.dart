import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/social_app/social_register/cubit/states.dart';

import '../../../../shared/network/local/cache_helper.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {

    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,

      );
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image: 'https://img.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg?t=st=1652033158~exp=1652033758~hmac=d933cc25c4baffc9ffeb56204a641591bc0c25ba49e87746f9862154cf1190b9&w=826',
      cover: 'https://img.freepik.com/free-photo/scatter-topographic-landscape-based-colorful-cubes-abstract-background-with-depth-field_173207-1640.jpg?w=1480',
      bio: 'Write about yourself ...'
    );
   /* // save uid in cache
    CacheHelper.setSocialUId(uId);

    // save uid in global var
    uId = uId;
    SocialCubit.get(context).userModel = SocialUserModel.fromJson(userModel.toMap());

    // save user model in cache
    CacheHelper.setUserModel(userModel.toMap());*/

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}