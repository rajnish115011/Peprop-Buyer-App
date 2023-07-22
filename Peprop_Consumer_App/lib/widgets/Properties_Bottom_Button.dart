

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../Color/ColorFile.dart';
import '../Properties/Properties_Detail.dart';
import '../wish_list/Styles.dart';

class Properties_Bottom_Button extends StatelessWidget{
  List<Apartments_Model> apartments=[];
  late Color selected_color;
  int selected_index=0;
  String user_id="";
  Properties_Bottom_Button(List<Apartments_Model> apartments, int selected_index, Color selected_color, String user_id){
    this.apartments=apartments;
    this.selected_index=selected_index;
    this.selected_color=selected_color;
    this.user_id=user_id;

  }

  @override
  Widget build(BuildContext context) {

    return new Container(child: InkWell(
      onTap: (){
        var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(apartments[selected_index].ID,"")));

      },

      child: new Column(
        children: [
          if(apartments[selected_index].information_only_status=="1")show_site_visit(),
          if(apartments[selected_index].information_only_status=="0")show_booking(),


        ],
      ),),height: 60,);


  }

  Widget show_site_visit() {

    return new Column(
      children: [
        if(apartments[selected_index].property_save_later!=user_id)new Container(
        color:selected_color.withOpacity(.9),
    height: 60,child: new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    new Text("Book Site Visit",style: Styles().styles_medium(14, ColorFile.white),)

    ],
    )),
        if(apartments[selected_index].property_save_later==user_id)new Container(
            color:selected_color.withOpacity(.9),
            height: 60,child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Text("View Details",style: Styles().styles_medium(14, ColorFile.white),)

          ],
        ))
      ],
    );






  }

  Widget show_booking() {

   return new Container(
        color:selected_color.withOpacity(.9),
        height: 60,child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(apartments[selected_index].property_save_later!=user_id) Expanded(child: new Container(alignment: Alignment.center,child: new Text("Book Site Visit",style: Styles().styles_medium(14, ColorFile.white),),)),
        if(apartments[selected_index].property_save_later!=user_id)new Container(height: 60,width: 1,color: ColorFile.white,),
        if(apartments[selected_index].booking_option=="1"||apartments[selected_index].booking_option=="2") Expanded(child: new Container(alignment: Alignment.center,child: new Text("Book Now",style: Styles().styles_medium(14, ColorFile.white),),)),
        if(apartments[selected_index].booking_option!="1"&&apartments[selected_index].booking_option!="2") Expanded(child: new Container(alignment: Alignment.center,child: new Text("View Details",style: Styles().styles_medium(14, ColorFile.white),),))

      ],
    ));


  }
  
}