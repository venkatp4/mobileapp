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
        Get.offAllNamed('/home');
        break;
      case 2:
        Get.offAllNamed('/task');
        break;
      case 3:
        Get.offAllNamed('/folder');
        break;
      case 4:
        Get.offAllNamed('/tasks');
        break;
      case 5:
        Get.offAllNamed('/web');
        break;
    }
    isLoading.value = false;
  }
}
