


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:html/dom.dart';
import 'package:flutter/material.dart'as met ;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:upgrader/upgrader.dart';

class Check_Play_Store{
    Future<String?> getStoreVersion(String android,String apple, BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version.toString();


    String? storeVersion;
    if (Platform.isAndroid) {
      PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
      Document? result = await playStoreSearchAPI.lookupById(android, country: 'US');
      if (result != null) {
        storeVersion = PlayStoreResults.version(result);
        if(storeVersion.toString()!=version){
          show_update_dialog(context,version,storeVersion);
        }



      }

    } else if (Platform.isIOS) {

      RegExp hexColor = RegExp(r'^\d+\.\d+\.\d+(?:[+-]\S+)?$');
      RegExp hexColor1 = RegExp(r'^\d+\.\d+(?:[+-]\S+)?$');

      ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
      Map<dynamic, dynamic>? result =
      await iTunesSearchAPI.lookupByBundleId(apple, country: 'US');

      if (result != null) {

        storeVersion = ITunesResults.version(result);
        if(hexColor.hasMatch(storeVersion.toString())){
          if(storeVersion.toString()!=version){
             show_update_dialog(context,version,storeVersion);
          }}



      }


    } else {
      storeVersion = null;
    }
    return storeVersion;
  }

  void show_update_dialog(BuildContext ctx, String version, String? storeVersion) {
    showCupertinoDialog(
        barrierDismissible:true,
        context: ctx,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: met.Text(
              "Update Available",
              style: new TextStyle(fontFamily: "medium", fontSize: 18),
            ),

            content: met.Text(
              "It is highly recommended to update your PeProp.Money app for new features and latest functionality. Team PeProp.Money",
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [

              CupertinoDialogAction(
                onPressed: () async {
                  if(Platform.isAndroid){
                    AppUtils().open_url("https://play.google.com/store/apps/details?id=com.dasv.peprop_consumer_app&pli=1", ctx);

                  }else{
                    AppUtils().open_url("https://apps.apple.com/us/app/peprop-money/id1673701215", ctx);
                  }





                },
                child:  met.Text(
                  'UPDATE',
                  style: TextStyle(
                    fontFamily: "bold",
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


}