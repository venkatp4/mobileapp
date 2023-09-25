import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../utils/helper/aes_encryption.dart';
import 'browse_view_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as enc;

class DashMainController extends GetxController {
  //final controller = Get.find<BrowseViewController>();
  RxString iCurrentSelect = 'dashboard'.obs;

  justPrint() {
    //debugPrint('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
    debugPrint(AaaEncryption.KeyVal.toString());
    debugPrint(AaaEncryption.IvVal.toString());
    debugPrint(AaaEncryption.sToken);
    debugPrint('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
  }
}
