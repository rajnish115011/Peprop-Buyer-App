import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Book_Now/my_booking/Commercial_Tab.dart';
import 'package:peprop_consumer_app/Book_Now/my_booking/Resedential_Tab.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import 'package:peprop_consumer_app/Enquiry/tabs/Broker_RM_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/My_Projects_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/New_Request_Tab.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/FireBase_Logs.dart';

class My_Booking extends StatefulWidget {

  int type=0;
  My_Booking(int type){
    this.type=type;

  }

  @override
  _MyEnquriesListState createState() => _MyEnquriesListState();
}

class _MyEnquriesListState extends State<My_Booking> {
  bool loading = false;


  @override
  void initState() {

    super.initState();
    create_log();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex:widget.type==1?0:1,
      child: Scaffold(
          appBar: AppUtils.appBarTitle(context, "My Booking"),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25.0)
                  ),
                  child:  TabBar(
                    indicator: BoxDecoration(
                        color: ColorFile.yellowdark,
                        borderRadius:  BorderRadius.circular(25.0)
                    ) ,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
                    tabs:   [
                      Tab(text: 'Residential',),
                      Tab(text: 'Commercial',),


                    ],
                  ),
                ),
                 Expanded(
                    child: TabBarView(
                      children:  [
                        Resedential_Tab(widget.type),
                        Commercial_Tab(widget.type),



                      ],
                    )
                )
              ],
            ),
          )
      ),
    );

  }



  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View My Booking", "View My Booking");

  }




}
