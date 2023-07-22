import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';

import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';

class Bill_Payment_Form_With_Change extends StatelessWidget{

  String hint="";
  var controller=TextEditingController();
  bool is_read=false;
  final Function on_slected;


  Bill_Payment_Form_With_Change(String hint, TextEditingController controller,bool is_read,{required this.on_slected}){
    this.hint=hint;
    this.controller=controller;

    this.is_read=is_read;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
        controller: controller,
        readOnly: is_read,
        style: TextStyle(fontSize: 14, fontFamily: "regular", color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          labelText: hint,

          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          suffixIcon:is_read==true?
          Padding(child:
          InkWell(child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text("Change",style: Styles().styles_medium(14, ColorFile.app_color),)
            ],
          ),onTap: (){
            on_slected();
          },),
          padding: EdgeInsets.only(left: 10,right: 10),):new Container(width: 1,),
          hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
          labelStyle: TextStyle(fontSize: 16, fontFamily: "medium", color: ColorFile.app_color),
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: ColorFile.app_color, width: 0.0),
          ),
          errorBorder:  const OutlineInputBorder(
            borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
          ),


        ),

      );
  }

}


class Bill_Payment_Form_With_Change_number extends StatelessWidget{

  String hint="";
  var controller=TextEditingController();
  bool is_read=false;
  final Function on_slected;


  Bill_Payment_Form_With_Change_number(String hint, TextEditingController controller,bool is_read,{required this.on_slected}){
    this.hint=hint;
    this.controller=controller;

    this.is_read=is_read;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: controller,
      readOnly: is_read,
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 14, fontFamily: "regular", color: Colors.black),
      decoration: InputDecoration(
        counterText: "",
        labelText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        suffixIcon:is_read==true?
        Padding(child:InkWell(child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("Change",style: Styles().styles_medium(14, ColorFile.app_color),)
          ],
        ),onTap: (){
          on_slected();
        },),
          padding: EdgeInsets.only(left: 10,right: 10),):new Container(width: 1,),
        hintStyle: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.grey),
        labelStyle: TextStyle(fontSize: 16, fontFamily: "medium", color: ColorFile.app_color),
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.app_color, width: 1.0),
        ),
        errorBorder:  const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: ColorFile.hint_color, width: 0.0),
        ),


      ),

    );
  }

}