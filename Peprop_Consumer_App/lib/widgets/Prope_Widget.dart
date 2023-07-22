


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import '../Models/Apartments_Model.dart';
import '../Utils/AppUtils.dart';
import '../wish_list/Styles.dart';

class Prope_Widget extends StatelessWidget{
 late Apartments_Model apartments;
 String? message;

 int index=0;
 String? user_id;
  Prope_Widget(Apartments_Model apartments, String? message, int index, String? user_id){
    this.apartments=apartments;
    this.message=message;
    this.index=index;
    this.user_id=user_id;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Padding(padding: EdgeInsets.all(10),child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(message!=null&&index==0)new Container(margin: EdgeInsets.only(bottom: 10),child: No_Data_Placeholder_height(message.toString()),padding: EdgeInsets.all(10),decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10),
          color: ColorFile.app_color

        ),),

        Container(


            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(child: ClipRRect(
                  borderRadius: new BorderRadius.circular(0),

                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.png',
                    image: apartments.BannerImage,
                    width: MediaQuery.of(context).size.width/2,
                    fit: BoxFit.cover,
                    height: 150,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/placeholder.png",
                        width: MediaQuery.of(context).size.width/2,
                        fit: BoxFit.cover,
                        height: 100,

                      ); //do something
                    },
                  ),
                ),),
                Expanded(child:Container(
                  padding: EdgeInsets.only(left: 5,right: 5),child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    new Text(
                      apartments.PropertyTitle,
                      style: new TextStyle(fontFamily: "bold", fontSize: 18, color: ColorFile.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    new SizedBox(height: 5,),
                    new Text(
                      "By " + apartments.builder_name,
                      style: new TextStyle(
                          fontFamily: "medium",
                          fontSize: 12,
                          color: ColorFile.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    new SizedBox(height: 5,),
                    new Text(
                      apartments.Address,
                      style: new TextStyle(
                          fontFamily: "regular",
                          fontSize: 10,
                          color: ColorFile.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    new SizedBox(height: 5,),
                    apartments.priceList.length > 1
                        ? new Text(
                      apartments.priceList[0].CurrencyName +
                          " " +
                          apartments.priceList[0].unit_price +
                          " " +
                          apartments.priceList[0].name +
                          " - " +
                          apartments.priceList[apartments.priceList.length - 1]
                              .CurrencyName +
                          " " +
                          apartments.priceList[apartments.priceList.length - 1]
                              .unit_price +
                          " " +
                          apartments
                              .priceList[apartments.priceList.length - 1].name,
                      style: new TextStyle(
                          fontFamily: "bold",
                          fontSize: 18,
                          color: ColorFile.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                        : apartments.priceList.length == 1
                        ? new Text(
                      apartments.priceList[0].CurrencyName +
                          " " +
                          apartments.priceList[0].unit_price +
                          " " +
                          apartments.priceList[0].name,
                      style: new TextStyle(
                          fontFamily: "bold",
                          fontSize: 14,
                          color: ColorFile.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                        : new Container(),
                    new SizedBox(height: 5,),

                    AppUtils().method_extract(apartments,ColorFile.black),
                    new SizedBox(height: 5,),
                    
                    if(apartments.booking_option=="1"||apartments.booking_option=="2")new Container(margin: EdgeInsets.only(left: 10,right: 10),alignment: Alignment.center,child: new Text("Book Now",style: Styles().styles_regular(12, ColorFile.white),),height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.yellowdark),)

                    else if(apartments.booking_option!="1"&&apartments.booking_option!="2"&&apartments.property_save_later!=user_id)new Container(margin: EdgeInsets.only(left: 10,right: 10),alignment: Alignment.center,child: new Text("Book Site Visit",style: Styles().styles_regular(12, ColorFile.white),),height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.yellowdark),)

                  ],
                ),),)



              ],
            )),
        new SizedBox(height: 20,),
        new Container(child: new Row(),height: 2,color: ColorFile.bgs,)
      ],
    ),);
  }

}