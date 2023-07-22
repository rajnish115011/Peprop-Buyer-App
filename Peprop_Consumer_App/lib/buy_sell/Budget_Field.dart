

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Color/ColorFile.dart';

class Budget_Field extends StatelessWidget{
  String hint="";
  late TextEditingController controller;
  int lenght=0;
  bool is_number=false;
  bool read_only=false;
  Function(String) on_changed;

  Budget_Field(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only,{required this.on_changed}){
    this.hint=hint;
    this.controller=controller;
    this.lenght=lenght;
    this.is_number=is_number;
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
                onChanged: (value){
                  on_changed(value.toString());
                },
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
             if(controller.text.length>0) Expanded(child:new Container(
                alignment: Alignment.centerRight,
                child:new Text(NumberFormat.compactCurrency(locale: 'en_IN',symbol: '₹ ').format(double.parse(controller.text.toString())).toString(),style: new TextStyle(fontFamily: "regular",color:ColorFile.black,fontSize: 18),),
              )),
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