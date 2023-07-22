


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class Form_Drop_Down extends StatelessWidget{

  String hint="";
  var controller=TextEditingController();
  int lenght=0;
  bool is_number=false;
  bool read_only=false;
  final Function on_slected;


  Form_Drop_Down(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only,{required this.on_slected}){
    this.hint=hint;
    this.controller=controller;
    this.lenght=lenght;
    this.is_number=is_number;
    this.read_only=read_only;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                onTap: (){
                  on_slected();
                },
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10,top: 15),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  suffixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child:Image.asset("assets/dropdown.png",height: 15,)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);
  }

}


class Form_drop extends StatelessWidget{

  String hint="";
  var controller=TextEditingController();
  int lenght=0;
  bool is_number=false;
  bool read_only=false;
  final Function on_slected;


  Form_drop(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only,{required this.on_slected}){
    this.hint=hint;
    this.controller=controller;
    this.lenght=lenght;
    this.is_number=is_number;
    this.read_only=read_only;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        new Container(
          height: 40,
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,
                onTap: (){
                  on_slected();
                },
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10,top: 15),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  suffixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child:Image.asset("assets/dropdown.png",height: 15,)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ))
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ),margin: EdgeInsets.only(left: 10,right: 10),);
  }

}