import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/cubit/appcubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:social_app/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:social_app/modules/social_app/social_register/cubit/cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/bloc_observer.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/themes.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  showToast(text: 'on background message', state: ToastStates.SUCCESS,);
}


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS,);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
   DioHelper.init();
  Widget? widget;
  uId = CacheHelper.getData(key: 'uId') ?? '';
  print(uId);
  log(uId);
  log('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeey');

  if (uId != null)
    widget = SocialLayout();
  else
    widget = SocialLoginScreen();

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(isDark,widget));
    },
    blocObserver: MyBlocObserver(),
  );



}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget? startwidget;
  MyApp(this.isDark,
      this.startwidget,
  );

  // constructor
  // build

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeMode(fromCache: isDark,),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getUsers(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialRegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialLoginCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },

        builder: (BuildContext context, Object? state) =>MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
          home: uId.isEmpty
              ? SocialLoginScreen()
              :  SocialLayout(),
        ),

      ),
    );
  }
}