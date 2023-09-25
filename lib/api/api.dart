import 'package:dio/dio.dart';

import 'package:get/get.dart';

import '../controllers/session_controller.dart';
import '../utils/helper/aes_encryption.dart';

class Api extends GetxController {
  final controller = Get.find<SessionController>();

  Dio client() {
    return Dio(
      //BaseOptions(baseUrl: controller.apiUrl.value),
      BaseOptions(baseUrl: 'http://52.172.32.88/eZenterpriseAPI/api'),
      //http://52.172.32.88/eZenterpriseAPI/api/
    );
  }

  Dio clientWithHeader() {
    return Dio(
        //BaseOptions(baseUrl: controller.apiUrl.value),
        BaseOptions(
      //http://52.172.32.88/eZenterpriseAPI/swagger/ui/index
      baseUrl: 'http://52.172.32.88/eZenterpriseAPI/api/',
      headers: {
        "Accept": "application/json",
        "Authorization": AaaEncryption.sToken,
        "Content-Type": "application/json"
      },
    ));
  }
//dio.options.headers["authorization"] = "token ${token}";
/*  Dio versionclient() {
    return Dio(
      BaseOptions(baseUrl: 'https://cloud.ezofis.com/EZOFISAPI/v1'),
    );
  }*/
}
