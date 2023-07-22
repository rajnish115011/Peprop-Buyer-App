


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/All_transactions_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class All_transaction_Widget extends StatelessWidget{

 late All_transactions_Model list;
  All_transaction_Widget(All_transactions_Model list){
    this.list=list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(list.tras_type.toLowerCase()=="credit"||list.tras_type.toLowerCase()=="debit") return new Container(child: Column(
      children: [
        new Container(child: new Row(
          children: [
            new Container(height: 60,width: 60,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.bgs)),child:ClipRRect(child: new Image.asset("assets/pelogo.png",height: 35,),borderRadius: new BorderRadius.circular(100),),padding: EdgeInsets.all(2),),
            new SizedBox(width: 20,),
            Expanded(child: new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(list.tras_type=="Credit")new Text("Credited",style: Styles().styles_medium(12, ColorFile.black),)
                else if(list.tras_type=="Debit")new Text("Paid to "+list.name.toString(),style: Styles().styles_medium(12, ColorFile.black),)
                else new Text("Paid to "+list.name.toString(),style: Styles().styles_medium(12, ColorFile.black),),



                new SizedBox(height: 3,),
                new Text("₹ "+list.amount.toString(),style: Styles().styles_medium(14, ColorFile.greens),),

                if(list.paymentThrough.toString()!="")new SizedBox(height: 3,),
                if(list.paymentThrough.toString()!="")new Text("Payment Through : "+list.paymentThrough.toString(),style: Styles().styles_medium(14, ColorFile.greens),),

                new SizedBox(height: 3,),
                if(list.status=="0")new Text("Payment Pending",style: Styles().styles_medium(14, ColorFile.app_color),),
                if(list.status=="1")new Text("Payment Success",style: Styles().styles_medium(14, ColorFile.greens),),
                if(list.status=="2")new Text("Payment Failed",style: Styles().styles_medium(14, ColorFile.red_900),),


              ],
            ),))

          ],
        ),),
        new SizedBox(height: 10,),
        new Container(child: new Row(
          children: [
            Expanded(child: new Container(
              alignment: Alignment.centerRight,
              child: new Text(AppUtils.server_utc_date_parse(list.created_at.toString()),style: Styles().styles_medium(10, ColorFile.hint_color),),)),

          ],
        ),),
        new SizedBox(height: 20,),
        new Container(child:new Row(children: [],),height: 1,color: ColorFile.light_background,)

      ],
    ),margin: EdgeInsets.only(top: 20),);


    else if(list.tras_type.toLowerCase()=="booknow") return new Container(child: Column(
      children: [
        new Container(child: new Row(
          children: [
            new Container(height: 60,width: 60,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.bgs)),child: ClipRRect(child: new Image.asset("assets/pelogo.png",height: 35,),borderRadius: new BorderRadius.circular(100),),padding: EdgeInsets.all(2),),
            new SizedBox(width: 20,),
            Expanded(child: new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text("Paid to "+list.full_name.toString(),style: Styles().styles_medium(12, ColorFile.black),),
                new SizedBox(height: 3,),
                new Text("₹ "+list.payment_made.toString(),style: Styles().styles_medium(14, ColorFile.greens),),
                new SizedBox(height: 3,),
                if(list.status=="0")new Text("Payment Pending",style: Styles().styles_medium(14, ColorFile.app_color),),

                if(list.status=="1")new Text("Payment Success",style: Styles().styles_medium(14, ColorFile.greens),),

                if(list.status=="2")new Text("Payment Failed",style: Styles().styles_medium(14, ColorFile.red_900),),

              ],
            ),))

          ],
        ),),
        new SizedBox(height: 10,),
        new Container(child: new Row(
          children: [
            Expanded(child: new Container(
              alignment: Alignment.centerRight,
              child: new Text(AppUtils.server_utc_date_parse(list.created_at.toString()),style: Styles().styles_medium(10, ColorFile.hint_color),),)),
          ],
        ),),
        new SizedBox(height: 20,),
        new Container(child:new Row(children: [],),height: 1,color: ColorFile.light_background,)

      ],
    ),margin: EdgeInsets.only(top: 20),);
    else  return new Container(child: Column(
      children: [
        new Container(child: new Row(
          children: [
            new Container(height: 60,width: 60,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.bgs)),child: ClipRRect(child: new Image.asset("assets/pelogo.png",height: 35,),borderRadius: new BorderRadius.circular(100),),padding: EdgeInsets.all(2),),
            new SizedBox(width: 20,),
            Expanded(child: new Container(child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(list.tras_type=="Credit")new Text("Credited",style: Styles().styles_medium(12, ColorFile.black),)
                else if(list.tras_type=="Debit")new Text("Paid to "+list.name.toString(),style: Styles().styles_medium(12, ColorFile.black),)
                else new Text("Paid to "+list.name.toString(),style: Styles().styles_medium(12, ColorFile.black),),
                new SizedBox(height: 3,),
                new Text("₹ "+list.amount.toString(),style: Styles().styles_medium(14, ColorFile.greens),),
                new SizedBox(height: 3,),
                if(list.status=="0")new Text("Payment Pending",style: Styles().styles_medium(14, ColorFile.app_color),),

                if(list.status=="1")new Text("Payment Success",style: Styles().styles_medium(14, ColorFile.greens),),
                if(list.status=="2")new Text("Payment Failed",style: Styles().styles_medium(14, ColorFile.red_900),),

              ],
            ),))




          ],
        ),),
        new SizedBox(height: 10,),
        new Container(child: new Row(
          children: [
            Expanded(child: new Container(
              alignment: Alignment.centerRight,
              child: new Text(AppUtils.server_utc_date_parse(list.created_at.toString()),style: Styles().styles_medium(10, ColorFile.hint_color),),)),
          ],
        ),),
        new SizedBox(height: 20,),
        new Container(child:new Row(children: [],),height: 1,color: ColorFile.light_background,)

      ],
    ),margin: EdgeInsets.only(top: 20),);


  }

}

class All_transaction_Widget_Wallet extends StatelessWidget{

  late Wallet_Model list;
  All_transaction_Widget_Wallet(Wallet_Model list){
    this.list=list;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(child: Column(
      children: [
        new Container(child: new Row(
          children: [
            new Container(height: 40,width: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100),border: new Border.all(width: 1,color: ColorFile.bgs)),child:ClipRRect(child: new Image.network(list.logo.toString(),height: 35,),borderRadius: new BorderRadius.circular(100),),padding: EdgeInsets.all(5),),
            new SizedBox(width: 20,),
            Expanded(child: new Container(child:
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(list.remark.toString(),style: Styles().styles_medium(16, ColorFile.black),),
                new SizedBox(height: 5,),
                new Container(child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text(AppUtils.server_utc_date_parse(list.datetime.toString()),style: Styles().styles_regular(14, ColorFile.black),),)),

                    new Text(list.type.toLowerCase()=="credit"?"+"+list.point.toString():"-"+list.point.toString(),style: Styles().styles_medium(14,list.type.toLowerCase()=="credit"? ColorFile.greens:ColorFile.red_900),),

                  ],
                ),),
                new SizedBox(height: 5,),


              ],
            ),))

          ],
        ),),

        new SizedBox(height: 20,),
        new Container(child:new Row(children: [],),height: 1,color: ColorFile.light_background,)

      ],
    ),margin: EdgeInsets.only(top: 20),);
  }

}