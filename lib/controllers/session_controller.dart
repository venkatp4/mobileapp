import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/session.dart';
import '../utils/UserDetails.dart';

class SessionController extends GetxController {
  final Userdata = UserDetails.empty().obs;

  final token = ''.obs;
  final key = ''.obs;
  final iv = ''.obs;
  final twoFactorAuthendication = ''.obs;
  final store = GetStorage();

  @override
  Future onInit() async {
    await getSession();
    super.onInit();
  }

  // ...
  // initSession
  void initSession(Session session) {
    debugPrint('get ------- set init');
    token.value = session.token;
    iv.value = session.iv;
    key.value = session.key;
    twoFactorAuthendication.value = session.twoFactorAuthentication;
  }

  // ...
  // setSession

  Future<void> setSession(Map<String, dynamic> data) async {
    try {
      final session = Session.fromJson(data);
      initSession(session);
      debugPrint('get ------- set');
      // final prefs = await SharedPreferences.getInstance();
      store.write('session', json.encode(session));
      store.save();
    } catch (e) {
      print(e);
    }
  }

  setSessionuser(Map<String, dynamic> data) async {
    try {
      //final session = Session.fromJson(data);
      debugPrint('session');
      Userdata.value = UserDetails.fromJson(data);
      debugPrint('session');
      store.write('userdetails', json.encode(data));
      //store.write('userdetails', json.encode(Userdata));
      store.save();
    } catch (e) {
      print(e);
    }
  }

  // ...
  // getSession
  Future<void> getSession() async {
    try {
      //final prefs = await SharedPreferences.getInstance();
      final session = store.read('session') ?? '';

      if (session != '') {
        final _session = Session.fromJson(json.decode(session));
        initSession(_session);
      }
    } catch (e) {
      debugPrint('get -------');
      print(e);
    }
  }

  // deleet Session
  void deleteSession() {}

  // ...

  // clearSession
/*
  Future<void> clearSession() async {
    token.value = '';
    user.value = User.empty();

    try {
      //final prefs = await SharedPreferences.getInstance();
      //await store.remove('domain');
      await store.remove('session');
      //await store.remove('domainmy');
      await store.remove('sessionmy');
    } catch (e) {
      print(e);
    }
  }*/

/*  void logoutuser() {
    debugPrint('logoutuser');
    clearSession();
    Get.offAllNamed('/login');
  }*/

// ...
}
