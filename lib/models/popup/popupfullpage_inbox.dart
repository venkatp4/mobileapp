import 'dart:math';

import 'package:ez/models/popup/tabmainscreen.dart';
import 'package:ez/models/popup/textnormal.dart';
import 'package:ez/models/popup/textsmalll.dart';
import 'package:ez/models/popup/widgetpopup/buttonwithicon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'controllers/popupfullpagecontroller.dart';

class PopupFullpageInbox extends ModalRoute<int> {
  //controllerpopup = TaskMainController();
  final controllerpopup = Get.put(PopupFullPageController());
  //final controller = Get.put(AttcaheFileController());
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return _buildOverlayContent(context);
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(1, 1, 1, 50),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 15,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      width: double.infinity,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DefaultTextStyle(
                                maxLines: 3,
                                style:
                                    TextStyle(decoration: TextDecoration.none),
                                child: TextNormalPop(
                                    sLabel: controllerpopup.InboxDataNew[
                                            PopupFullPageController
                                                .iSelectedIndex]['requesno']
                                        .toString()
                                        .toString())),
                            DefaultTextStyle(
                                maxLines: 3,
                                style:
                                    TextStyle(decoration: TextDecoration.none),
                                child: TextNormalPop(
                                    sLabel: controllerpopup.InboxDataNew[
                                            PopupFullPageController
                                                .iSelectedIndex]['requesno']
                                        .toString()
                                        .toString())),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: <Widget>[
                              Icon(
                                MdiIcons.clockOutline,
                                color: Colors.purple.shade400,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              DefaultTextStyle(
                                  maxLines: 2,
                                  style: TextStyle(
                                      decoration: TextDecoration.none),
                                  child: TextSmallPop(
                                      sLabel: controllerpopup.InboxDataNew[
                                              PopupFullPageController
                                                  .iSelectedIndex]['raisedat']
                                          .toString()
                                          .toString()))
                            ]),
                          ])
                      // color: Colors.blue, /*child: TextNormal(sLabel: 'dsd')*/
                      )),
              Expanded(
                  flex: 80,
                  child: Material(
                      child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
                    /*margin: EdgeInsets.fromLTRB(10, 0, 10, 0),*/
                    child: TabMianScreen(),
                  ))),
              Expanded(
                  flex: 4,
                  child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: DefaultTextStyle(
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      child: Text(
                                        'Reminders',
                                        maxLines: 2,
                                      )))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  color: Colors.grey.shade100,
                                  padding: EdgeInsets.all(1),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                        child: Text(
                                            new Random().nextInt(7).toString() +
                                                ' Days Ago'),
                                        maxLines: 2,
                                      )))),
                        ],
                      ))),
              Divider(color: Colors.grey, height: 1),
              /*Expanded(
                  flex: 14,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 2),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Center(
                              child: Wrap(
                            children: <Widget>[
                              buttonGenerate(
                                  'Initate ',
                                  Colors.green,
                                  Icon(
                                    MdiIcons.arrowRight,
                                    color: Colors.green,
                                  )),
                              buttonGenerate(
                                  'Submit',
                                  Colors.deepOrangeAccent,
                                  Icon(
                                    MdiIcons.gestureTap,
                                    color: Colors.deepOrangeAccent,
                                  )),
                              buttonGenerate(
                                  'Forward',
                                  Colors.orange,
                                  Icon(
                                    MdiIcons.share,
                                    color: Colors.orange,
                                  )),
                              buttonGenerate(
                                  'Complete',
                                  Colors.purple,
                                  Icon(
                                    MdiIcons.check,
                                    color: Colors.purple,
                                  )),
                              buttonGenerate(
                                  'Close',
                                  Colors.red,
                                  Icon(
                                    MdiIcons.close,
                                    color: Colors.red,
                                  )),
                            ],
                          )))))*/
            ],
          ),
        ));
  }

  buttonGenerate(String sname, Color clr, Icon icn) {
    return Container(
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: clr),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side: BorderSide(width: 2, color: clr)),
          ),
          onPressed: () => {},
          icon: icn,
          label: Text(
            sname,
            style: TextStyle(color: clr),
          ),
        ));
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
