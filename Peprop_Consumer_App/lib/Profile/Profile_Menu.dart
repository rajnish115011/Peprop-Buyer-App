import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:peprop_consumer_app/All_transactions/All_transactions.dart';
import 'package:peprop_consumer_app/Profile/Update_Password/Update_Password.dart';
import 'package:peprop_consumer_app/Profile/User_Profile.dart';
import 'package:peprop_consumer_app/Sheets/All_Bottom_Sheets.dart';
import 'package:peprop_consumer_app/Rewards/Scrachers.dart';
import 'package:peprop_consumer_app/Rewards/Spin_View.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Privacy_Policy.dart';
import 'package:peprop_consumer_app/Terms_and_Conditions/Safety_Tips.dart';
import 'package:peprop_consumer_app/notification/Enable_Notifications.dart';
import 'package:peprop_consumer_app/widgets/ProfileMenu.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import '../Login/Login.dart';
import '../Rewards/Campaign_List.dart';
import '../Rewards/ReferAndEarn.dart';
import '../Utils/AppUtils.dart';

class Profile_Menu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BuildState();
  }

}
class BuildState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBar(context, ""),
      body: new Stack(
        children: [

         new SingleChildScrollView(
           physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
           child: new Column(
             children: [
               ProfileMenu_User("Profile","Add or Modify Address & KYC Status","assets/pprofile.png",on_click: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => User_Profile()));

               },),
               ProfileMenu_User("Booking & Transactions","View booking & transactions details","assets/pbanking.png",on_click: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => All_transactions()));


               },),
               ProfileMenu_User("Manage Notifications","Manage how you want to recieve important updates","assets/pnotifications.png",on_click: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Enable_Notifications()));


               },),
               ProfileMenu_User("Change Password","Update your PeProp account password","assets/ppassword.png",on_click: () async {
                 SharedPreferences sp=await SharedPreferences.getInstance();
                 String mobile=sp.getString("mobile").toString();


                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Update_Password(mobile)));

               },),

               ProfileMenu_User("Privacy  Policy","View Privacy Policy","assets/psecurity.png",on_click: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Privacy_Policy()));


               },),
               ProfileMenu_User("Account Safety Tips","Learn best practices to safeguard your PeProp account","assets/psafety.png",on_click: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Safety_Tips()));
               },),
               ProfileMenu_User("Loyalty & Rewards","Learn best practices to safeguard your PeProp account","assets/psafety.png",on_click: () async {
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ReferAndEarn(null)));

               },),


                  ProfileMenu_User("Logout","logout from your PeProp account on this device","assets/menu/logout.png",on_click: () async {
                  var data=await All_Bottom_Sheets().Confirmation_dialog("Logout", "Are you sure, Do you want to logout?", context);
                  if(data!=null&&data==true){
                    SharedPreferences sp=await SharedPreferences.getInstance();
                    sp.setString("token", "null");

                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(Route<dynamic> route) => false);

                  }


               },),
             ],
           ),
         )

        ],
      ),
    );
  }
  void showAlertDialog(BuildContext ctx, message, title) {
    showCupertinoDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              message,
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              // The "Yes" button
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  'Cancel',
                  style: new TextStyle(fontFamily: "medium", fontSize: 15),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  SharedPreferences sp=await SharedPreferences.getInstance();
                  await sp.clear();
                  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(Route<dynamic> route) => false);

                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontFamily: "medium",
                    fontSize: 15,
                  ),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  Future<Uri> createDynamicLink() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://pepropconsumer.page.link/',
      link: Uri.parse('https://play.google.com/store/apps/details?id=com.dasv.peprop_consumer_app&pli=1&'+sharedPreferences.getString("my_refer").toString()),
      androidParameters: AndroidParameters(
        packageName: 'com.dasv.peprop_consumer_app',
        minimumVersion: 1,
      ),
    );
    final Uri shortUrl = await FirebaseDynamicLinks.instance.buildLink(parameters);
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(parameters, shortLinkType: ShortDynamicLinkType.unguessable,);
    print(shortUrl);
    print(dynamicLink.shortUrl.toString());

    Share.share('I am inviting you to use PeProp.Money a simple and secure real state and bill payment app by peprop.Money\n\n'+dynamicLink.shortUrl.toString(), subject: 'Peprop.Money');


    return shortUrl;
  }


}