


import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Rewards/Spin/Spin_Sheet.dart';
import 'package:peprop_consumer_app/Rewards/Spin_View.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/Campaign_Model.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/AppUtils.dart';
import 'Points_Views.dart';

class ReferAndEarn extends StatefulWidget{
  Campaign_Model? model;
  ReferAndEarn(Campaign_Model? model){
    this.model=model;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Build_State();
  }

}
class Build_State extends State<ReferAndEarn>{
  bool loading=false;

  List<Offers_List_Refer>list=[];
  String wallet_balance="";

  wallet_data? wallet_data_model;

  @override
  void initState() {
    super.initState();
    get_campaign();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBarcolor(context, "", ColorFile.dark_blue),
      body:Stack(
        children: [
          if(loading)Container(child: Center(child: new CircularProgressIndicator(),),alignment: Alignment.center,)
          else new Column(
            children: [
                if(wallet_data_model!=null)Points_Views(wallet_data_model),
                Expanded(child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return new Column(
                        children: [
                          InkWell(child:new Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                            height: 170,
                            child:ClipRRect(borderRadius:new BorderRadius.circular(10) ,child:  CachedNetworkImage(imageUrl:list[index].offer_banner.toString(),fit: BoxFit.fill,),),

                          ),onTap: () async {
                            if(list[index].offer_type=="5"){




                            }
                            if(list[index].offer_type=="4"){
                            var value=await All_Bottom_Sheets().show_spin(list[index], context);
                            if(value!=null){
                              get_campaign();
                            }






                            }


                          },),
                          if(list[index].offer_type=="3")Card(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10)
                            ),
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  new Text(list[index].offer_description.toString(),style: Styles().styles_bold(17, ColorFile.black),),
                                  new SizedBox(height: 5,),
                                  new Text("Your Friend also gets "+list[index].referee_rewards.toString()+" "+list[index].reward_type,style: Styles().styles_regular(14, ColorFile.hint_color),),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                                    height: 80,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {

                                              createDynamicLink(list[index].referee_rewards.toString());
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: Colors.orangeAccent),
                                              child: Shimmer.fromColors(
                                                period: const Duration(milliseconds: 1500),
                                                baseColor: Colors.black,
                                                highlightColor: Colors.orangeAccent,
                                                child:  Text(
                                                  "INVITE NOW",style: TextStyle(fontFamily: "bold", fontSize: 16, color: ColorFile.black,),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )


                                ],
                              ),),)


                        ],
                      );
                    }))


            ],
          ),
        ],
      )


    );;
  }
   createDynamicLink(String point) async {
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

      String full_name=sharedPreferences.getString("full_name").toString();
      final dynamicLinkParams = DynamicLinkParameters(
       link:Platform.isAndroid?
       Uri.parse('https://play.google.com/store/apps/details?id=com.dasv.peprop_consumer_app&pli=1&'+sharedPreferences.getString("my_refer").toString()):
       Uri.parse('https://apps.apple.com/us/app/peprop-money/id1673701215#'+sharedPreferences.getString("my_refer").toString()),
       uriPrefix: "https://pepropconsumer.page.link",
       androidParameters: const AndroidParameters(packageName: "com.dasv.peprop_consumer_app",minimumVersion: 1),
       iosParameters: const IOSParameters(bundleId: "com.dasv.pepropconsumer.pepropConsumerApp",minimumVersion: '1',appStoreId: '1673701215'),
     );



     final dynamicLink =
     await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams, shortLinkType: ShortDynamicLinkType.unguessable,);
     print(dynamicLink.shortUrl.toString());
      Share.share(full_name+' has invited you to download and register PeProp.Money app. PeProp.Money is an app based real estate marketplace for buyers and investors to book online properties from anywhere across India and earn millions in cash rewards and benefits.Enjoy Joining bonus of '+point+" Points. \n\n"+dynamicLink.shortUrl.toString(), subject: 'Peprop.Money');


    // SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    // final DynamicLinkParameters parameters = DynamicLinkParameters(
    //   uriPrefix: 'https://pepropconsumer.page.link/',
    //
    //   link: Uri.parse('https://play.google.com/store/apps/details?id=com.dasv.peprop_consumer_app&pli=1&'+sharedPreferences.getString("my_refer").toString()),
    //   androidParameters: AndroidParameters(
    //     packageName: 'com.dasv.peprop_consumer_app',
    //     minimumVersion: 1),
    //     iosParameters: const IOSParameters(
    //     bundleId: 'com.dasv.pepropconsumer.pepropConsumerApp',
    //     minimumVersion: "1",
    //     appStoreId:"1673701215",
    //     ipadBundleId: "com.dasv.pepropconsumer.pepropConsumerApp",
    //
    //
    //
    //
    //
    //
    //   ),
    // );
    //
    // print(parameters);
    //  Uri shortUrl;
    // if(Platform.isAndroid){
    //   shortUrl = await FirebaseDynamicLinks.instance.buildLink(parameters);
    //
    // }else{
    //   final ShortDynamicLink shortLink =await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    //   shortUrl = shortLink.shortUrl;
    //
    // }
    // final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters, shortLinkType: ShortDynamicLinkType.unguessable,);
    // print(shortUrl);
    // print(dynamicLink.shortUrl.toString());
    // Share.share('I am inviting you to use PeProp.Money a simple and secure real state and bill payment app by peprop.Money\n\n'+dynamicLink.shortUrl.toString(), subject: 'Peprop.Money');



  }
  get_campaign() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    setState(() {
      loading=true;
    });

    var response=await Global_connection().post_method(formData,context, API.OffersCampaignsApi_list+"3");
    if(response!=null&&response.data!=null&&response.statusCode==200&&response.data["data"]!=null){
      var notify = response.data["data"] as List;
      var builder_details = response.data["wallet_data"];
      wallet_data_model = wallet_data.fromJson(builder_details);
      list= notify.map<Offers_List_Refer>((json) => Offers_List_Refer.fromJson(json)).toList();



    }
    setState(() {
      loading=false;
    });


  }



}