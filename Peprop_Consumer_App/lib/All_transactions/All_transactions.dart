import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/All_transactions/BBps_Transaction_Tab.dart';
import 'package:peprop_consumer_app/All_transactions/Book_now_Transaction_Tab.dart';
import 'package:peprop_consumer_app/All_transactions/Wallet_Transaction.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/Broker_RM_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/My_Projects_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/New_Request_Tab.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'All_transactions_Tab.dart';

class All_transactions extends StatefulWidget {


  @override
  _MyEnquriesListState createState() => _MyEnquriesListState();
}

class _MyEnquriesListState extends State<All_transactions> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                    isScrollable: true,
                    indicator: BoxDecoration(
                        color:ColorFile.yellowdark,
                        borderRadius:  BorderRadius.circular(25.0)
                    ) ,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
                    tabs:   [
                      Tab(text: 'All transaction',),
                      Tab(text: 'Booking Transaction',),
                      Tab(text: 'BBPS Transactions',),
                      Tab(text: 'Gift Card Transactions',),
                    ],
                  ),
                ),
                 Expanded(
                    child: TabBarView(
                      children:  [
                        All_transactions_Tab(),
                        Book_now_Transaction_Tab(),
                        BBps_Transaction_Tab(),
                        Wallet_Transaction(false),
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
