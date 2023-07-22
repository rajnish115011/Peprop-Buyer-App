
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ApiService/ApiService.dart';



class MyProfile_Controller extends GetxController with StateMixin {
  final HomeApiService _homeApiService;

  MyProfile_Controller(this._homeApiService);

  @override
  onInit() async {
    change(null, status: RxStatus.loading());
    var response = await ovens();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future ovens() async {
    try {
      var response = await _homeApiService.loadHome();
      if (response.statusCode == 401) {
        // Get.toNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        //return json.decode(response.body);
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

  getData() async {
    // make status to loading
    change(null, status: RxStatus.loading());
    await ovens();
    change(null, status: RxStatus.success());
  }
}
