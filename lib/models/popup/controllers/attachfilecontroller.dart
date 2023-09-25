import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../models/fields.dart';

class AttcaheFileController extends GetxController {
  int iSelecteFileCount = 0;
  final tabitems = ['Home', 'Attachemnts', 'Comments', 'Task', 'History'];

  List dataFileList = [
    {
      "name": "dev.pdf",
      "description": "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
      "Status": "FAILED",
      "selected": false
    },
    {
      "name": "123.pdf",
      "description": "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
      "Status": "INDEXED",
      "selected": false
    },
    {
      "name": "123.pdf",
      "description": "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
      "Status": "PARTIALLY_INDEXED ",
      "selected": false
    }
  ];

  List dataFileListNew = <filedatas>[
    /*
    new filedatas("devrr.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "FAILED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "INDEXED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "PARTIALLY_INDEXED ", false),
    new filedatas("dev.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "FAILED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "INDEXED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "PARTIALLY_INDEXED ", false),
    new filedatas("dev.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "FAILED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "INDEXED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "PARTIALLY_INDEXED ", false),
    new filedatas("dev.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "FAILED", false),
    new filedatas("123.pdf", "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "INDEXED", false),
    new filedatas(
        "123-----.pdf",
        "Inversments \u2022 DATE \u2022 E-mail \u2022 ",
        "PARTIALLY_INDEXED ",
        false)*/
  ];

  int getSelectedFileCount(List dataFileListNew) {
    var filtered = dataFileListNew.where((e) => e.selected == true);
    return filtered.length;
  }
}

class filedatas {
  String name = '';
  String description = '';
  String Status = '';
  String createdByEmail = '';
  String createdAt = '';
  bool selected = false;

  filedatas(this.name, this.description, this.Status, this.selected,
      this.createdByEmail, this.createdAt);

  filedatas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['repository'];
    createdByEmail = json['createdByEmail'];
    createdAt = json['createdAt'];
    Status = 'UPLOADED'; //json['comments'];
    selected = false;
  }
}
