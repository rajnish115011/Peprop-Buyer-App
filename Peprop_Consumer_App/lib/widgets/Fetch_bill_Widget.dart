

import 'package:flutter/cupertino.dart';

import '../Color/ColorFile.dart';
import '../bill_payment/model/Circle_Model.dart';

class Fetch_bill_Widget extends StatelessWidget{
  Bill_Fetch_Model? bill_fetch_model;
  Fetch_bill_Widget(Bill_Fetch_Model? bill_fetch_model){
    this.bill_fetch_model=bill_fetch_model;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        new SizedBox(height: 30,),
        new Container(
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color)),
          child: new Column(
            children: [

              new Container(
                margin: EdgeInsets.only(top: 15),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Customer Name",style: new TextStyle(fontFamily: "regular",color: ColorFile.hint_color),),)),
                    Expanded(child: new Container(alignment: Alignment.centerLeft,child: new Text(bill_fetch_model!.name.toString(),style: new TextStyle(fontFamily: "regular",color: ColorFile.black),),)),

                  ],
                ),),


              new Container(
                margin: EdgeInsets.only(top: 15),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Due Date",style: new TextStyle(fontFamily: "regular",color: ColorFile.hint_color),),)),
                    Expanded(child: new Container(alignment: Alignment.centerLeft,child: new Text(bill_fetch_model!.duedate.toString(),style: new TextStyle(fontFamily: "regular",color: ColorFile.black),),)),

                  ],
                ),),

              new Container(
                margin: EdgeInsets.only(top: 15),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Bill Amount",style: new TextStyle(fontFamily: "regular",color: ColorFile.hint_color),),)),
                    Expanded(child: new Container(alignment: Alignment.centerLeft,child: new Text("₹ "+bill_fetch_model!.amount.toString(),style: new TextStyle(fontFamily: "regular",color: ColorFile.black),),)),

                  ],
                ),),




            ],
          ),
        ),
        new SizedBox(height: 30,),
      ],
    );
  }

}