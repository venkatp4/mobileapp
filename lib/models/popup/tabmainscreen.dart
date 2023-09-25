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

import 'controllers/attachfilecontroller.dart';
import 'controllers/tabmainscreencontroller.dart';

class TabMianScreen extends StatefulWidget {
  @override
  TabMianScreenState createState() => TabMianScreenState();
}

class TabMianScreenState extends State<TabMianScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  double safeAreaHeight = 0;
  int iffFilecount = 0;

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
            /*       indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
              //borderRadius: BorderRadius.circular(),
              color: Colors.black12,
            ),*/
            tabs: [
              Tab(
                  icon: Badge(
                badgeContent: Text(''),
                badgeStyle: BadgeStyle(
                  badgeColor: Colors.white,
                ),
                child: Icon(MdiIcons.listBoxOutline),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(''),
                badgeStyle: BadgeStyle(
                  badgeColor: Colors.cyanAccent,
                ),
                child: Icon(Icons.attachment),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(''),
                showBadge: false,
                badgeStyle: BadgeStyle(
                  badgeColor: Colors.cyanAccent,
                ),
                child: Icon(MdiIcons.commentOutline),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(''),
                badgeStyle: BadgeStyle(
                  badgeColor: Colors.cyanAccent,
                ),
                child: Icon(MdiIcons.cubeOutline),
              )),
              Tab(
                  icon: Badge(
                badgeContent: Text(''),
                showBadge: false,
                badgeStyle: BadgeStyle(
                  badgeColor: Colors.cyanAccent,
                ),
                child: Icon(MdiIcons.history),
              )),
            ],
            onTap: (index) {
              debugPrint('ssssssssss ' + index.toString());
            },
          ),
        ),
        /*Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0), topLeft: Radius.circular(5.0)),
            //borderRadius: BorderRadius.circular(),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          //color: Colors.yellow,
                          margin: EdgeInsets.fromLTRB(1, 12, 1, 12),
                          child: Text(
                            controller.tabitems[_selectedIndex],
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 2,
                          )),
                      _selectedIndex != 0
                          ? Container(
                              margin: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                '(' + new Random().nextInt(5).toString() + ')',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ))
                          : Container(),
                    ],
                  ))),
              Expanded(
                  flex: 1,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          _selectedIndex != 0
                              ? IconButton(
                                  icon: Icon(
                                    MdiIcons.openInNew,
                                    color: Colors.teal,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {},
                                    );
                                  },
                                )
                              : SizedBox(),
                          _selectedIndex == 1
                              ? IconButton(
                                  icon: Icon(
                                    MdiIcons.vectorCombine,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {},
                                    );
                                  },
                                )
                              : SizedBox(),
                          _selectedIndex == 2
                              ? IconButton(
                                  icon: Icon(
                                    MdiIcons.reload,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {},
                                    );
                                  },
                                )
                              : SizedBox(),
                          controller.iSelecteFileCount > 0 &&
                                  _selectedIndex != 0
                              ? Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: IconButton(
                                    icon: Icon(
                                      MdiIcons.trashCanOutline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {},
                                      );
                                    },
                                  ))
                              : SizedBox(),
                        ],
                      )))
            ],
          ),
        ),*/
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
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
        ),
      ],
    );
  }
}
