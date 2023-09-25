import 'dart:async';

import 'package:ez/controllers/ticket_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/nodule.dart';
import '../utils/format_date_time.dart';
import '../utils/nodule_type.dart';
import '../utils/testjsonvalues.dart';
import 'dart:convert';

class BatchWorkFolderBrowseController extends GetxController {
  final nodules = <Nodule>[].obs;
  final nodule = Nodule.empty().obs;

  final isLoading = false.obs;
  final breadcrumbs = <Nodule>[].obs;

  final sortProperties = ['Name', 'Items Count', 'Last Modified'];

  final itemsPerPage = 50;
  final rowFrom = 0.obs;
  final rowTo = 0.obs;
  final totalRows = 0.obs;
  final selectedFile = 0.obs;
  final showbottomup = false.obs;
  final scanopen = false.obs;

  double containerHeight = 0;

  TicketController ticketController = new TicketController();
  // onInit

  @override
  void onInit() {
    onNoduleTap(Nodule.empty());
    super.onInit();
  }

  // initiateProcess
  void initiateProcess() {
    ticketController.itemId = selectedFile.value;

/*    ticketController.initialize(
      Ticket.empty(),
      'Inbox',
      'Document',
    );*/

    selectedFile.value = 0;
    Get.back<dynamic>();
  }

  // addBreadcrumb
  void addBreadcrumb(Nodule nodule) {
    breadcrumbs.add(nodule);
  }

  // ...

  // onBreadcrumbTap

  void onBreadcrumbTap(Nodule breadcrumb) {
    final index = breadcrumbs
        .indexWhere((_breadcrumb) => breadcrumb.id == _breadcrumb.id);
    if (index == breadcrumbs.length - 1) {
      return;
    }

    breadcrumbs.removeRange(index + 1, breadcrumbs.length);
    nodule.value = breadcrumb;
    getNodules(nodule.value.noduleId);
  }

  // bredcrum Home sang
  void onBreadcrumbHome() {
    debugPrint('Home=====');
    // not need this if condition
    if (breadcrumbs.length == 1) {
      return;
    }
    debugPrint('Home===== 1 ');
    breadcrumbs.removeRange(1, breadcrumbs.length);
    nodule.value = breadcrumbs.last;
    getNodules(nodule.value.noduleId);
  }

  void onFabPlus() {
    if (showbottomup.value)
      showbottomup.value = false;
    else
      showbottomup.value = true;

    debugPrint('onFabPlus  - upload12');
  }

  void onUpload() {
    showbottomup.value = false;
    debugPrint('onFabPlus onUpload');
  }

  void onScan() {
    showbottomup.value = false;
    debugPrint('onFabPlus onScan');
  }

  // bredcrum Back sang
  void onFabBack() {
    // not need this if condition
    if (breadcrumbs.length == 1) {
      return;
    }
    breadcrumbs.removeLast();
    nodule.value = breadcrumbs.last;
    getNodules(nodule.value.noduleId);
  }

  // ...
  // onNoduleTap
  void onNoduleTap(Nodule _nodule) {
    debugPrint('onNoduleTap ');
    nodule.value = _nodule;
    if (nodule.value.type == NoduleType.File) {
      debugPrint('onNoduleTap 1----');
      Get.toNamed('/file', parameters: {
        'repositoryId': nodule.value.repositoryId.toString(),
        'fileId': nodule.value.id.toString(),
        'isWorkflowAttachment': 'false',
      });
      return;
    }
    addBreadcrumb(nodule.value);
    if (nodule.value.itemsCount == 0) {
      nodules.clear();
      return;
    }
    debugPrint('onNoduleTap 4');
    getNodules(nodule.value.noduleId);
    debugPrint('onNoduleTap 5');
  }

  // ...
  // onNoduleLongPress
  void onNoduleLongPress(Nodule _nodule) {
    debugPrint('onNoduleLongPress');
    if (_nodule.type == NoduleType.File) {
      nodule.value = _nodule;
      selectedFile.value = _nodule.id;
    }
  }

  // ...
  // reload
  void reload() {
    getNodules(nodule.value.noduleId);
  }

  // ...
  // getNodules
  Future getNodules(int noduleId, {int? from, int? to}) async {
    debugPrint('Home===== getNodules');
    isLoading.value = true;

    final payload = <String, dynamic>{
      'noduleId': noduleId,
      'pagination': {
        'rowFrom': from ?? 1,
        'rowTo': to ?? itemsPerPage,
      },
    };
    debugPrint('onNoduleTap 4' + noduleId.toString());
    //final result = await repositoryController.getNodules(payload);   // orginal source
    final result = tempFunction(noduleId);

    nodules.clear();

    if (result['nodules'] != null) {
      result['nodules']
          .forEach((dynamic nodule) => nodules.add(Nodule.fromJson(nodule)));

      rowFrom.value = result['pagination']['rowFrom'] ?? 0;
      rowTo.value = result['pagination']['rowTo'] ?? 0;
      totalRows.value = result['pagination']['totalRows'] ?? 0;
    }
    isLoading.value = false;
  }

  Map<dynamic, dynamic> tempFunction(int iNoduleId) {
    debugPrint('onNoduleTap 4e ' + iNoduleId.toString());

    try {
      Map<dynamic, dynamic> ff = jsonDecode(testJsonStaticValues.sRepositoris);
    } catch (e) {
      debugPrint('onNoduleTap 4eeeeeeeeeeeeeee ');
      print(e);
    }
    debugPrint('onNoduleTap 4dsdsd ' + iNoduleId.toString());
    switch (iNoduleId.toString()) {
      case '0':
        debugPrint('onNoduleTap 4 ==  ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sRepositoris);

      case '984':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFolder1);

      case '1219':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFolder2);
      case '985':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFolder2);
      case '987':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFolder2);

      case '990':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFileName);
      case '988':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFileName);

      /*     case 'file':
        debugPrint('onNoduleTap 4 == ' + iNoduleId.toString());
        return jsonDecode(testJsonStaticValues.sFileName);*/
    }
    debugPrint('onNoduleTap 4ff ' + iNoduleId.toString());
    return jsonDecode(testJsonStaticValues.sRepositoris);
  }

  // ...
  // sortNodules

  void sortNodules(String sortBy, String sortOrder) {
    Get.back<dynamic>();

    if (nodules.isNotEmpty) {
      if (sortBy == 'Items Count') {
        nodules.sort((a, b) => a.itemsCount.compareTo(b.itemsCount));
      } else if (sortBy == 'Last Modified') {
        nodules.sort((a, b) =>
            parseDateTime(a.modifiedAt).compareTo(parseDateTime(b.modifiedAt)));
      } else {
        nodules.sort((a, b) => a.name.compareTo(b.name));
      }

      if (sortOrder == 'Descending') {
        nodules.value = nodules.reversed.toList();
      }
    }
  }

  // ...

  // next

  void next() {
    getNodules(nodule.value.id,
        from: rowFrom.value + itemsPerPage, to: rowTo.value + itemsPerPage);
  }

  // ...

  // previous

  void previous() {
    getNodules(nodule.value.id,
        from: rowFrom.value - itemsPerPage, to: rowTo.value - itemsPerPage);
  }

  void fabProcess() {
    debugPrint('Pressed FAB plus');
  }
}
