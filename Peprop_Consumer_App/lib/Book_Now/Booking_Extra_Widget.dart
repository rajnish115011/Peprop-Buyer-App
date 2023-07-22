




import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Tower_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../Requirements/Widget_Extra_Charges_Details.dart';
import '../widgets/Other_Charges_List_widget.dart';

class Booking_Extra_Widget extends StatelessWidget{
  List<Book_Now_all_Tower_Model> unit_no_list=[];
  String type="";

  Function (int,int) add_qty;
  Booking_Extra_Widget(String type, List<Book_Now_all_Tower_Model> unit_no_list,{required this.add_qty}){
    this.type=type;
    this.unit_no_list=unit_no_list;
    this.add_qty=add_qty;



  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: unit_no_list.length,
          itemBuilder: (BuildContext context, int index) {

            return new Column(
              children: [
                if(type.toString().toLowerCase().trim()!="virtual space") Widget_Extra_Charges_Details(unit_no_list[index].extra_charges_details,true,on_click: (int){
                   add_qty(int,index);
                   },),
                if(type.toString().toLowerCase().trim()!="virtual space") Other_Charges_List_widget(unit_no_list[index].other_charges_details),
                if(type.toString().toLowerCase().trim()!="virtual space") Aminities_Charges_List_widget(unit_no_list[index].aminities_charges_details),

              ],
            );


          },
        ),



      ],
    );
  }

}