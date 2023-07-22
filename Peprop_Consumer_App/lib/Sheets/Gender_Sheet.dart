


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class Gender_Sheet extends StatefulWidget{

  final Function(String gender) onSelectionChanged;
  String selectedgender="0";

  Gender_Sheet(String selectedgender, {required this.onSelectionChanged}){
    this.selectedgender=selectedgender;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_Area();
  }

}

class Build_State_For_Area extends State<Gender_Sheet> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,),
      child:new SingleChildScrollView(
        child:new Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          height: 200,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: new Container(
                decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10),),border: new Border.all(width:1,color: widget.selectedgender=="Male"? ColorFile.greens:ColorFile.white)),

                child:InkWell(child:new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/male.png",height: 60,),
                    new SizedBox(height: 20,),
                    new Text("Male",style: new TextStyle(fontFamily: "medium",fontSize: 16),)

                  ],
                ),onTap:(){
                  widget.onSelectionChanged("Male");
                  Navigator.pop(context);

                }),),),
              Expanded(child: new Container(
                decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(10),),border: new Border.all(width:1,color: widget.selectedgender=="Female"? ColorFile.greens:ColorFile.white)),
                child:InkWell(child:new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/female.png",height: 60,),
                    new SizedBox(height: 20,),
                    new Text("Female",style: new TextStyle(fontFamily: "medium",fontSize: 16),)

                  ],
                ),onTap:(){
                  widget.onSelectionChanged("Female");
                  Navigator.pop(context);

                }),),)


            ],
          ),
        ),
      ),

    );
  }


}

