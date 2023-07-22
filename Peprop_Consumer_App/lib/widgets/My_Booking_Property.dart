import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';

import '../Color/ColorFile.dart';
import '../Properties/Properties_Detail.dart';
import '../wish_list/Styles.dart';
import 'Form_Title.dart';

class My_Booking_Property extends StatelessWidget{
  My_Booking_Models? property;
  Function on_click;

  My_Booking_Property(My_Booking_Models? property,{required this.on_click}){
    this.property=property;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(child: Container(
              height: 220,
              margin: EdgeInsets.only(bottom: 10),
              child:new Stack(
                children: [
                  ClipRRect(
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.png',
                      image:API.property_image+property!.FeaturedImage.toString(),
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/placeholder.png",
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ); //do something
                      },
                    ),
                  ),
                  new Container(padding: EdgeInsets.all(10),child:new Row(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child:
                          new Container(
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(100),
                                color: ColorFile.white
                            ),
                            child:
                            ClipRRect(child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.png',
                              image:API.builde_logo+property!.logo.toString(),
                              width:70,
                              height: 70,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/placeholder.png",
                                    width: 70,
                                    fit: BoxFit.cover,
                                    height: 70);//do something
                              },
                            ),  borderRadius: new BorderRadius.circular(100),),
                          )
                      ),
                      Expanded(child: new Container(
                        alignment: Alignment.topRight,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset("assets/booked_stamp.png",height: 50,color: ColorFile.white,)

                          ],
                        ),))


                    ],
                  )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10) ),
                            color: ColorFile.hexblack
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        height: 85,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: new Container(child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new SizedBox(height: 10,),
                                new Container(child:new Text(property!.PropertyTitle,style: new TextStyle(fontFamily: "medium",fontSize: 14,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                                new SizedBox(height: 5,),
                                new Container(child:new Text("by "+property!.builder_name,style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                                new SizedBox(height: 5,),
                                new Container(child:new Text(property!.address+","+property!.state_name+"-"+property!.country_name,style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.white),maxLines: 1,overflow: TextOverflow.ellipsis,),)

                              ],
                            ),)),

                          ],
                        )


                    ),
                  ),

                ],
              )

          ),onTap: (){

            on_click();

          },)
        ],
      ),
    );
  }

}

class My_Booking_inv extends StatelessWidget{
  My_Booking_Models? list;
  My_Booking_inv(My_Booking_Models? list){
    this.list=list;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
          border: new Border.all(width: 1,color: ColorFile.lightgray)

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form_Title("Tower Name","Unit Type/Name"),
          new SizedBox(height: 5,),
          Form_Title_content(list!.tower_name.toString().toUpperCase(),list!.unit_type.toString()+" ("+list!.unit_name_number.toString()+")"),
          new SizedBox(height: 10,),


          Form_Title("Floor No","Payment Plan"),
          new SizedBox(height: 5,),
          Form_Title_content(list!.floor_no.toString().toUpperCase(),list!.plan_name.toString()),
          new SizedBox(height: 10,),

        ],
      ),
    );
  }

}