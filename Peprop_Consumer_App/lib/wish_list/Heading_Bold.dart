



import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class Heading_Bold extends StatelessWidget{
  String heading="";
  Heading_Bold(String heading){
    this.heading=heading;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(child: new Row(children: [
      Expanded(child: new Container(child:  new Text(heading,style: new TextStyle(fontFamily: "bold",color:ColorFile.black,fontSize: 21),),))
    ],),);
  }



}