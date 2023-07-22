
import 'dart:convert';

import 'package:get/get.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../APP_API_Services.dart';

class LoginController extends GetxController with StateMixin {
  final APP_API_SERVICES _homeApiService;
  LoginController(this._homeApiService);
  Future ovens() async {
    change(null, status: RxStatus.loading());
    try {
      var response = await _homeApiService.loadHome();

      if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        return json.decode(response.body);
        change(response, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
      // var message = response.toString();
      //

      // log('${json.decode(response.body)}');
      // log('All ovens loaded successfully');
    } catch (err, _) {

      rethrow;
    }
  }

}


class Terms_Controller extends GetxController with StateMixin {

  final APP_API_SERVICES _homeApiService;
  Terms_Controller(this._homeApiService);
  @override
  void onInit() {

    get();
    super.onInit();


  }
  Future get() async {
    change(null, status: RxStatus.loading());
    try {
      var response = await _homeApiService.post_method(API.tnc);
      print("status code"+response.statusCode.toString());

      if (response.statusCode == null) {

        change(null, status: RxStatus.error());
      }

     else if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      else if (response.statusCode == 200) {
        change(response, status: RxStatus.success());

      } else {
        change(null, status: RxStatus.empty());
      }

    } catch (err, _) {
      print("error");

      rethrow;
    }
  }

}


