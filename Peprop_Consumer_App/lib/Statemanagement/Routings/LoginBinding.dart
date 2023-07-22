

import 'package:get/get.dart';

import '../Controllers/LoginController.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }


}