


import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBase_Logs{

  log_screen_view(page_name,class_name) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    await FirebaseAnalytics.instance.logEvent(
      name: page_name.toString(),
      parameters: <String, dynamic>{
        'user_id': sharedPreferences.getString("user_id").toString(),
        'name': sharedPreferences.getString("full_name").toString(),
        'event': page_name.toString(),

      },
    );

    await FirebaseAnalytics.instance.logScreenView(

        screenName: page_name.toString().replaceAll(" ", "_"),screenClass: class_name.toString().replaceAll(" ", "_")).onError((error, stackTrace){
      print("error"+error.toString());

    }).catchError((onError){
      print("error"+onError);


    });
  }
  button_click_event_log(page_name,click_purpose) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await FirebaseAnalytics.instance.logEvent(
      name: page_name,
      parameters: {
        "purpose": click_purpose,
        "user_id": sharedPreferences.getString("user_id").toString(),
      },
    );


  }

}