

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Refund/Refund_Reason.dart';
import 'package:peprop_consumer_app/Book_Now/my_Booking_details/My_Booking_Details.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Enquiry/Broker_Properties_List.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/My_Enquiry_BokerRM.dart';
import '../../widgets/PropertyItem.dart';
import '../Booking_Status/Booking_Status.dart';


class Resedential_Tab extends StatefulWidget{
  int type=0;
  Resedential_Tab(int type){
    this.type=type;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}

class Build_state extends State<Resedential_Tab>{
  bool loading=false;
  List<My_Booking_Models> list = [];
  @override
  void initState() {
    get_data();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        if(loading)Center(child: new CircularProgressIndicator(),)else if(list.length==0)No_Data_Placeholder("You don't have any booking..!!")else
              ListView.builder(
              shrinkWrap: false,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return PropertyItem(list[index],
                  whole_click: (){
                    var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) =>My_Booking_Details(list[index])));

                  },claim_refund: () async {
                    var response =await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Refund_Reason(list[index])));
                    if(response!=null){
                      get_data();
                    }
                  },booking_status: () async {
                    var response =await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Booking_Status(list[index])));

                  },);

              }),


      ],
    );
  }

  Future<void> get_data() async {
    setState(() {
      loading = true;
    });
    var map = <String, String>{};
    map['property_type'] ="1";
    FormData mobile = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.getMyBookingDetails, mobile, context).then((value) {
      Response response = value;

      setState(() {
        loading=false;
      });

      if (response != null && response.statusCode == 200) {
        var notify = response.data["list"] as List;
        list = notify.map<My_Booking_Models>((json) =>My_Booking_Models.fromJson(json)).toList();
      }
    }).catchError((onError){
      setState(() {
        loading=false;
      });
    });
  }

}