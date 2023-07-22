


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import '../wish_list/Styles.dart';

class Login_Phone_Widget extends StatelessWidget{

  String hint="";
  String country_code="";

  var controller=TextEditingController();

  bool is_enabled=false;
 final Function()onclick;
  final Function()pick_country_code;

  Login_Phone_Widget(String hint, TextEditingController controller,bool is_enabled,String country_code,{required this.onclick,required this.pick_country_code}){
    this.hint=hint;
    this.controller=controller;
    this.is_enabled=is_enabled;
    this.country_code=country_code;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Mobile Number", style: TextStyle( fontSize: 15,fontFamily: "medium"),
          ),
          SizedBox(
            height: 10,
          ),
          new Container(
            color: Color(0xfff3f3f4),
            child: new Row(
            children: [

              InkWell(child: new Container(alignment: Alignment.center,width: 65,height: 45,child: new Text("+"+country_code,style: Styles().styles_medium(14, ColorFile.red_900),),),onTap: (){
                if(is_enabled==false){
                 pick_country_code();
               }

              },),
              new Container(width: 1,height: 45, color: ColorFile.hint_color,),

              Expanded(child: TextField(
                controller: controller,
                readOnly: is_enabled,
                maxLength: 10,
                autofocus: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                style:  TextStyle(fontSize:14,fontFamily: "medium",color: Colors.black),
                decoration: InputDecoration(
                  counterText: "",
                  suffixIcon:is_enabled==true?
                  Padding(child:InkWell(child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      new Text("Change",style: Styles().styles_medium(12, ColorFile.app_color),)
                    ],
                  ),onTap: (){
                    onclick();

                  },),

                    padding: EdgeInsets.only(left: 10,right: 10),):new Container(width: 1,),
                   contentPadding: EdgeInsets.only(top: 15,left: 10),

                  hintStyle:  TextStyle(fontSize:14,fontFamily: "medium",color: ColorFile.hint_color),
                  hintText: hint,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder:InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder:InputBorder.none,
                  disabledBorder:InputBorder.none,
                ),
              ))
            ],
          ),)
        ],
      ),
    );
  }
}
