import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../api/workflow_repo.dart';
import '../models/MenuInbox.dart';
import '../utils/helper/aes_encryption.dart';

class TreeInboxListviewController extends GetxController {
  //final controller = Get.find<BrowseViewController>();
  RxString iCurrentSelect = 'dashboard'.obs;
  List<MenuInbox> data = [];
  late MenuInbox miList;

  Future<List<MenuInbox>> getWorkFlowList() async {
    final response = await WorkflowRepo.getlistByUserId();
    final dtemp = AaaEncryption.decryptAESaaa(response.data);

    List datas = json.decode(dtemp);
    //print(datas.length);
    // print(MenuInbox.dataList.toString());
    data = [];
    datas.forEach((element) {
      // print('jjjjjjjjjj1');
      data.add(MenuInbox.fromJson(element));
      //data.add(MenuInbox(name: '', subMenu: ''));
      //MenuInbox
    });

    /*  print(data.length);
    print('jjjjjjjjjj2');*/
    return data;
    //return datas;
/*    print(dec);
    print('31wwwwccccccccccccccccccccccccccc');
    print(pre.getString('username'));

    var tagObjsJson = jsonDecode(dec) as List;
    List<commentsdatas> tagObjs =
        tagObjsJson.map((tagJson) => commentsdatas.fromJson(tagJson, pre.getInt('id'))).toList();
*/ /*    setState(() {
      controller.dataMessageList = tagObjs;
    });*/ /*

    debugPrint('678ccccccccccccccccccccccccccc');*/
  }
}
