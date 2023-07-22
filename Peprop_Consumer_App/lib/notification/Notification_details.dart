

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

import '../Dashboard/Dashboard.dart';
import '../Filters/Bottom_sheet_For_Area.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/City_Model.dart';
import '../Search/Search_City.dart';
import '../Utils/Lg.dart';
import '../widgets/App_Banners.dart';
import '../widgets/Form_Fields.dart';
import '../widgets/Buy_Sale_Header.dart';
import '../widgets/Multiple_Select_Widget.dart';
import '../widgets/User_Profile_Mode.dart';

class Notification_details extends StatefulWidget {
  String? id;
  Notification_details(String payload, String? id){
    this.payload=payload;
    this.id=id;

  }
  String payload="";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BuildState();
  }


}

class BuildState extends State<Notification_details>{



  @override
  void initState() {

    if(widget.id!=null){
      read();
    }
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:Scaffold(
      backgroundColor: Colors.white,
      appBar: AppUtils.appBardashboard(context, "Notification Details",widget.id),
      body:Stack(
        children: [
          SingleChildScrollView(child: new Column(children: [
            new Container(padding: EdgeInsets.all(10),child: new Row(children: [
              Expanded(child: new Container(child: new Text(widget.payload.toString(),style: Styles().styles_regular(15, ColorFile.black),),))
            ],),)
          ],),)


        ],
      ),





    ),onWillPop: (){
      if(widget.id==null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()),(Route<dynamic> route) => false);

      }else{
        Navigator.pop(context,"response");
      }
      return Future.value(true);
    },);

  }

  Future<void> read() async {
    var _map = new Map<String, String>();
    _map['notification_id'] = widget.id.toString();
    FormData formData = new FormData.fromMap(_map);

    var response=await Global_connection().post_method(formData,context, API.notificationsView);
    print(response.data.toString());



  }



}