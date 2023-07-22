import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/loan_model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../widgets/MyVerticalText.dart';

class Loan_Widget extends StatelessWidget {

  final LoanModel model;

  Loan_Widget(this.model);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 20,left: 10,right: 10),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white),
      child: Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            color: ColorFile.app_color
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5,top: 20,bottom: 20),child: new MyVerticalText(model.status.toString()=="0"?"Under Process":model.status.toString()=="1"?"Approved":"Rejected"), decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),),
            Expanded(child: new Container(
              decoration: new BoxDecoration(borderRadius:new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.white),
              padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
              child:
              new Column(
                children: [
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Image.asset("assets/calendar.png",width: 12,height: 12,fit: BoxFit.cover,),
                        new SizedBox(width: 10,),
                        new Text(AppUtils.convert_date(model.created_on.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 13, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        new SizedBox(width: 20,),
                      ],
                    ),)),

                    Image.asset("assets/clock.png",width: 12,height: 12,fit: BoxFit.cover,),
                    new SizedBox(width: 10,),
                    new Text(AppUtils.convert_date_time(model.created_on.toString()),style: new TextStyle(fontFamily: "regular", fontSize: 13, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),


                  ],),),
                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("Loan Type : " + model.type.toString(),style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),

                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("Applicant : " + model.name.toString(),style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),

                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("Tenure : " + model.tenure.toString()+" Months",style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),

                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("Amount : ₹ " + model.amount.toString()+"",style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),

                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("Email :  " + model.email.toString()+"",style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),
                ],
              ),
            ))
          ],
        ),
      ),);

  }
}