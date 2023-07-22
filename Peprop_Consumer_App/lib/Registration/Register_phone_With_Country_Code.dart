

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';

class Register_phone_With_Country_Code extends StatelessWidget{
  String hint="";
  String country_code="";


  late TextEditingController controller;
  int lenght=0;
  bool is_number=false;
  bool read_only=false;
  Function () pick_country_code;

  Register_phone_With_Country_Code(String hint ,TextEditingController controller,int lenght,bool is_number,bool read_only,String country_code,{required this.pick_country_code}){
    this.hint=hint;
    this.controller=controller;
    this.lenght=lenght;
    this.is_number=is_number;
    this.read_only=read_only;
    this.country_code=country_code;



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
          height: 45,
          child: Row(
            children: [
              InkWell(child: new Container(alignment: Alignment.center,width: 65,height: 45,child: new Text(country_code,style: Styles().styles_medium(14, ColorFile.red_900),),),onTap: (){
                pick_country_code();

              },),
              new Container(width: 1,height: 45, color: ColorFile.hint_color,),

              Expanded(child:TextField(
                controller: controller,
                maxLength: 10,
                autofocus: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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