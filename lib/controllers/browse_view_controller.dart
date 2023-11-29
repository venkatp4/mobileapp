import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BrowseViewController extends GetxController {
  final isLoading = false.obs;
  final iCurrentSelect = 1.obs;

  // onInit
  @override
  void onInit() {
    super.onInit();
  }

  void tabFunction(int id) {
    debugPrint('tabfunction' + id.toString());
    iCurrentSelect.value = id;
    debugPrint('tabfunction1====' + iCurrentSelect.value.toString());
    isLoading.value = true;
    switch (id) {
      case 1:
        // Navigator.pushNamed(context, "formviewinitiate");

        //Get.offAllNamed('/home');
        Get.toNamed('/home');
        break;
      case 2:
        //Get.offAllNamed('/task');
        Get.toNamed('/task');
        break;
      case 3:
        //Get.offAllNamed('/folder');
        Get.toNamed('/folder');
        break;
      case 4:
        //Get.offAllNamed('/tasks');
        Get.toNamed('/tasks');
        break;
      case 5:
        //Get.offAllNamed('/web');
        Get.toNamed('/web');
        break;
    }
    isLoading.value = false;
  }
}
