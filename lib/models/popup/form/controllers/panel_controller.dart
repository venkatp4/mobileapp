import 'package:get/get.dart';

class PanelController extends GetxController {
  // final sessionController = Get.find<SessionController>();

  final email = ''.obs;
  final hasEmailError = false.obs;

  final password = ''.obs;
  final hasPasswordError = false.obs;

  final isLoading = false.obs;
  final error = ''.obs;

  @override
  Future onInit() async {}
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
  // reset

  void reset() {
    email.value = '';
    password.value = '';
    hasEmailError.value = false;
    hasPasswordError.value = false;
    isLoading.value = false;
    error.value = '';
  }

  // ...
  // login

  // ...
}
