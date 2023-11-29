import 'package:dio/dio.dart';

import 'package:get/get.dart';

import '../controllers/session_controller.dart';
import '../utils/helper/aes_encryption.dart';
import 'package:http/http.dart' as http;

class Api extends GetxController {
  final controller = Get.find<SessionController>();

  Dio client() {
    return Dio(
      //BaseOptions(baseUrl: 'http://52.172.32.88/eZenterpriseAPI/api'),
      BaseOptions(
          baseUrl: 'http://52.172.32.88/CoreAPI/api/',
          headers: {"Accept": "application/json;text/html"}),
    );
  }

  clientLogin(String sUserEmail) {
/*    var headers = {
      "Accept": "application/json",
      "Token": AaaEncryption.sToken,
      "Content-Type": "application/json"
    };
    var url = 'http://52.172.32.88/CoreAPI/api/user/1';
    final response = await http.get(Uri.parse(url), headers: headers);*/

    return Dio(
      BaseOptions(baseUrl: 'http://52.172.32.88/CoreAPI/api/', headers: {
        "Accept": "application/json;text/html",
        "Token": 'email ' + sUserEmail,
        "Content-Type": "application/json"
      }),
    );
  }

  Dio clientWithHeader() {
/*    print('clientWithHeader');
    print(AaaEncryption.sToken);*/
    var dtemp = Dio(BaseOptions(
        // baseUrl: 'http://52.172.32.88/eZenterpriseAPI/api/',
        baseUrl: 'http://52.172.32.88/CoreAPI/api/',
        headers: {
          "Accept": "application/json;text/html",
          "Token": AaaEncryption.sToken,
          "Content-Type": "application/json",
        }));

    return dtemp;
  }

  Dio clientWithHeaderFile() {
/*    print('clientWithHeader');
    print(AaaEncryption.sToken);*/
    var dtemp = Dio(BaseOptions(
        // baseUrl: 'http://52.172.32.88/eZenterpriseAPI/api/',
        baseUrl: 'http://52.172.32.88/CoreAPI/api/',
        headers: {
          "Accept": "*/*",
          "Token": AaaEncryption.sToken,
          "Content-Type": "multipart/form-data",
        }));

    return dtemp;
  }

//Orginal
/*  Dio clientWithHeader() {
    print('clientWithHeader');
    print(AaaEncryption.sToken);
    var dtemp = Dio(BaseOptions(
      // baseUrl: 'http://52.172.32.88/eZenterpriseAPI/api/',
      baseUrl: 'http://52.172.32.88/CoreAPI/api/',
      headers: {
        "Accept": "application/json",
        "Token": AaaEncryption.sToken,
        "Content-Type": "application/json"
      },
    ));
    return dtemp;
  }*/

//dio.options.headers["authorization"] = "token ${token}";
/*  Dio versionclient() {
    return Dio(
      BaseOptions(baseUrl: 'https://cloud.ezofis.com/EZOFISAPI/v1'),
    );
  }*/
}
