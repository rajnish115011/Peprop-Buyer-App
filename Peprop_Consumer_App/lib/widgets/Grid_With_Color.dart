


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Apartments_Model.dart';

import '../Properties/Properties_Detail.dart';
import 'Prope_Widget.dart';

class Grid_With_Color extends StatelessWidget{
  List<Apartments_Model> apartments=[];
  String? message;
  String? user_id;
  Grid_With_Color(List<Apartments_Model> apartments, String? message, String user_id){
    this.apartments=apartments;
    this.message=message;
    this.user_id=user_id;



  }

  @override
  Widget build(BuildContext context) {

   return
     Container(
       padding: EdgeInsets.all(5),




       child: ListView.builder(
         shrinkWrap: true,


         itemCount: apartments.length,
         itemBuilder: (BuildContext context, int index) {
           return InkWell(child: Prope_Widget(apartments[index],message,index,user_id),onTap: (){
             var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(apartments[index].ID,"")));

           },);
         },
       ),
     );
  }

}