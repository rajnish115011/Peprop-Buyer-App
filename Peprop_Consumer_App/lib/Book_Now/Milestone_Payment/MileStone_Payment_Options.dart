



import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/MileStone_Payment_Model.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/Models/Tower_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/Other_Charges_List_widget.dart';

import '../../Color/ColorFile.dart';

import '../../Terms_and_Conditions/Payment_tnc.dart';
import '../../wish_list/Styles.dart';
import 'Pay_Milestones.dart';

class MileStone_Payment_Options extends StatefulWidget{

  late MileStone_Payment_Model model;
  My_Booking_Models? booking_details;
  MileStone_Payment_Options(MileStone_Payment_Model model, My_Booking_Models? booking_details){
    this.model=model;
    this.booking_details=booking_details;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<MileStone_Payment_Options>{
  bool peprop_terms=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBarTitle(context, "Payment"),
      body: new SingleChildScrollView(
        child:Padding(child: new Column(
          children: [
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
                                  new Text(AppUtils().yyyy_mm_dd_to_dd_mm_yyyy(widget.model.after_date.toString()),
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
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(widget.model.milestone_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),
                                  TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Milestone Stage",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(widget.model.stage.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),
                                  TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Payment Plan",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text(widget.model.payment_plan_name.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),
                                  if(widget.model.gst_amount.toString()!="0")TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Gst Amount",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+widget.model.gst_amount.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),
                                  if(widget.model.penalty_on_due.toString()!="0")TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Penality Amount",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+widget.model.penalty_on_due.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),


                                  if(widget.model.interest_on_due.toString()!="0")TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Interst Amount",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+widget.model.interest_on_due.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),

                                  if(widget.model.bounce_charge.toString()!="0")TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Bounce Charge",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+widget.model.bounce_charge.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),
                                  if(widget.model.other_charges.toString()!="0")TableRow(children: [
                                    Container(color: Colors.black12,padding: EdgeInsets.all(8.0),child: Text("Other Charges",style: Styles().styles_medium(15, ColorFile.black),)),
                                    Container(padding: EdgeInsets.all(8.0),child: Center(child: Text("₹"+widget.model.other_charges.toString(),style: Styles().styles_regular(15, ColorFile.black))),),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      color: Colors.green.shade100,
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Total Amount to be Paid",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.green.shade100,
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                            "₹"+widget.model.milestone_net_due_amount.toString()+"\n",
                                            style: TextStyle(fontSize: 15.0),
                                          )),
                                    ),
                                  ]),


                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            new SizedBox(height: 20,),
            new Container(child:  new Row(
              children: [

                new SizedBox(width: 10,),
                new InkWell(child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    peprop_terms==true?Icon(Icons.check_box,color: ColorFile.app_color,):Icon(Icons.check_box_outline_blank),
                    new SizedBox(width: 10,),
                    new Container(child:new Text("I accept Terms & Conditions of Peprop.Money",style: new TextStyle(fontFamily: "medium",fontSize: 12,color: ColorFile.app_color,decoration: TextDecoration.underline),))

                  ],
                ),onTap: () async {
                  var nav=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Payment_tnc(peprop_terms)));


                  if(nav!=null){
                    setState(() {
                      peprop_terms=nav;
                    });


                  }




                },)
              ],
            ))

          ],
        ),padding: EdgeInsets.all(10),),
      ),
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(10),
        color: ColorFile.white,
        height: 100,
        child: new Row(
          children: [
            Expanded(child: new Container(child:new Text("₹ "+widget.model.milestone_net_due_amount.toString(),style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.selectd_color),),)),
            InkWell(onTap: () async {
              if(peprop_terms==true){

                var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pay_Milestones(widget.model,widget.booking_details)));

              }else{
                AppUtils.toAst("Please Aceept terms & Conditions..!!", context);
              }

            },child: new Container(alignment: Alignment.center,height: 45,padding: EdgeInsets.only(left: 15,right: 15),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.yellowdark),child: new Text("Continue",style: new TextStyle(fontFamily: "medium",color: ColorFile.black,fontSize: 15),),),)


          ],
        ),
      ),
    );
  }

}