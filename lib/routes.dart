import 'package:ez/features/workflow/view/workflow.dart';
import 'package:ez/features/workflow/view/workflowdetailscreen.dart';
import 'package:ez/models/popup/form/formmain.dart';
import 'package:ez/pages/Taskcreen.dart';
import 'package:ez/pages/foldermainscreen.dart';
import 'package:ez/pages/forgotpassword.dart';
import 'package:ez/pages/formmain_initiate.dart';
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
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'core/components/bottom_menu/categories_screen.dart';
import 'core/components/bottom_menu/explore_screen.dart';
import 'core/components/bottom_menu/reading_list.dart';
import 'models/popup/widgetpopup/popupfullpage_inboxpege.dart';

class AppRoutes {
  AppRoutes._();

  static const workflow = "workflow";
  static const categories = "categories";
  static const videos = "videos";
  static const reading = "Reading List";
  static const workflowdetail = "workflowdetails";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case AppRoutes.videos:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
      case AppRoutes.categories:
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      case AppRoutes.reading:
        return MaterialPageRoute(builder: (_) => ReadListScreen());
      case AppRoutes.workflow:
        return MaterialPageRoute(
            settings: settings, builder: (_) => Workflow());
      case AppRoutes.workflowdetail:
        return MaterialPageRoute(builder: (_) => WorkflowDetails());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("error"),
        ),
        body: const Center(
          child: Text("error"),
        ),
      );
    });
  }

  static initialRouteForIndex(int index) {
    switch (index) {
      case 0:
        return AppRoutes.workflow;
      case 1:
        return AppRoutes.categories;
      case 2:
        return AppRoutes.videos;
      case 3:
        return AppRoutes.reading;
    }
  }

  static push(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  static changeRoot(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

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
        name: '/workflowinbox',
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
    GetPage(
        name: '/formviewinitiate',
        page: () => FormMainInitiate(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
  ];
}
