import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ez/utils/UserDetails.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import '../api/auth_repo.dart';
import '../controllers/session_controller.dart';
import '../utils/helper/aes_encryption.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:encrypt/encrypt.dart' as enc;

import 'package:http/http.dart' as http hide Response;

class LoginController extends GetxController {
  final email = ''.obs;
  final hasEmailError = false.obs;

  final password = ''.obs;
  final hasPasswordError = false.obs;

  final isLoading = false.obs;
  final error = ''.obs;

  final sessionController = Get.find<SessionController>();

  late SharedPreferences pre;

  @override
  Future onInit() async {
    super.onInit();
  }

  // onEmailChanged
  void onEmailChanged(String value) {
    email.value = value;
  }

  // ...
  // onPasswordChanged
  void onPasswordChanged(String value) {
    password.value = value;
  }

  // ...
  // login

  Future login() async {
    isLoading.value = true;
    hasEmailError.value = email.value == '';
    hasPasswordError.value = password.value == '';
    debugPrint('--Paswwords--');
    print(email.value);
    print(hasEmailError);
    print(password.value);
    print(hasPasswordError);
// dont delete by sangili
    if (hasEmailError.value || hasPasswordError.value) {
      print('if first');
      isLoading.value = false;
      return;
    }
/*    if (email.value == 'admin' && password.value == '12345') {
      Get.offAllNamed('/home');
    }*/
    //Get.offAllNamed('/home');

    error.value = '';
    final payload = {
      'email': email.value,
      'password': password.value,
      'loggedfrom': 'MOBILE',
    };

    try {
      final response = await AuthRepo.login(payload, email.value);
      isLoading.value = false;
      Map<String, dynamic> data = jsonDecode(AaaEncryption.dec_base64(response.data.toString()));
      if (response.statusCode == 200) {
        sessionController.setSession(data);

        debugPrint('ttttttttttttttttttt');
        debugPrint(data['token'].toString());
        //save local storeage
        pre = await SharedPreferences.getInstance();
        pre.setString("ez_name", email.value);
        pre.setString("ez_pass", password.value);

        //Save Token details
        pre.setString("token", data['token'].toString());
        pre.setString("iv", data['iv'].toString());
        pre.setString("key", data['key'].toString());
        pre.setString("twoFactor", data['twoFactorAuthentication'].toString());

        pre.commit();
        debugPrint('ttttttttttttttttttt1');
        getUserDetails();
      } else {
        isLoading.value = false;
        throw 'invalid status code';
      }
    } on DioError catch (e) {
      debugPrint('==============1');
      isLoading.value = false;
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        error.value = 'Unauthorized Login';
      }
      if (statusCode == 402) {
        error.value = 'license expired';
      } else if (statusCode == 404) {
        error.value = 'email not found';
      } else if (statusCode == 409) {
        error.value = 'incorrect password';
      } else {
        rethrow;
      }
    } catch (e) {
      debugPrint('==============');
      print(e);
      error.value = 'error logging in';
    } finally {
      isLoading.value = false;
    }
  }

  Future getUserDetails() async {
    isLoading.value = true;
    debugPrint('--Userssssss--');
    error.value = '';

    try {
      AaaEncryption.KeyVal = enc.Key.fromBase64(pre.getString('key').toString());
      AaaEncryption.IvVal = enc.IV.fromBase64(pre.getString('iv').toString());
      AaaEncryption.sToken = pre.getString('token').toString();

      print(getUserDetails);
      final response = await AuthRepo.getUserDetails();
      debugPrint('User details      ' + response.data.toString());
      Map<String, dynamic> data = jsonDecode(AaaEncryption.decryptAESaaa(response.data));
      isLoading.value = false;

      if (response.statusCode == 200) {
/*
        debugPrint('session123ff');
        final Userdata = UserDetails.fromJson(data);
        debugPrint('session123=========22');
*/

        //pre.setString('Userdata', data.toString());
        pre.setString('Userdata', response.data.toString());
        pre.commit();

        sessionController.setSessionuser(data);
        debugPrint('session123=========');
        debugPrint(pre.getString('ez_name').toString());
        debugPrint(pre.getString('ez_pass').toString());
        debugPrint(pre.getString('Userdata').toString());

        Get.offAllNamed('/home');
      } else {
        throw 'invalid status code';
      }
    } on DioError catch (e) {
      //Get.offAllNamed('/home'); //byepass
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        error.value = 'Unauthorized Login';
      }
      if (statusCode == 402) {
        error.value = 'license expired';
      } else if (statusCode == 404) {
        error.value = 'email not found';
      } else if (statusCode == 409) {
        error.value = 'incorrect password';
      } else {
        rethrow;
      }
    } catch (e) {
      print(e);
      error.value = 'error logging in';
    } finally {
      isLoading.value = false;
    }
  }

/*  Future getUserDetails() async {
    isLoading.value = true;
    debugPrint('--Userssssss--');
    error.value = '';

    try {
      AaaEncryption.KeyVal = enc.Key.fromBase64(pre.getString('key').toString());
      AaaEncryption.IvVal = enc.IV.fromBase64(pre.getString('iv').toString());
      AaaEncryption.sToken = pre.getString('token').toString();
      print('gggggggggggggggggggggggggggggggggrrw45--1236');
      //var response = await AuthRepo.getUserDetails();
      */ /*    final responseda = await jsonDecode(AuthRepo.getUserDetails().toString());
      print('gggggggggggggggggggggggggggggggggrrw453');*/ /*

      var headers = {
        "Accept": "application/json",
        "Token": AaaEncryption.sToken,
        "Content-Type": "application/json"
      };
      var url = 'http://52.172.32.88/CoreAPI/api/user/1';

      final response = await http.get(Uri.parse(url), headers: headers);
      isLoading.value = false;

      try {
        String payloadenc = '{"currentPage": 1, "itemsPerPage": 20}';
        //payloadenc = '{"itemsPerPage":20,"currentPage":1}';
        print('get Details 2');
        final responses = await AuthRepo.getInboxListForFolder(
            '7', jsonEncode(AaaEncryption.EncryptDatatest(payloadenc)));
        print('get Details 3');

        final response = await AuthRepo.getUserDetails();
        print('get Details 4');
*/ /*        String ssd = json.decode(AaaEncryption.decryptAESaaa(response.body)).toString();

        Map<String, dynamic> data = json.decode(response.body);
        print(ss);*/ /*
        // Process the response
      } catch (e) {
        print('Error  : $e');
      }

      if (response.statusCode == 200) {
        String ss = json.decode(AaaEncryption.decryptAESaaa(response.body)).toString();
        Map<String, dynamic> data = json.decode(ss);
        print(data['id']);
        print('tttttttttttttttt3');
        pre.setString('Userdata', data.toString());
        pre.commit();

        sessionController.setSessionuser(data);
        debugPrint('session123=========');
        debugPrint(pre.getString('ez_name').toString());
        debugPrint(pre.getString('ez_pass').toString());
        debugPrint(pre.getString('Userdata').toString());

        Get.offAllNamed('/home');
      } else {
        throw 'invalid status code';
      }
    } on DioError catch (e) {
      //Get.offAllNamed('/home');
      print(e);
      // Map<String, dynamic> data = jsonDecode(AaaEncryption.decryptAESaaa(e.toString()));
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        error.value = 'Unauthorized Login';
      }
      if (statusCode == 402) {
        error.value = 'license expired';
      } else if (statusCode == 404) {
        error.value = 'email not found';
      } else if (statusCode == 409) {
        error.value = 'incorrect password';
      } else {
        rethrow;
      }
    } catch (e) {
      print(e);
      error.value = 'error logging in';
    } finally {
      isLoading.value = false;
    }
  }*/

// ...
}
