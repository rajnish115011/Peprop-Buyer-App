

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';

class Book_Noew_Button extends StatelessWidget{
  Function(String)on_selected;
  String amount="";
  String title="";


  Book_Noew_Button(String amount, String title,{required this.on_selected}){
    this.amount=amount;
    this.title=title;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(10),
      color: ColorFile.white,
      height: 90,
      child: new Row(
              children: [
              Expanded(child: new Container(alignment: Alignment.centerLeft,child:new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              new Text("Booking Amount", style: Styles().styles_regular(15, Colors.orange)),
              new SizedBox(height: 5,),
              new Text("₹ " + amount.toString(), style: new TextStyle(fontFamily: "bold", fontSize: 18,color: ColorFile.selectd_color),),
            ],
          ),)), InkWell(onTap: () async {
            on_selected("value");

          },
            child: new Container(alignment: Alignment.center,
              height: 45,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10),
                  color: ColorFile.yellowdark),
              child: new Text(title, style: new TextStyle(
                  fontFamily: "medium",
                  color: ColorFile.black,
                  fontSize: 15),),),)


        ],
      ),

    );
  }

}