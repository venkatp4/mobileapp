import 'dart:convert';

import 'package:ez/models/popup/controllers/popupfullpagecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../api/auth_repo.dart';
import '../../../api/taskform_repo.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../../comments.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class MultiSelectMainController extends GetxController {
  String sSelectedmemberIds = "";
  List<String> items = [];
  List<String> itemsId = [];
  String sSelectedmemberIdsd = "";

  Future<List<String>> fetchStaff() async {
    print('init multi1');
    var temp;
    //final payload = {'column': '', 'keyword': '', 'rowFrom': 0, 'rowTo': 0};
    //'{"currentPage": 1, "itemsPerPage": 20}';
    //String payloadenc = '{"currentPage": 1, "itemsPerPage": 20}';
    print('2222222222222222222222222222222222');
    String payload = '{"criteria":"userType","value":"Normal"}';
    print(jsonEncode(AaaEncryption.EncryptDatatest(payload)));

    payload = '{criteria:userType,value:Normal}';
    print(jsonEncode(AaaEncryption.EncryptDatatest(payload)));

    payload = '{criteria:"userType",value:"Normal"}';
    print(jsonEncode(AaaEncryption.EncryptDatatest(payload)));

    payload = '{"criteria":userType,"value":Normal}';
    print(jsonEncode(AaaEncryption.EncryptDatatest(payload)));

    payload = '{"criteria":"userType","value":"Normal"}';
    print(AaaEncryption.EncryptDatatest(payload));

    payload = '{criteria:userType,value:"Normal}';
    print(AaaEncryption.EncryptDatatest(payload));

    payload = '{criteria:"userType",value:"Normal"}';
    print(AaaEncryption.EncryptDatatest(payload));

    payload = '{"criteria":userType,"value":Normal}';
    print(AaaEncryption.EncryptDatatest(payload));
    //Fkw7HjvauCSlRQR2Z5zm5jUV6B1iIDAzkbJ+C65JJ9DmVJ1b9HxlIho/rUjGcZ97"
    //print(jsonEncode(AaaEncryption.EncryptDatatest(payload)));

    final response = await AuthRepo.getUserList(AaaEncryption.EncryptDatatest(payload));
    print('rrrrrrrrrrrrr');
    print(response.data);
    Map<String, dynamic> data = jsonDecode(AaaEncryption.decryptAESaaa(response.data));
    temp = jsonDecode(AaaEncryption.decryptAESaaa(response.data)) as List<dynamic>;
    print('');
    print('');

/*    String dec = AaaEncryption.decryptAESaaa(responses.toString());
    String url = "liststaffapp"; //24 11 38 15 50 20
    var response = await http.get(Uri.parse(url));

    Map<String, dynamic> responseJson = {};
    items = [];
    itemsId = [];*/
/*    if (response.statusCode == 200) {
      responseJson = json.decode(response.body) as Map<String, dynamic>;

      if (responseJson['data'].length > 0) {
        for (int i = 0; i < responseJson['data'].length; i++) {
          if (responseJson['data'][i]['name'].toString().trim().length > 4) {
            items.add(responseJson['data'][i]['name'].toString().trim());
            itemsId.add(responseJson['data'][i]['id'].toString().trim());
          }
        }
      }
      return items;
    } else {
      throw Exception('Failed to load data from Server.');
    }*/

    return items;
  }
}
