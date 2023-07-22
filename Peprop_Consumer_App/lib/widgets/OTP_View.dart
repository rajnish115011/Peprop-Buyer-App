


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP_View extends StatelessWidget{
  TextEditingController contoller=TextEditingController();
  final Function(String index) onSelectionChanged;

  OTP_View(TextEditingController controller,{required this.onSelectionChanged}){
    this.contoller=controller;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    PinCodeTextField(
      appContext: context,
      length: 6,
      controller: contoller,
      inputFormatters: [LengthLimitingTextInputFormatter(6)],
      keyboardType: TextInputType.number,
      cursorColor: ColorFile.app_color,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          borderWidth: 1,
          inactiveColor: ColorFile.greens,
          inactiveFillColor: ColorFile.white,
          selectedFillColor: ColorFile.bgs),
      animationDuration: Duration(milliseconds: 300),
      onChanged: (value) {

      },
      onCompleted: (value) {
        if(value.toString().length==6){
          onSelectionChanged(value.toString());
        }

      },
    );
  }

}