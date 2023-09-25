import 'dart:convert';
import 'dart:math';

import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/auth_repo.dart';
import '../../../utils/file_fns.dart';
import '../../../utils/format_date_time.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../controllers/attachfilecontroller.dart';
//import '../utils/format_date_time.dart';

class AttachFiles extends StatefulWidget {
  @override //
  _AttachFilesState createState() => _AttachFilesState();
}

class _AttachFilesState extends State<AttachFiles> {
  final controller = Get.put(AttcaheFileController());
  int iSelectedFileCount = 0;

  @override
  void initState() {
    print('Attatched File fffffffffffffffffff');
    super.initState();
    getFileDetails();
    //controller.
  }

  void getFileDetails() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    print('1ccccccccccccccccccccccccccc');
    final responses = await AuthRepo.getFileList('7', '1082');
    print('2ccccccccccccccccccccccccccc');
    String dec = AaaEncryption.decryptAESaaa(responses.toString());
    print('31ccccccccccccccccccccccccccc');
    print(dec);
    print('31wwwwccccccccccccccccccccccccccc');
    print(pre.getString('username'));
    var tagObjsJson = jsonDecode(dec) as List;
    //var tagObjsJson = jsonDecode(dec) as List;
    List<filedatas> tagObjs =
        tagObjsJson.map((tagJson) => filedatas.fromJson(tagJson)).toList();
    setState(() {
      controller.dataFileListNew = tagObjs;
    });
    debugPrint('678ccccccccccccccccccccccccccc');
  }

  @override
  Widget build(BuildContext context) {
    var sTextdatadesc = sReturnStatus();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
            itemCount: controller.dataFileListNew.length,
            itemBuilder: (context, index) {
              filedatas item = controller.dataFileListNew.elementAt(index);
              return ListTile(
                  title: GestureDetector(
                      onTap: () {
                        setState(() {
                          item.selected = !item.selected;
                          if (item.selected)
                            controller.dataFileListNew[index] = item;

                          controller.iSelecteFileCount = controller
                              .getSelectedFileCount(controller.dataFileListNew);
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          //list[index].isSelected = true;
                          controller.iSelecteFileCount = 0;
                          item.selected = true;
                          controller.iSelecteFileCount = controller
                              .getSelectedFileCount(controller.dataFileListNew);
                        });
                      },
                      /*fnLongPress(item.selected, index)*/
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: !item.selected
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)))
                              : BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                          child: Column(children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.all(2),
                                        child: Image.asset(
                                          fileIcon(item.name),
                                          height: 20,
                                          width: 20,
                                          /*  color:
                                              sTextdatadesc.contains('MODIFIED')
                                                  ? Colors.blueAccent
                                                  : Colors.red,*/
                                        ))),
                                Expanded(
                                    flex: 65,
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // name
                                            Text(item.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            // ...
                                            SizedBox(height: 2),
                                            // email
                                            Text(item.description,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                            RichText(
                                              text: TextSpan(
                                                text: item.createdByEmail + ' ',
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: item.Status,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: sReturnColor(
                                                              item.Status))),
                                                ],
                                              ),
                                            ),
                                            // ...
                                          ],
                                        ))),
                                Expanded(
                                    flex: 15,
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: Text(
                                            textAlign: TextAlign.end,
                                            timeFormate(item.createdAt.trim()),

                                            /*   timeFormate(
                                                _inboxDetailss[index]
                                                    .raisedat
                                                    .trim())*/
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300))))
                              ],
                            ),
                            /* Row(children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        fileIcon(item.name),
                                        height: 24,
                                        width: 24,
                                        color:
                                            sTextdatadesc.contains('MODIFIED')
                                                ? Colors.blueAccent
                                                : Colors.red,
                                      ))),
                              Expanded(
                                  flex: 9,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 5, 5),
                                              child: Text(
                                                item.name,
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black87,
                                                    fontSize: 18),
                                              )),
                                          //               SizedBox(height: 10),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 5, 5),
                                              child: RichText(
                                                maxLines: 3,
                                                text: TextSpan(
                                                  text: sReturnVal(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: sTextdatadesc,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: sReturnColor(
                                                                sTextdatadesc))),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ))),
                            ]),*/
                          ]))));
            },
          ),
          floatingActionButton: Wrap(
            //will break to another line on overflow
            direction: Axis.vertical, //use vertical to show  on vertical axis
            children: <Widget>[
              controller.iSelecteFileCount > 0
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.blueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0))),
                        child: Icon(color: Colors.white, Icons.delete_outline),
                        onPressed: () => {},
                      ))
                  : SizedBox(), //button first

              controller.iSelecteFileCount > 1
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.blueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0))),
                        child: Icon(color: Colors.white, Icons.merge),
                        onPressed: () => {},
                      ))
                  : SizedBox(), // button second

              controller.iSelecteFileCount == 0
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.blueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0))),
                        child: Icon(
                            color: Colors.white, Icons.file_upload_outlined),
                        onPressed: () => {},
                      ))
                  : SizedBox(), // button third

              // Add more buttons here
            ],
          ),
        ));
  }

  String sReturnVal() {
    var arr = [
/*      "Inversments1 \u2022 DATE:12-Apr-2023 \u2022 sangilimurugan.nezofis.com \u2022 ",
      "Inversments2 \u2022 DATE:02-Jun-2023  \u2022 raja@ezofis.com \u2022 ",
      "Inversments3 \u2022 DATE:23-May-2023  \u2022 arun.ezofis.com \u2022 "*/
    ];
    return arr[randomgrn()];
  }

  int randomgrn() {
    Random r = new Random();
    return r.nextInt(3);
  }

  String sReturnStatus() {
    var arrStatus = ["UPLOADED", "MODIFIED", "ESIGN_REQUIRED"];
    return arrStatus[randomgrn()];
  }

  Color sReturnColor(String sStutus) {
    switch (sStutus) {
      case 'UPLOADED':
        return Colors.grey;
      case 'MODIFIED':
        return Colors.green;
      case 'ESIGN_REQUIRED':
        return Colors.deepOrangeAccent;
    }
    return Colors.grey;
  }

  String fileIcon(String fileName) {
    final fileType = fileName.split('.').last.toLowerCase();
    final validTypes = validFileTypes();

    if (validTypes.contains(fileType)) {
      return '$path/$fileType.png';
    } else {
      return '$path/file.png';
    }
  }

  String formatFileSize(int size) {
    return filesize(size);
  }
}
