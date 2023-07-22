

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Banners_Model.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';
import 'package:peprop_consumer_app/Models/Master_Model.dart';
import 'package:peprop_consumer_app/Models/Search_Model.dart';
import 'package:peprop_consumer_app/Models/buy/Property_Kind.dart';
import 'package:peprop_consumer_app/Search/Search_Property_Buy.dart';
import 'package:peprop_consumer_app/Search/Search_Property_Globally.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/Bhk_Sheet.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/For_Kind_property.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/For_Availability.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/For_Property_Type.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/Funding_Purpose_Sheet.dart';
import 'package:peprop_consumer_app/buy_sell/sheets/Furnishing_Sheet.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Filters/Bottom_sheet_For_Area.dart';
import '../Models/City_Model.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Search/Search_City.dart';
import '../Utils/Lg.dart';
import '../widgets/App_Banners.dart';
import '../widgets/Form_Fields.dart';
import '../widgets/Buy_Sale_Header.dart';
import '../widgets/Multiple_Select_Widget.dart';
import '../widgets/User_Profile_Mode.dart';

class Enable_Notifications extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }


}

class BuildState extends State<Enable_Notifications>{

 bool isSwitched=false;

 bool loading=false;
 bool getdata=false;




 late User_Profile_Model profile_model;



  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppUtils.appBar(context, "title"),
        body:   Stack(
          children: [
           if(getdata==true)Center(child: new CircularProgressIndicator(),)else Padding(padding: EdgeInsets.all(20),child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           new Container(child:new Text("Manage Notifications",style: Styles().styles_bold(22, ColorFile.black),)),
           new SizedBox(height: 30,),
           new Container(child: Padding(padding: EdgeInsets.all(10),child: new Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               new Container(child: new Text("Enable/Disable Push Notifications",style: Styles().styles_medium(12, ColorFile.black),),),
               new Container(
                 child: new Row(children: [
                   Expanded(child: new Container(child: new Text("Enable Push notification for Booking,Site Visits,Banking",style: Styles().styles_medium(10, ColorFile.hint_color),),)),
                   Switch(
                     value: isSwitched,
                     onChanged: (value) {
                       update(value);
                     },
                   ),

               ],),)

             ],
           ),),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color)),)

         ],
       ),),
           if(loading)Center(child: new CircularProgressIndicator(),)

          ],
        ),





    );
  }

  Future<void> update(bool value) async {
    var _map = <String, String>{};
    _map['notification'] =value==true?"1":"0";
    setState(() {
      loading = true;
    });
    FormData mobile = new FormData.fromMap(_map);
    Response response=await ServiceConfig().postApiBodyAuthJson(API.passwordChange, mobile, context);
    if(response!=null&&response.statusCode==200){
      var data=await All_Bottom_Sheets().Success_dialog("You have successfully updated your notification setting.", context);
      if(data!=null&&data==true){
        Navigator.pop(context);
      }

      isSwitched=value;

    }

    setState(() {
      loading = false;
    });
  }


 get_data() async {
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   String user_id=sharedPreferences.getString("user_id").toString();
   setState(() {
     getdata = true;
   });
   var map = <String, String>{};
   map['user_id'] = user_id;
   FormData data = FormData.fromMap(map);
   ServiceConfig().postApiBodyAuthJson(API.usersList, data, context).then((value) {
     Response response = value;
     setState(() {
       getdata = false;
     });
     print('response User Profile$response');
     if (response != null && response.statusCode == 200&&response.data["list"].toString()!="null") {
       var builder_details = response.data["list"];
       profile_model = User_Profile_Model.fromJson(builder_details);
       if(profile_model!=null){
         if(profile_model.notification.toString()=="1"){
           isSwitched=true;
         }else{
           isSwitched=false;
         }
       }

     }
   }).catchError((onError){
     setState(() {
       getdata = false;
     });
   });

 }


}