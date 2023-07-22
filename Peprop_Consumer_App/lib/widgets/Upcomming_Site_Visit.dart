


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Site_Visit/My_Site_Visit_Model.dart';

import '../Site_Visit/Reschedule_Site_Visit.dart';
import '../Site_Visit/Widget_Site_Visit.dart';

class Upcomming_Site_Visit extends StatelessWidget{
  List<My_Site_Visit_Model> sitevisitModel=[];

  Function(int) accept;
  Function(int) reject;
  Function() reschedule;
  String name="";
  String user_id="";
  Upcomming_Site_Visit(List<My_Site_Visit_Model> sitevisitModel, String name, String user_id,{required this.accept,required this.reject,required this.reschedule}){
    this.sitevisitModel=sitevisitModel;
    this.name=name;
    this.user_id=user_id;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if(sitevisitModel.length>0)
           Padding(
          padding: EdgeInsets.only( right: 8, left: 5),
          child: Text(
            'Upcoming Site Visits',
            style: TextStyle(
              fontFamily: 'bold',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
           ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: sitevisitModel.length,
            itemBuilder: (context, index) {
              return  Widget_Site_Visit(sitevisitModel[index],name,user_id,accept: (){
                accept(index);
                // acceptRejectSitevisits("1");

              },reject: (){
                reject(index);
                // acceptRejectSitevisits("2");
              },reschedule: () async {
                var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Reschedule_Site_Visit(sitevisitModel[index],null)));
                if(response!=null)
                {
                 reschedule();

                }
              },);


            }),

      ],
    );
  }

}