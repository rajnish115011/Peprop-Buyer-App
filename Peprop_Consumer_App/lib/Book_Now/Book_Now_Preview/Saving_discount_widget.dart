



import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Online_Model.dart';
import 'package:peprop_consumer_app/Models/Tower_Model.dart';
import 'package:peprop_consumer_app/Properties/View_Property_Model.dart';

import '../../Color/ColorFile.dart';
import '../../Utils/AppUtils.dart';
import '../../wish_list/Styles.dart';

class Saving_discount_widget extends StatelessWidget{
  Online_Model? online_model;
  View_Property_Model? view_property_model;
  Book_Now_all_Tower_Model? unit_no_list;
  Saving_discount_widget(Online_Model? online_model, View_Property_Model? view_property_model, Book_Now_all_Tower_Model? unit_no_list){
    this.online_model=online_model;
    this.view_property_model=view_property_model;
    this.unit_no_list=unit_no_list;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(child: new Column(
      children: [
        new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),

          child: new Row(
            children: [
              new Row(
                children: [

                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Row(children: [
                new Text("Total Amount",style:Styles().styles_bold(13, ColorFile.hint_color)),

              ],),)),

              new Container(child: new Text("₹ "+AppUtils().total_amt(unit_no_list!.total_unit_price.toString(),unit_no_list),style:Styles().styles_bold(16, ColorFile.hint_color)),),




            ],
          ),),
        if(view_property_model!.builder_visibility=="0"||view_property_model!.builder_visibility=="1"||view_property_model!.broker_visibility=="0"||view_property_model!.broker_visibility=="1")new Container(
          height: 45,
          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
          padding: EdgeInsets.only(right: 10),
          color: ColorFile.selectd_color,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text("Discount & Savings",style: Styles().styles_bold(14, ColorFile.white),)



            ],
          ),),
       //0>show,1>show
       if(view_property_model!.builder_visibility=="0"||view_property_model!.builder_visibility=="1") new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.only(right: 10),
         decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),

         child: new Row(
            children: [
              new Row(
                children: [

                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Row(children: [
                new Text("From Developer"+((view_property_model!.builder_visibility=="0"?"(Discount)":"(Saving)")),style:Styles().styles_bold(13, ColorFile.hint_color)),

              ],),)),

              new Container(child: new Text("₹ "+AppUtils().price(view_property_model!.discount_value.toString()),style:Styles().styles_bold(16, ColorFile.hint_color)),),



            ],
          ),),
        //0>show,1>show
        if(view_property_model!.broker_visibility=="0"||view_property_model!.broker_visibility=="1") new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),

          child: new Row(
            children: [
              new Row(
                children: [
                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Row(children: [
                new Text("From Broker"+((view_property_model!.builder_visibility=="0"?"(Discount)":"(Benefit)")),style:Styles().styles_bold(13, ColorFile.hint_color)),

              ],),)),

              new Container(child: new Text("₹ "+AppUtils().price(view_property_model!.broker_discount_value.toString()),style:Styles().styles_bold(16, ColorFile.hint_color)),),



            ],
          ),),

          if(AppUtils().total_discount(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString())!="0")new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),

          child: new Row(
            children: [
              new Row(
                children: [

                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Text("Your Total Saving\non this booking is",style:Styles().styles_bold(13, ColorFile.hint_color)),)),

              new Container(child: new Text("₹ "+AppUtils().total_discount(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString()),style:Styles().styles_bold(16, ColorFile.hint_color)),),



            ],
          ),),





        if(view_property_model!.cashback_visibility=="0"||view_property_model!.cashback_visibility=="1")

          new Container(
          height: 45,
          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
          padding: EdgeInsets.only(right: 10),
          color: ColorFile.selectd_color,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(view_property_model!.cashback_visibility=="0"?"Cashback":"Benefits",style: Styles().styles_bold(14, ColorFile.white),)



            ],
          ),),
        if(view_property_model!.cashback_value.toString()!=""&&view_property_model!.cashback_value.toString()!="0")new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),
          child: new Row(
            children: [
              new Row(
                children: [

                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Row(children: [
                new Text("Benefits*",style:Styles().styles_bold(13, ColorFile.hint_color)),

              ],),)),
              new Container(child: new Text("₹ "+view_property_model!.cashback_value.toString(),style:Styles().styles_bold(16, ColorFile.hint_color)),),

            ],
          ),),
       if(AppUtils().total_saving(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString(),view_property_model!.cashback_value.toString())!="0"&&AppUtils().total_saving(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString(),view_property_model!.cashback_value.toString())!="")

         new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),
          child: new Row(
            children: [
              new Row(
                children: [

                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Row(children: [
                new Text("Your total benifits on this booking is",style:Styles().styles_bold(13, ColorFile.hint_color)),

              ],),)),

              new Container(child: new Text("₹ "+AppUtils().total_saving(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString(),view_property_model!.cashback_value.toString()),style:Styles().styles_bold(16, ColorFile.hint_color)),),




            ],
          ),),
        if(AppUtils().total_saving(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString(),view_property_model!.cashback_value.toString())!="0"&&AppUtils().total_saving(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString(),view_property_model!.cashback_value.toString())!="")

          new Container(child: new Row(
          children: [
            new Text("*  Cashback on Booking amount after BBA.",style:Styles().styles_bold(13, ColorFile.hint_color)),

          ],
        ),margin: EdgeInsets.only(left: 20,right: 20,top: 20),),


        new Container(
          height: 60,
          margin: EdgeInsets.only(left: 20,right: 20,top: 30),
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.banking_heading,),
          child: new Row(
            children: [
              new Row(
                children: [

                  new SizedBox(width: 5,),
                  Icon(Icons.check_circle_rounded,size: 20,color: ColorFile.yellow_900,),
                  new SizedBox(width: 10,),

                ],
              ),
              Expanded(child: new Container(child:new Row(children: [
                new Text("Approx. Amount Payable",style:Styles().styles_bold(13, ColorFile.hint_color)),

              ],),)),
              new Container(child: new Text("₹ "+AppUtils().net_pay(view_property_model!.discount_value.toString(),view_property_model!.broker_discount_value.toString(),view_property_model!.cashback_value.toString(),unit_no_list!.total_unit_price.toString(),unit_no_list),style:Styles().styles_bold(16, ColorFile.hint_color)),),




            ],
          ),),
        new Container(child: new Row(
          children: [
            new Text("( Applicable taxes & other charges extra)",style:Styles().styles_bold(13, ColorFile.hint_color)),

          ],
        ),margin: EdgeInsets.only(left: 20,right: 20,top: 20),),
      ],
    ),);
  }

}