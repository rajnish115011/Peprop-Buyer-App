

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Color/ColorFile.dart';

class Area_Buy_Sell_Filed extends StatelessWidget{
  String hint="";
  String area_name="";
  late TextEditingController controller;
  int lenght=0;
  bool is_number=false;
  bool read_only=false;
  Function() on_changed;

  Area_Buy_Sell_Filed(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only,String area_name,{required this.on_changed}){
    this.hint=hint;
    this.controller=controller;
    this.lenght=lenght;
    this.is_number=is_number;
    this.area_name=area_name;
    this.read_only=read_only;



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          hint,
          style: new TextStyle(
              fontFamily: "medium", fontSize: 16,color: ColorFile.hint_color),
        ),
        new SizedBox(
          height: 5,
        ),
        new Container(
          padding: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(Radius.circular(5)),border: new Border.all(width: 1, color: ColorFile.hint_color)),
          height: 45,
          child: Row(
            children: [
              Expanded(child:TextField(
                controller: controller,
                maxLength: lenght,

                keyboardType:TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                readOnly: read_only,
                style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  hintStyle: TextStyle(fontSize: 14, fontFamily: "medium", color: ColorFile.hint_color),
                  hintText: hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              )),
              InkWell(
                onTap: (){
                  on_changed();
                },
                child: new Row(
                  children: [
                    new Container(
                      child:new Text(area_name,style: new TextStyle(fontFamily: "medium",color:ColorFile.hint_color,fontSize: 16),),
                    ),new SizedBox(width: 10,),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),),
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),

      ],
    ));
  }

}