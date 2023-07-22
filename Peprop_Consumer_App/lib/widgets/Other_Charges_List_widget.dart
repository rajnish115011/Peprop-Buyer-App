

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Book_Now/Booking/Extra_charges_details.dart';
import '../Color/ColorFile.dart';
import '../Models/Tower_Model.dart';
import 'All_Miles.dart';
import 'MS_Card.dart';

class Other_Charges_List_widget extends StatelessWidget{

  List<Other_charges_details>other_charges_details=[];
  Other_Charges_List_widget(List<Other_charges_details>other_charges_details){
    this.other_charges_details=other_charges_details;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        if(other_charges_details.length>0)new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new SizedBox(height: 20,),
            if(other_charges_details.length>0)new Container(height: 40,color: ColorFile.app_color,child: new Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [new Text("Other Charges",style: new TextStyle(fontFamily: "medium",fontSize: 17,color: ColorFile.white),),],)),

            new Container(
              child:  ListView.builder(
                itemCount: other_charges_details.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  return new Container(
                    margin: EdgeInsets.only(top: index==0?0:10),
                    decoration: new BoxDecoration(border: new Border.all(width: 1,color: ColorFile.black)),
                    child: new Column(
                      children: [


                          new Container(height: 40,color: ColorFile.bgs,child: new Row(children: [
                          Expanded(child: new Container(alignment: Alignment.center,child: new Text("Type",style: Styles().styles_bold(13, ColorFile.black),),)),
                          new Container(height: 40,width: 1,color: ColorFile.black,),
                          Expanded(child: new Container(alignment: Alignment.center,child: new Text("Charge",style: Styles().styles_bold(13, ColorFile.black),),)),



                        ],),),
                        new Container(child: new Row(children: [],),height: 1,color: ColorFile.hint_color,),

                        new Container(child: new Row(children: [],),height: 1,color: ColorFile.hint_color,),
                        new Container(child: new Row(children: [
                          Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text(other_charges_details[index].charge_title.toString(),style: Styles().styles_medium(13, ColorFile.black),),)),



                          new Container(height: 40,width: 1,color: ColorFile.black,),
                          Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text(" ₹ "+other_charges_details[index].charge_amount.toString()+" ("+other_charges_details[index].charge_unit.toString()+")",style: Styles().styles_medium(13, ColorFile.black),),)),



                        ],),)




                      ],
                    ),);



                },

              ),
            ),
          ],
        ),
      ],
    );
  }

}

class Payment_Miles extends StatelessWidget{

  List<Payment_milestones>other_charges_details=[];
  Payment_Miles(List<Payment_milestones>other_charges_details){
    this.other_charges_details=other_charges_details;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        if(other_charges_details.length>0)new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(child: new Text("MileStones details",style: new TextStyle(fontFamily: "medium",fontSize: 17),),),
            new SizedBox(height: 10,),
            new Container(
              child:  ListView.builder(
                itemCount: other_charges_details.length>2?2:other_charges_details.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MS_Card(other_charges_details[index],index);




                },

              ),
            ),
            new SizedBox(height: 10,),
            InkWell(child: new Container(margin: EdgeInsets.only(right: 20,bottom: 20),child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Text("View All",style: new TextStyle(fontFamily: "medium",fontSize: 17,color: ColorFile.app_color),)



              ],
            ),),onTap: (){
              var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => All_Miles(other_charges_details)));


            },)
          ],
        ),
      ],
    );
  }

}



class Aminities_Charges_List_widget extends StatelessWidget{

  List<AmenitiesPrice_details>aminities_charges_details=[];
  Aminities_Charges_List_widget(List<AmenitiesPrice_details>aminities_charges_details){
    this.aminities_charges_details=aminities_charges_details;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        if(aminities_charges_details.length>0)new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new SizedBox(height: 20,),
            if(aminities_charges_details.length>0)new Container(height: 40,color: ColorFile.app_color,child: new Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [new Text("Amenities Charges",style: new TextStyle(fontFamily: "medium",fontSize: 17,color: ColorFile.white),),],)),
            new Container(
              child:  ListView.builder(
                itemCount: aminities_charges_details.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  return new Container(
                    margin: EdgeInsets.only(top: index==0?0:10),
                    decoration: new BoxDecoration(border: new Border.all(width: 1,color: ColorFile.black)),
                    child: new Column(
                      children: [
                        new Container(child: new Row(
                          children: [
                            Expanded(child: new Container(color: ColorFile.lightgray,padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),alignment: Alignment.center,child: new Text(aminities_charges_details[index].name.toString(),style: Styles().styles_medium(15, ColorFile.black),),))
                          ],
                        ),),

                        new Container(height: 40,color: ColorFile.bgs,child: new Row(children: [
                          Expanded(child: new Container(alignment: Alignment.center,child: new Text("Type",style: Styles().styles_bold(13, ColorFile.black),),)),
                          new Container(height: 40,width: 1,color: ColorFile.black,),
                          Expanded(child: new Container(alignment: Alignment.center,child: new Text("Charge",style: Styles().styles_bold(13, ColorFile.black),),)),



                        ],),),
                        new Container(child: new Row(children: [],),height: 1,color: ColorFile.hint_color,),

                        new Container(child: new Row(children: [],),height: 1,color: ColorFile.hint_color,),
                        new Container(child: new Row(children: [
                        Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text(aminities_charges_details[index].is_chargable.toString()=="0"?"FOC":"Chargable",style: Styles().styles_medium(13, ColorFile.black),),)),
                          new Container(height: 40,width: 1,color: ColorFile.black,),
                          if(aminities_charges_details[index].is_chargable.toString()=="0")Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text("Included",style: Styles().styles_medium(13, ColorFile.black),),)),
                          if(aminities_charges_details[index].is_chargable.toString()!="0")Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text(" ₹ "+aminities_charges_details[index].total_amount.toString()+" ("+aminities_charges_details[index].charge_unit.toString()+")",style: Styles().styles_medium(13, ColorFile.black),),)),



                        ],),)




                      ],
                    ),);
                  return Card(
                    margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          new Container(child: new Text(aminities_charges_details[index].name.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 16,color: ColorFile.selectd_color),),),
                          new SizedBox(height: 10,),
                          new Container(child: new Text(aminities_charges_details[index].is_chargable.toString()=="0"?"Included":"Chargable",style: new TextStyle(fontFamily: "regular",fontSize: 14,color: ColorFile.hint_color),),),
                          new SizedBox(height: 10,),

                          if(double.parse(aminities_charges_details[index].total_amount.toString())>0) new Container(child: new Text("Charges: ₹"+aminities_charges_details[index].total_amount.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.hint_color),),),
                          if(double.parse(aminities_charges_details[index].total_amount.toString())>0) new SizedBox(height: 10,),



                        ],),

                    ),
                  );


                },

              ),
            ),
          ],
        ),
      ],
    );
  }

}