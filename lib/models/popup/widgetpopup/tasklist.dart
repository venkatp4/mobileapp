import 'dart:convert';

import 'package:ez/models/popup/widgetpopup/tasktile.dart';
import 'package:ez/widgets/singleitemtaskcompleted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/auth_repo.dart';
import '../../../utils/helper/aes_encryption.dart';

class TaskList extends StatelessWidget {
  TaskList(
      {Key? key,
      this.isRounded = true,
      required this.cMenu,
      required this.iPosition})
      : super(key: key);

  final bool isRounded;
  final cMenu;
  final iPosition; //29 38

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //getTaskList();
    return Container(
        //height: double.infinity,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        //padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 7,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(2),
                  child: Text(
                    cMenu['Foldername'] + 'sdrr',
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        fontSize: 15),
                  ),
                  //               SizedBox(height: 10),
                )),
          ]),
          /*        Divider(
            color: Colors.black12,
            thickness: 1,
          ),*/
          TaskTile(cMenu['details']),
        ]));
  }
}
