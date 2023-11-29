import 'dart:convert';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:ez/models/popup/widgetpopup/attachfile.dart';
import 'package:ez/models/popup/widgetpopup/comments.dart';
import 'package:ez/models/popup/widgetpopup/connectItemfilelist.dart';
import 'package:ez/models/popup/widgetpopup/gridviewhome.dart';
import 'package:ez/models/popup/widgetpopup/historytask.dart';
import 'package:ez/models/popup/widgetpopup/tasktab.dart';
import 'package:ez/widgets/tabscanindex.dart';
import 'package:ez/widgets/tabscanupload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth_repo.dart';
import '../../utils/helper/aes_encryption.dart';
import '../comments.dart';
import 'controllers/attachfilecontroller.dart';
import 'controllers/popupfullpagecontroller.dart';
import 'controllers/tabmainscreencontroller.dart';

class TabMianScreen extends StatefulWidget {
  @override
  TabMianScreenState createState() => TabMianScreenState();
}

class TabMianScreenState extends State<TabMianScreen> with TickerProviderStateMixin {
  late TabController _controller;
  final controllerpopup = Get.put(PopupFullPageController());

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print('wwwwwwwwwwwwwwwwwwwwwww236');
    print(controllerpopup.sWorkFlowId);
    print(controllerpopup.sActivityId);

    _controller = Get.put(TabController(length: 5, vsync: this));
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      // print("Selected Index: " + _controller.index.toString());
    });

    setState(() {
      controllerpopup.iFilecount = 0;
      controllerpopup.iTaskCount = 0;
      controllerpopup.iMsgCount = 0;
    });

    getCommentsDetailsCount();
    getFileDetailsCount();
    getTasklIstCount();
  }

  double safeAreaHeight = 0;

  void getCommentsDetailsCount() async {
    final responses =
        await AuthRepo.getCommentsList(controllerpopup.sWorkFlowId, controllerpopup.sProcessId);
    List lComments = jsonDecode(AaaEncryption.decryptAESaaa(responses.toString())) as List;
    setState(() {
      controllerpopup.iMsgCount = lComments.length;
    });
  }

  void getFileDetailsCount() async {
    final responses =
        await AuthRepo.getFileList(controllerpopup.sWorkFlowId, controllerpopup.sProcessId);
    List lFiles = jsonDecode(AaaEncryption.decryptAESaaa(responses.toString())) as List;
    setState(() {
      controllerpopup.iFilecount = lFiles.length;
    });
  }

  void getTasklIstCount() async {
    String payloadenc = '{"filterBy":[]}';
    final responses = await AuthRepo.getTaskList(controllerpopup.sWorkFlowId,
        controllerpopup.sProcessId, jsonEncode(AaaEncryption.EncryptDatatest(payloadenc)));
    // String dec = AaaEncryption.decryptAESaaa(responses.toString());
    List lTask = jsonDecode(AaaEncryption.decryptAESaaa(responses.toString())) as List;

    setState(() {
      controllerpopup.iTaskCount = lTask.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // TODO: implement build
    // final controller = Get.put(AttcaheFileController());
    return ListView(
      //shrinkWrap: true,
      children: <Widget>[
        Container(
          color: Colors.white,
          child: TabBar(
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.blueGrey,
            isScrollable: false,
            controller: _controller,
            indicatorColor: Colors.purple,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                  icon: Badge(
                showBadge: false,
                badgeContent: Text('',
                    style: TextStyle(
                        //fontSize: 14,
                        fontSize: 10,
                        color: Colors.white, //#00bfd6
                        fontWeight: FontWeight.w500)),
                badgeStyle: BadgeStyle(
                  badgeColor: const Color(0xFF00bfd6),
                ),
                child: Icon(MdiIcons.listBoxOutline),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(controllerpopup.iFilecount.toString(),
                    style: TextStyle(
                        //fontSize: 14,
                        fontSize: 10,
                        color: Colors.white, //#00bfd6
                        fontWeight:
                            FontWeight.w500)), //Text(controllerpopup.iFilecount.toString()),
                showBadge: controllerpopup.iFilecount > 0,
                badgeStyle: BadgeStyle(
                  badgeColor: const Color(0xFF00bfd6),
                ),
                child: Icon(Icons.attachment),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(controllerpopup.iMsgCount.toString(),
                    style: TextStyle(
                        //fontSize: 14,
                        fontSize: 10,
                        color: Colors.white, //#00bfd6
                        fontWeight: FontWeight.w500)),
                showBadge: controllerpopup.iMsgCount > 0,
                badgeStyle: BadgeStyle(
                  badgeColor: const Color(0xFF00bfd6),
                ),
                child: Icon(MdiIcons.commentOutline),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(controllerpopup.iTaskCount.toString(),
                    style: TextStyle(
                        //fontSize: 14,
                        fontSize: 10,
                        color: Colors.white, //#00bfd6
                        fontWeight: FontWeight.w500)),
                showBadge: controllerpopup.iTaskCount > 0,
                badgeStyle: BadgeStyle(
                  badgeColor: const Color(0xFF00bfd6),
                ),
                child: Icon(MdiIcons.cubeOutline),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text('',
                    style: TextStyle(
                        //fontSize: 14,
                        fontSize: 10,
                        color: Colors.white, //#00bfd6
                        fontWeight: FontWeight.w500)),
                showBadge: false,
                badgeStyle: BadgeStyle(
                  badgeColor: const Color(0xFF00bfd6),
                ),
                child: Icon(MdiIcons.history),
              )),
            ], // 9443451033
            onTap: (index) {
              debugPrint('ssssssssss ' + index.toString());
            },
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
          //height: safeAreaHeight == 716 ? 330 : 380, //351
          height: mediaQuery.size.height * .66,

          child: new TabBarView(
            controller: _controller,
            children: <Widget>[
              Container(child: GridViewHome()),
              Container(color: Colors.redAccent, child: AttachFiles()),
              Container(color: Colors.white, child: CommenttList()),
              Container(color: Colors.redAccent, child: TaskTab()),
              Container(color: Colors.white, child: HistoryTask()),

              /*             Container(),
              Container(),
              Container(),*/
            ],
          ),
        )
      ],
    );
  }
}
