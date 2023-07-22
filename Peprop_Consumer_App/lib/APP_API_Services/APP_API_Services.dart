import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APP_API_SERVICES extends GetConnect {
  static String base="https://app.peprop.money/apis/Api/loginSendOtp";
  Future<Response<dynamic>> loadHome() async {
    Map map={
      "country_code":"91",
      "mobile":"9971055280",
    };
    return post(base,map);
  }


  Future<Response<dynamic>> post_method(String tnc) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    String? tokenN = sharedPreferences.getString("token").toString().trim();
    return post(tnc,new Map(),headers: {
      "Authorization":tokenN.toString()

    });
  }


}