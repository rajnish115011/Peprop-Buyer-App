import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import 'package:peprop_consumer_app/Enquiry/tabs/Broker_RM_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/My_Projects_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/New_Request_Tab.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class My_Enquiry extends StatefulWidget {
  const My_Enquiry({Key? key}) : super(key: key);

  @override
  _MyEnquriesListState createState() => _MyEnquriesListState();
}

class _MyEnquriesListState extends State<My_Enquiry> {
  bool loading = false;


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
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
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child:  TabBar(


                    indicator: BoxDecoration(
                        color:ColorFile.yellowdark,
                        borderRadius:  BorderRadius.circular(5.0)
                    ) ,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
                    tabs:   [
                      Tab(text: 'Projects',),
                      Tab(text: 'Brokers/Developers',),
                      Tab(text: 'New Request',),


                    ],
                  ),
                ),
                 Expanded(
                    child: TabBarView(

                      children:  [
                        My_Projects_Tab(null),
                        Broker_RM_Tab(),
                        New_Request_Tab(),


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
