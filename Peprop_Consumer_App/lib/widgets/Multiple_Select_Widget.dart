


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/buy/Property_Kind.dart';

class Multiple_Select_Widget extends StatelessWidget{
late  Property_Kind model;
  Multiple_Select_Widget(Property_Kind model){
    this.model=model;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          model.is_checked==false? Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.only(left: 10,right: 10),

              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(100)),
                color: ColorFile.lightgray,
              ),
              alignment: Alignment.center,
              height: 40,

              child: new Text(model.proj_type_name, style: new TextStyle(
                  fontFamily: "regular",
                  color: ColorFile.light_black,
                  fontSize: 13),),) :
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(100)),
                color: ColorFile.selectd_color,
              ),
              alignment: Alignment.center,
              height: 40,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: new Text(model.proj_type_name, style: new TextStyle(
                  fontFamily: "regular",
                  color: ColorFile.white,
                  fontSize: 13),),),

          ],),

      ],
    );
  }

}
class Multiple_Select_Widget_Round extends StatelessWidget{
  late  Property_Kind model;
  Multiple_Select_Widget_Round(Property_Kind model){
    this.model=model;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            model.is_checked==false? Container(
              margin: EdgeInsets.only(right: 10),


              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(100)),
                color: ColorFile.lightgray,
              ),
              alignment: Alignment.center,
              height: 40,
              width: 40,

              child: new Text(model.proj_type_name, style: new TextStyle(
                  fontFamily: "regular",
                  color: ColorFile.light_black,
                  fontSize: 13),),) :
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(100)),
                color: ColorFile.selectd_color,
              ),
              alignment: Alignment.center,
              height: 40,
              width: 40,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: new Text(model.proj_type_name, style: new TextStyle(
                  fontFamily: "regular",
                  color: ColorFile.white,
                  fontSize: 13),),),

          ],),

      ],
    );
  }

}