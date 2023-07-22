import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';
import '../Properties/Properties_Detail.dart';
import '../wish_list/Styles.dart';
import 'UnicornOutlineButton.dart';

class My_Booking_Payment_Widget extends StatelessWidget {
  My_Booking_Models? list;
  My_Booking_Payment_Widget(My_Booking_Models? list){
    this.list=list;
  }



  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),
          border: new Border.all(width: 1,color: ColorFile.lightgray)

      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(list!.mode_type.toString().toLowerCase()=="cheque"||list!.mode_type.toString().trim().toLowerCase().contains("demand"))new Column(
           children: [
             Form_Title("Payment Mode","Booking Amount"),
             new SizedBox(height: 5,),
             Form_Title_content(list!.mode_type.toString().toUpperCase()," ₹ "+list!.booking_amount.toString()),
             new SizedBox(height: 10,),


             Form_Title("Issue Date",list!.mode_type.toString().trim().toLowerCase().contains("demand")?"DD Number":"Cheque Number"),
             new SizedBox(height: 5,),
             Form_Title_content(list!.payment_date.toString(),""+list!.cheque_number.toString()),
             new SizedBox(height: 10,),


             Form_Title("Bank Name","Account Number"),
             new SizedBox(height: 5,),
             Form_Title_content(list!.bank_name.toString(),""+list!.account_number.toString()),
             new SizedBox(height: 10,),


             Form_Title("Account Holder Name",""),
             new SizedBox(height: 5,),
             Form_Title_content(list!.bank_holder_name.toString(),""),
             new SizedBox(height: 10,),



           ],
         ),




          if(list!.mode_type.toString()=="online")new Column(
            children: [
              Form_Title("Payment Mode","Booking Amount"),
              new SizedBox(height: 5,),
              Form_Title_content(list!.mode_type.toString().toUpperCase()," ₹ "+list!.booking_amount.toString()),
              new SizedBox(height: 10,),


              Form_Title("Bank Name","Transaction Type"),
              new SizedBox(height: 5,),
              Form_Title_content(list!.bank_name.toString(),""+list!.payment_type.toString()),
              new SizedBox(height: 10,),


              Form_Title("Date","UTR Number"),
              new SizedBox(height: 5,),
              Form_Title_content(list!.payment_date.toString(),list!.utr_no.toString()),
              new SizedBox(height: 10,),




            ],
          ),

              if(list!.mode_type.toString()=="payment_gateway")new Column(
              children: [
              Form_Title("Payment Mode","Booking Amount"),
              new SizedBox(height: 5,),
              Form_Title_content("Payment Gateway"," ₹ "+list!.booking_amount.toString()),
              new SizedBox(height: 10,),

              Form_Title2("Date",),
              new SizedBox(height: 5,),
              Form_Title2_content(list!.payment_date.toString()),
              new SizedBox(height: 10,),




            ],
          ),



          if(list!.mode_type.toString()=="cash")new Column(
            children: [
              Form_Title("Payment Mode","Booking Amount"),
              new SizedBox(height: 5,),
              Form_Title_content(list!.mode_type.toString().toUpperCase()," ₹ "+list!.booking_amount.toString()),
              new SizedBox(height: 10,),


              Form_Title("Date","Receipt Number"),
              new SizedBox(height: 5,),
              Form_Title_content(list!.payment_date.toString(),list!.receipt_number.toString()),
              new SizedBox(height: 10,),




            ],
          )




        ],
      ),
    );
  }


}
