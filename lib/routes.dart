import 'package:ez/models/popup/form/formmain.dart';
import 'package:ez/pages/Taskcreen.dart';
import 'package:ez/pages/foldermainscreen.dart';
import 'package:ez/pages/forgotpassword.dart';
import 'package:ez/pages/loading.dart';
import 'package:ez/pages/login.dart';
import 'package:ez/pages/lost_connection.dart';
import 'package:ez/pages/otpMainPage.dart';

import 'package:ez/pages/signup.dart';
import 'package:ez/pages/dashmainscreen.dart';
import 'package:ez/pages/taskmainscreen.dart';
import 'package:ez/pages/tastscreenmain.dart';
import 'package:ez/pages/webmainscreen.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'models/popup/widgetpopup/popupfullpage_inboxpege.dart';

class AppRoutes {
  //AppRoutes._();

  static final routes = [
    GetPage(name: '/', page: () => Loading()),
    GetPage(name: '/noConnection', page: () => LostConnection()),
    GetPage(
        name: '/loginscreen',
        page: () => LoginPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/forgotpassword',
        page: () => ForgotPasswordPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/signup',
        page: () => SignUpPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/home',
        page: () => DashMainScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/task',
        page: () => TaskScreenMain(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/folder',
        page: () => FolderMainScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/tasks',
        page: () => TaskMainScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/web',
        page: () => WebMainScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/otpscreen',
        page: () => OtpMianPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/inboxpage',
        page: () => PopupFullpageInboxPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/formview',
        page: () => FormMain(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
  ];
}
