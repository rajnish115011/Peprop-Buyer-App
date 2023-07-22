


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Tower_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import 'MS_Card.dart';

class All_Miles extends StatefulWidget{
  List<Payment_milestones> other_charges_details=[];
  All_Miles(List<Payment_milestones> other_charges_details){
    this.other_charges_details=other_charges_details;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_States();
  }

}
class Build_States extends State<All_Miles>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "All Milestones"),
      body: new SingleChildScrollView(
      child: new Column(
        children: [
          new Container(
            child:  ListView.builder(
              itemCount:widget.other_charges_details.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MS_Card(widget.other_charges_details[index],index);




              },

            ),
          ),
        ],
      ),
    ),);
  }

}