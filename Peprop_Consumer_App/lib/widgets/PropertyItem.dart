import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Models/My_Booking_Models.dart';
import '../wish_list/Styles.dart';

class PropertyItem extends StatelessWidget {
  final My_Booking_Models? property;

  Function whole_click;
  Function claim_refund;
  Function booking_status;





   PropertyItem(this.property,{required this.whole_click,required this.claim_refund,required this.booking_status});

  @override
  Widget build(BuildContext context) {
    return

      InkWell(child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:new Column(
            children: [
              Container(
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

              ),
              new Container(
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.lightgray)),
                padding: EdgeInsets.all(10),
                child: new Column(
                  children: [
                    new Container(
                      child: new Row(
                        children: [
                          Expanded(child: new Container(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text("Order ID",style: Styles().styles_medium(16, ColorFile.black),),
                                new SizedBox(height: 5,),
                                new Text("ORD-"+property!.id.toString(),style: Styles().styles_regular(12, ColorFile.black),),



                              ],
                            ),
                          )),
                          Expanded(child: new Container(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text("Booked for",style: Styles().styles_medium(16, ColorFile.black),),
                                new SizedBox(height: 5,),
                                if(property!.list.length>0) new Text(property!.list[0].full_name.toString(),style: Styles().styles_regular(12, ColorFile.black),),



                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    new SizedBox(height: 15,),
                    new Container(
                      child: new Row(
                        children: [
                          Expanded(child: new Container(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text("Date of Booking",style: Styles().styles_medium(16, ColorFile.black),),



                              ],
                            ),
                          )),
                          Expanded(child: new Container(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(AppUtils.server_utc_date_parse(property!.booking_date),style: Styles().styles_regular(12, ColorFile.black),),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    new SizedBox(height: 10,),
                    new Container(
                      child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Container(child: new Text("Booking Amount : ",style: Styles().styles_medium(16, ColorFile.black),),),
                              new SizedBox(height: 10,),
                              new Container(child: new Text("₹ "+property!.booking_amount.toString(),style: Styles().styles_regular(12, ColorFile.black),),)




                            ],
                          ),)),
                          new Container(
                            child: new Column(
                              children: [
                               if(property!.refundable_status.toString()=="1"&&property!.refund_status.toString()=="null"&&property!.booking_option.toString()!="2") InkWell(child:new Container(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                  decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.app_color),
                                  child: new Text("  Claim Refund  ",style: Styles().styles_medium(12, ColorFile.white),),
                                ),onTap: (){
                                  claim_refund();
                                },),
                                new SizedBox(height: 10,),
                                InkWell(child: new Container(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                  decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.app_color),
                                  child: new Text("Booking Status",style: Styles().styles_medium(12, ColorFile.white),),
                                ),onTap: (){
                                  booking_status();
                                },),
                                new SizedBox(height: 10,),
                                InkWell(child: new Container(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                  decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(30),color: ColorFile.app_color),
                                  child: new Text("   View Details   ",style: Styles().styles_medium(12, ColorFile.white),),
                                ),onTap: (){
                                  whole_click();
                                },)
                              ],
                            ),
                          )



                        ],
                      ),
                    ),
                    new SizedBox(height: 10,),


                  ],
                ),
              )





            ],
          ),
        ),
      ),onTap: (){
        whole_click();

      },);
  }
}