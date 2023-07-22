import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import 'Custom_Elevation_button.dart';

class No_Data_Placeholder extends StatelessWidget{
  String message="";
  No_Data_Placeholder(String s){
    this.message=s;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Container(
      alignment: Alignment.center,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png",height: 200,),
          new Text(message,style: new TextStyle(fontFamily: "medium",fontSize: 15),)
        ],
      ),
    );
  }

}
class No_Data_Placeholder_height extends StatelessWidget{
  String message="";
  No_Data_Placeholder_height(String s){
    this.message=s;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Container(
      alignment: Alignment.center,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png",height: 150,),
          new Text(message,style: new TextStyle(fontFamily: "medium",fontSize: 15,color: ColorFile.white),)
        ],
      ),
    );
  }

}

class No_Data_Placeholder_add extends StatelessWidget{
  String message="";
  String add_message="";
  Function () add;
  No_Data_Placeholder_add(String s,String add_message,{required this.add}){
    this.message=s;
    this.add_message=add_message;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Container(
      alignment: Alignment.center,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png",height: 200,),
          new Text(message,style: new TextStyle(fontFamily: "medium",fontSize: 15),),
          new SizedBox(height: 30,),

          Custom_Elevation_button(add_message,14,onclick: (){
            add();

          },),


        ],
      ),
    );
  }

}



class loding_Gif extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Container(
      alignment: Alignment.center,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/gg.gif",height: 200,),

        ],
      ),
    );
  }

}


class No_Data_Placeholder_white extends StatelessWidget{
  String message="";
  No_Data_Placeholder_white(String s){
    this.message=s;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Container(
      padding: EdgeInsets.all(10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png",height: 200,),
          new Text(message,style: new TextStyle(fontFamily: "medium",fontSize: 15,color: ColorFile.white),textAlign: TextAlign.center,)
        ],
      ),
    );
  }

}