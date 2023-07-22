


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Book_Now/Milestone_Payment/MileStone_Payment_Options.dart';
import 'package:peprop_consumer_app/Book_Now/Milestone_Payment/View_Payment_Details.dart';
import 'package:peprop_consumer_app/Models/MileStone_Payment_Model.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';
import 'MyVerticalText.dart';

class Mile_Stone_Widget extends StatelessWidget{
  List<MileStone_Payment_Model> mile_stone=[];
  int payment=-1;
  My_Booking_Models? booking_details;
  Mile_Stone_Widget(List<MileStone_Payment_Model> mile_stone, My_Booking_Models? booking_details){
    this.mile_stone=mile_stone;
    this.booking_details=booking_details;

  }

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
      padding: EdgeInsets.all(5),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mile_stone.length,
      itemBuilder: (BuildContext context, int index) {
        if(mile_stone[index].paid_status.toString()=="0"&&payment==-1){
          payment=index;
        }
        return
          Container(
          margin: EdgeInsets.only(top: 15),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            border: Border.all(
                color: ColorFile.green, width: 0.5),
            color: ColorFile.green,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: new MyVerticalText("MileStone "+(index+1).toString()),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),),
                  Expanded(
                  child: new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)), color: ColorFile.white),
                    padding: EdgeInsets.only(top: 0),
                    child: new Column(
                      children: [
                        new Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10,top: 10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Image.asset(
                                "assets/clock.png",
                                width: 12,
                                height: 12,
                                fit: BoxFit.cover,
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Text(
                                AppUtils().yyyy_mm_dd_to_dd_mm_yyyy(mile_stone[index].after_date.toString()),
                                style: new TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 13,
                                    color: ColorFile.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        new SizedBox(
                          height: 15,
                        ),
                        new SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Table(border: TableBorder.all(borderRadius:BorderRadius.only(bottomRight: Radius.circular(10)), color: ColorFile.green, width: 0.3),
                            children: [
                              TableRow(children: [
                                Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Milestone",style: Styles().styles_medium(15, ColorFile.black),)),
                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(mile_stone[index].milestone_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                              ]),
                              TableRow(children: [
                                Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Milestone Stage",style: Styles().styles_medium(15, ColorFile.black),)),
                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(mile_stone[index].stage.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                              ]),
                              TableRow(children: [
                                Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Payment Plan",style: Styles().styles_medium(15, ColorFile.black),)),
                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(mile_stone[index].payment_plan_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                              ]),
                              if(mile_stone[index].gst_amount.toString()!="0")

                                TableRow(children: [
                                Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Gst Amount",style: Styles().styles_medium(15, ColorFile.black),)),
                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(mile_stone[index].gst_amount.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                              ]),

                              if(mile_stone[index].milestone_emi_amount.toString()!="0")

                                TableRow(children: [
                                  Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Net Amount",style: Styles().styles_medium(15, ColorFile.black),)),
                                  Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+mile_stone[index].milestone_emi_amount.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                ]),

                              if(mile_stone[index].milestone_paid_amounts.toString()!="0")TableRow(children: [
                                  Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Amount Paid",style: Styles().styles_medium(15, ColorFile.black),)),
                                  Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+mile_stone[index].milestone_paid_amounts.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                ]),

                              if(mile_stone[index].milestone_net_due_amount.toString()!="0")TableRow(children: [
                                Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Pending Amount",style: Styles().styles_medium(15, ColorFile.black),)),
                                Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+mile_stone[index].milestone_net_due_amount.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                              ]),












                            ],
                          ),
                        ),

                          new Container(child: new Table(
                          children: [
                            TableRow(children: [
                                if(mile_stone[index].paid_status.toString()=="0"&&payment==index)
                                InkWell(onTap: (){
                                    var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => MileStone_Payment_Options(mile_stone[index],booking_details)));
                                  },child: Card(
                                    color: ColorFile.greens,
                                    child:new Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      child:  Text(
                                        "Pay Now",
                                        style:Styles().styles_regular(12, ColorFile.white),
                                      ),
                                    ),
                                  ),),
                                InkWell(child: Container(child: Card(
                                  color: ColorFile.app_color,
                                  child:new Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    child:  Text(
                                      "View Details",
                                      style:Styles().styles_regular(12, ColorFile.white),
                                    ),
                                  ),
                                ),),onTap: (){
                                  var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => View_Payment_Details(mile_stone[index])));



                                },),
                               InkWell(
                                 child:  Container(child: Card(
                                   color: ColorFile.red_900,
                                   child:new Container(
                                     alignment: Alignment.center,
                                     height: 40,
                                     child:  Text(
                                       "Download",
                                       style:Styles().styles_regular(12, ColorFile.white),
                                     ),
                                   ),
                                 ),),
                                 onTap: (){
                                   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => View_Payment_Details(mile_stone[index])));

                                 },
                               )

                            ]),
                          ],
                        ),)



                      ],
                    ),
                  ))
            ],
          ),
        );



      },
    );
  }



}