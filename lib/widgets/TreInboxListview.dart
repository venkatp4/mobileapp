import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/dashmaincontroller.dart';
import '../models/MenuInbox.dart';
import 'SubCategory.dart';
import 'listviewsearchable.dart';

class TreeInboxListview extends StatefulWidget {
  @override
  State<TreeInboxListview> createState() => _TreeInboxListviewState();
}

class _TreeInboxListviewState extends State<TreeInboxListview> {
  List<MenuInbox> data = [];
  var isExpanded = false;
  final controller = Get.put(DashMainController());

  @override
  void initState() {
    debugPrint('callllllled _TreeInboxListviewState');
    dataList.forEach((element) {
      data.add(MenuInbox.fromJson(element));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => _buildList(data[index]),
      //separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  Widget _buildList(MenuInbox list) {
    if (list.subMenu.isEmpty)
      return Builder(builder: (context) {
        return Container(
            // mobile
            color: Colors.purple,
            margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
            child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 5),
                child: ListTileTheme(
                    contentPadding: const EdgeInsets.all(15),
                    tileColor: Colors.white,
                    style: ListTileStyle.list,
                    dense: true,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          debugPrint(list.name + ' dddddd ' + list.id);
                          debugPrint('dddddddd123  ' +
                              controller.iCurrentSelect.value);
                          controller.iCurrentSelect = 'inboxfn'.obs;
                        });
                      },
                      contentPadding: EdgeInsets.only(left: 20.0, right: 0.0),
                      title: Row(
                        children: [
                          list.name.contains('(0)')
                              ? Text(list.name,
                                  style: TextStyle(color: Colors.blue))
                              : Text(list.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                        ],
                      ),
                    ))));
      });

    if (controller.iCurrentSelect == 'inboxfn') {
      return Expanded(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListViewSearch()));
    }

    return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(0),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          leading: Container(
            color: Colors.pink,
            width: 4,
            height: double.infinity,
          ),
          title: Transform(
              transform: Matrix4.translationValues(-30, 0.0, 0.0),
              child: Text(
                list.name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              )),
          onExpansionChanged: (bool expanded) {
            setState(() => isExpanded = expanded);
          },
          children: list.subMenu.map(_buildList).toList(),
        ));
  }
}
