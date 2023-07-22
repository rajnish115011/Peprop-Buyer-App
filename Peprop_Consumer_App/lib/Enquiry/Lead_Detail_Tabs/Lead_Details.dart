import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import 'package:peprop_consumer_app/Enquiry/tabs/Broker_RM_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/My_Projects_Tab.dart';
import 'package:peprop_consumer_app/Enquiry/tabs/New_Request_Tab.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/FireBase_Logs.dart';
import 'About_Profile.dart';
import 'Inventory_Tab.dart';
import 'Site_Visit_Tab.dart';

class Lead_Details extends StatefulWidget {
  BrokerModelEn? brokerModelList;
   Lead_Details(BrokerModelEn brokerModelList){
    this.brokerModelList=brokerModelList;
  }

  @override
  _MyEnquriesListState createState() => _MyEnquriesListState();
}

class _MyEnquriesListState extends State<Lead_Details>with SingleTickerProviderStateMixin {
  bool loading = false;
  int intial_index=0;

  late TabController _controller;
  late TabController _controller2;


  @override
  void initState() {
    method();
    create_log();

    super.initState();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View Lead Details", "View Lead Details");

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
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child:  TabBar(

                    controller: _controller,

                    indicator: BoxDecoration(
                        color:ColorFile.yellowdark,
                        borderRadius:  BorderRadius.circular(5.0)
                    ) ,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
                    tabs:   [
                      Tab(text: 'About',),
                      Tab(text: 'Site Visits',),
                      Tab(text: 'Inventory',),
                      Tab(text: 'Suggested Properties',),

                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      controller: _controller,

                      children:  [
                        About_Profile(widget.brokerModelList,on_click: (){_controller.animateTo(2);},),
                        Site_Visit_Tab(widget.brokerModelList),
                        Inventory_Tab(widget.brokerModelList),
                        My_Projects_Tab(widget.brokerModelList),

                      ],
                    )
                )
              ],
            ),
          )
      ),

    );


    return DefaultTabController(
      length: 4,

      child: Scaffold(

          body: Stack(
            children: [
              DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:ColorFile.app_color,
                      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
                      statusBarBrightness: Brightness.light, // For iOS (dark icons)
                    ),
                    backgroundColor: ColorFile.app_color,
                    title: new Text("Details",style: new TextStyle(fontFamily: "medium",fontSize: 17),),
                    bottom: TabBar(
                      controller: _controller,
                      labelStyle: new TextStyle(
                          fontFamily: "medium", fontSize: 17),
                      isScrollable: true,
                      tabs: [
                       Tab(text: 'About',),
                       Tab(text: 'Site Visits',),
                       Tab(text: 'Inventory',),
                       Tab(text: 'Suggested Properties',),

                      ],
                    ),

                  ),
                  body: TabBarView(
                    controller: _controller,
                    children: [
                    About_Profile(widget.brokerModelList,on_click: (){_controller.animateTo(2);},),
                    Site_Visit_Tab(widget.brokerModelList),
                    Inventory_Tab(widget.brokerModelList),
                    My_Projects_Tab(widget.brokerModelList),


                    ],
                  ),



                ),
              ),
            ],
          )


          //
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Column(
          //     children: [
          //       Container(
          //         height: 45,
          //         decoration: BoxDecoration(
          //             color: Colors.grey[300],
          //             borderRadius: BorderRadius.circular(25.0)
          //         ),
          //         child:  TabBar(
          //           controller: _controller,
          //           isScrollable: true,
          //           indicator: BoxDecoration(
          //               color:ColorFile.yellowdark,
          //               borderRadius:  BorderRadius.circular(25.0)
          //           ) ,
          //           labelColor: Colors.white,
          //           unselectedLabelColor: Colors.black,
          //           labelStyle: new TextStyle(fontSize: 12,fontFamily: "regular"),
          //           tabs:   [
          //             Tab(text: 'About',),
          //             Tab(text: 'Site Visits',),
          //             Tab(text: 'Inventory/Cost Sheet',),
          //             Tab(text: 'Suggested Properties',),
          //
          //
          //           ],
          //         ),
          //       ),
          //        Expanded(
          //           child: TabBarView(
          //             controller: _controller,
          //             children:  [
          //               About_Profile(widget.brokerModelList,on_click: (){
          //                 _controller.animateTo(2);
          //
          //
          //
          //
          //               },),
          //               Site_Visit_Tab(widget.brokerModelList),
          //               Inventory_Tab(widget.brokerModelList),
          //               My_Projects_Tab(widget.brokerModelList),
          //
          //
          //
          //
          //             ],
          //           )
          //       )
          //     ],
          //   ),
          // )
      ),
    );

  }

  void method() {
    _controller= TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );

  }







}
