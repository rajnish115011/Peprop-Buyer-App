

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class Custom_Elevation_button extends StatelessWidget{
  Function()onclick;
  double size=0;
  Custom_Elevation_button(String title,double size,{required this.onclick}){
    this.title=title;
    this.size=size;

  }
  String title="";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        child: Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: size,color: ColorFile.white,fontFamily: "medium")
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.green)
                )
            )
        ),
        onPressed: (){
          onclick();


        }
    );
  }

}