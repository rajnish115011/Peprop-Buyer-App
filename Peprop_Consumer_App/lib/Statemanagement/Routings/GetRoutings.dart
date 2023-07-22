


import 'package:get/get.dart';

import '../Screens/Profile/User_Profile.dart';
import 'App_Pages.dart';

class GetRoutings {


  List<GetPage>list=[

     GetPage(name: App_Pages.my_profile, page:()=> User_Profile())


  ];



}