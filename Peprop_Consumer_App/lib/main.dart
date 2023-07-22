// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/notification/Notification_details.dart';
import 'package:peprop_consumer_app/widgets/Custom_Elevation_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_checker/store_checker.dart';
import 'API/API.dart';
import 'Color/ColorFile.dart';
import 'Dashboard/Dashboard.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Global_connection/Global_connection.dart';
import 'Notification_Functions.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,

  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> initNotification() async {


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: false,
    requestAlertPermission: false,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,

  );

  final LinuxInitializationSettings initializationSettingsLinux =LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, macOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);



  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
    routes: <String, WidgetBuilder>{
      '/Login': (BuildContext context) => new Login()
    },
  ));
}
Future<void> main() async {

  // await DotEnv().load('.env');
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Notification_Functions().registerNotification();

  initNotification();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true,sound: true);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeProp.Money',

      home:  MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var response=null;
  bool loading=true;



  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    FirebaseMessaging.onMessage.listen(Notification_Functions().firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(Notification_Functions().firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onBackgroundMessage(Notification_Functions().firebaseMessagingBackgroundHandler);
    // Moengage_Files().intitialize_moengage(_moengagePlugin);



    dashboard_api();


  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: ColorFile.app_color,body:Stack(
      children: [
        new Container(
          alignment: Alignment.topRight,
          child: Image.asset("assets/topside.png",color: ColorFile.app_color_gradient,),
        ),
        new Container(
          alignment: Alignment.bottomLeft,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  Image.asset("assets/bottom_left.png",color: ColorFile.app_color_gradient,),
        ),
        new Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png",color: ColorFile.white,),
              new SizedBox(height: 30,),
              if(loading)Center(child: new CircularProgressIndicator(color: ColorFile.white,),),
              if(loading==false&& response==null)
                Custom_Elevation_button("    Reload    ",14,onclick: (){
                  dashboard_api();

                },),

            ],
          ),


        ),
      ],
    ));

  }

  navigationPage() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

  Future<void>   dashboard_api() async{

     SharedPreferences prefNew =await SharedPreferences.getInstance();
     PendingDynamicLinkData initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
     Source installationSource = await StoreChecker.getSource;
     String is_first= prefNew.getString("is_first").toString().replaceAll("null", "true");

    if(is_first=="true"){
      prefNew.setString("is_first","false");
      switch (installationSource) {
        case Source.IS_INSTALLED_FROM_PLAY_STORE:
          send_notification();


          break;
        case Source.IS_INSTALLED_FROM_APP_STORE:
          send_notification();

          break;

      }

    }

       if (initialLink != null) {
        if(Platform.isAndroid){
          final Uri deepLink = initialLink.link;
          var refer=initialLink.link.toString().replaceAll("https://play.google.com/store/apps/details?id=com.dasv.peprop_consumer_app&pli=1&", "");

          prefNew.setString("refer_code", refer);
          set_device(refer);
        }else{
          final Uri deepLink = initialLink.link;
          var refer=initialLink.link.toString().replaceAll("https://apps.apple.com/us/app/peprop-money/id1673701215#", "");
          prefNew.setString("refer_code", refer);
          set_device(refer);

        }

    }else{

    }
    setState(() {
      loading=true;
    });


    String city=prefNew.getString("city").toString().replaceAll("null", "Choose City");
    String city_id=prefNew.getString("city_id").toString().replaceAll("null", "");
    String token=prefNew.getString("token").toString();
    var map = new Map<String, dynamic>();
    map['limit'] = 10;
    map['start'] =0;
    map['city'] =city;
    if(city_id!="")
    map['city_id'] =city_id;


    if(prefNew.getString("user_id").toString()!="null"){
      map['user_id'] =prefNew.getString("user_id").toString();
    }
    print(json.encode(map));
    FormData formData = new FormData.fromMap(map);
    response=await Global_connection().post_method(formData, context, API.getDashboard);
    if(response!=null&&response.data!=null&&response.statusCode==200){
      Map map=response.data;
      String encodedMap = json.encode(map);
      prefNew.setString("response",encodedMap);
      navigationPage();

    }
    setState(() {
      loading=false;
    });



    }

  Future<void> set_device(String refer)async {
    var map = new Map<String, dynamic>();
    String device_id=await AppUtils().getDeviceDetails();
    map['device_id'] = device_id.toString();
    map['referral_code'] =refer.toString();
    FormData formData = new FormData.fromMap(map);
    await Global_connection().post_method(formData, context, API.userDeviceReferral);
  }
    send_notification() async {
    String token = await FirebaseMessaging.instance.getToken();
    var map = new Map<String, dynamic>();
    map['firebase_token'] =token.toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    var res=await Global_connection().post_method(formData, context, API.appDownload);
    print("respoonse"+res.toString());

  }

}




class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)..badCertificateCallback =(X509Certificate cert, String host, int port) => true;
  }
}
void onDidReceiveLocalNotification(int id, String title, String body, String payload) {
  Navigator.of(navigatorKey.currentState.context).push(MaterialPageRoute(builder: (context) => Notification_details(body.toString(),null)));

}


Future<void> onDidReceiveNotificationResponse(NotificationResponse details) async {
  Navigator.of(navigatorKey.currentState.context).push(MaterialPageRoute(builder: (context) => Notification_details(details.payload.toString(),null)));



}


