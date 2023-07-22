


import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:peprop_consumer_app/Event/Event_Model.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import '../widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';

class Event_All_Banks extends StatefulWidget{
  late List<Bank_Model> builder_details;
  Event_All_Banks(List<Bank_Model> builder_details){
    this.builder_details=builder_details;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Event_All_Banks>{

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppUtils.appBarTitle(context, "All Builders"),
      body: Stack(
        children: [

          SingleChildScrollView(
            child: new Column(
              children: [
                GridView.builder(
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:widget.builder_details.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    height: 50.0,),
                  itemBuilder: (BuildContext context, int i) {
                    return new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl:widget.builder_details[i].bank_image.toString(),
                              errorWidget: (context, url, error) =>
                              new Container(height: 0,),
                            ),
                          ),)),
                        VerticalDivider(color: ColorFile.app_color,)
                      ],
                    );


                  },
                ),



              ],
            ),
          )

        ],
      ),
    );
  }







}