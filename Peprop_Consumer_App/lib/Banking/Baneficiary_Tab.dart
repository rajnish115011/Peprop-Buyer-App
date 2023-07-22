import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import 'package:peprop_consumer_app/Enquiry/tabs/Broker_RM_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/My_Projects_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/New_Request_Tab.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Baneficiary_List_Inside.dart';
import 'Baneficiary_List_OutSide.dart';

class Baneficiary_Tab extends StatefulWidget {
  String acc_no="";
  String accountName="";
  bool is_transfer=false;


  Baneficiary_Tab(String acc_no, String accountName, bool is_transfer){
    this.acc_no=acc_no;
    this.accountName=accountName;
    this.is_transfer=is_transfer;


  }
  @override
  _MyEnquriesListState createState() => _MyEnquriesListState();
}

class _MyEnquriesListState extends State<Baneficiary_Tab> {
  bool loading = false;


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppUtils.appBar(context, ""),
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
                        color:ColorFile.yellowdark,
                        borderRadius:  BorderRadius.circular(25.0)
                    ) ,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
                    tabs:   [
                      Tab(text: 'Outside PeProp',),
                      Tab(text: 'Inside PeProp',),


                    ],
                  ),
                ),
                 Expanded(
                    child: TabBarView(

                      children:  [
                        Baneficiary_List_OutSide(widget.acc_no,widget.accountName,widget.is_transfer),

                        Baneficiary_List_Inside(widget.acc_no,widget.accountName,widget.is_transfer),


                      ],
                    )
                )
              ],
            ),
          )
      ),
    );

  }







}
