import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/dashmaincontroller.dart';

import '../layouts/search/SearchLayout.dart';
import '../layouts/search/controller/searchlayout_controller.dart';
import '../utils/helper/safe_area.dart';
import '../widgets/TreInboxListview.dart';

import '../widgets/inboxtext.dart';
import '../widgets/listviewsearchable.dart';
import '../widgets/testinbox.dart';

class DashMainScreen extends StatefulWidget {
  @override
  _DashMainScreenState createState() => _DashMainScreenState();
}

class _DashMainScreenState extends State<DashMainScreen> {
  DashMainController dbcontroller = new DashMainController();
  final controller = Get.put(SearchlayoutController());
  // RxString iCurrentSelect = 'dashboard'.obs;
  double safeAreaHeight = 0;

  @override
  void initState() {
    super.initState();
    dbcontroller.justPrint();
  }

  Future<bool> _onWillPop() async {
    if (dbcontroller.iCurrentSelect != 'dashboard') {
      setState(() {
        dbcontroller.iCurrentSelect = 'dashboard'.obs;
      });
      return Future.value(null);
    }

    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  checkDrawerOpens(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      debugPrint('toggle controller opn');
      Scaffold.of(context).closeDrawer();
    } else {
      debugPrint('toggle controller else');
    }
  }

  @override
  Widget build(BuildContext context) {
    dbcontroller.justPrint();
    final safeArea = calcSafeArea();
    safeAreaHeight = safeArea['height']!;
    // TODO: implement build
    //return SearchLayout(children: [const SizedBox(height: 400)]);
    return WillPopScope(
        onWillPop: _onWillPop, //_onWillPop(context),
        child: SearchLayout(wpersistentFooterButtons: List.empty(), children: [
          Expanded(
              child: Container(
                  child: Column(mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                dbcontroller.iCurrentSelect == 'dashboard'
                    ? Center(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            width: 320,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: IntrinsicHeight(
                                child: Row(
                              children: [
                                //
                                GestureDetector(
                                    onTap: inboxfn,
                                    child: ImageMultitext(
                                        //27 11.50
                                        title: 'My Inbox',
                                        subtext: '25 New',
                                        iIcon: Icon(
                                          Icons.mail_outline_outlined,
                                          color: Colors.indigoAccent,
                                        ))),
                                VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1,
                                    indent: 7),
                                GestureDetector(
                                    onTap: taskfn,
                                    child: ImageMultitext(
                                        title: 'My Task',
                                        subtext: '30 Pending',
                                        iIcon: Icon(
                                          MdiIcons.cubeOutline,
                                          color: Colors.indigoAccent,
                                        )))
                              ],
                            ))))
                    : Container(),
                dbcontroller.iCurrentSelect == 'inboxfn'
                    ? Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListViewSearch()))
                    : Container(),
                dbcontroller.iCurrentSelect == 'taskfn'
                    ? Expanded(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TreeInboxListview())) /*TestInbox()*/
                    /*Container(
              child: InboxExpandableTree(
              title: 'dddd',
            ))*/
                    : Container()
              ])))
        ]));
  }

  void inboxfn() {
    debugPrint('inboxfn');
    setState(() {
      dbcontroller.iCurrentSelect = 'inboxfn'.obs;
    });
  }

  void taskfn() {
    debugPrint('taskfn');

    setState(() {
      dbcontroller.iCurrentSelect = 'taskfn'.obs;
    });
  }

  void backfn() {
    debugPrint('dashboard');

    setState(() {
      dbcontroller.iCurrentSelect = 'dashboard'.obs;
    });
  }
}
