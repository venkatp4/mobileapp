import 'dart:convert';

import 'package:ez/models/popup/controllers/popupfullpagecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../api/auth_repo.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../../comments.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommentController extends GetxController {
  final controllerpopup = Get.put(PopupFullPageController());
  int iSelecteFileCount = 0;

  String sMessage = '';

  /*List dataMessageList = <commentsdatas>[
    new commentsdatas("Message first", true),
    new commentsdatas("Message second", false),
    new commentsdatas("Message second1 \n Message secondr", false),
    new commentsdatas(
        "RoundedRectangleBorder.side property does not work with ElevatedButtonwe",
        true),
    new commentsdatas("Message fifth", false),
    new commentsdatas("Message first", true),
    new commentsdatas("Message first", true),
    new commentsdatas("Message second", false),
    new commentsdatas("Message second1 \n Message secondr", true),
    new commentsdatas(
        "RoundedRectangleBorder.side property does not work with ElevatedButton RoundedRectangleBorder.side property does not work with ElevatedButton2  RoundedRectangleBorder.side property does not work with ElevatedButton",
        false),
    new commentsdatas("Message fifth", false),
    new commentsdatas("Message fifth", false),
    new commentsdatas("Message first", true),
    new commentsdatas("Message second", false),
    new commentsdatas("Message second1 \n Message secondr", true),
  ];*/

  List dataMessageList = <commentsdatas>[];
  int getSelectedFileCount(List dataFileListNew) {
    var filtered = dataFileListNew.where((e) => e.selected == true);
    return filtered.length;
  }

/*  void getCommentsDetails() async {
    debugPrint('1ccccccccccccccccccccccccccc');
    final responses = await AuthRepo.getCommentsList('7', '1082');
    debugPrint('2ccccccccccccccccccccccccccc');
    String dec = AaaEncryption.decryptAESaaa(responses.toString());
    debugPrint('31ccccccccccccccccccccccccccc');
    debugPrint(dec);

    var tagObjsJson = jsonDecode(dec) as List;
    List<comments> tagObjs =
        tagObjsJson.map((tagJson) => comments.fromJson(tagJson)).toList();
    dataMessageList = tagObjs;

    debugPrint('678ccccccccccccccccccccccccccc');
  }*/
}

/*class commentsdatas {
  String message;
  bool selected;

  commentsdatas(this.message, this.selected);
}*/
