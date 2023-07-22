



import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';

class Resend_Widget extends StatelessWidget{
  Function ()resend;
  Resend_Widget({required this.resend});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 18,
        ),
        Text("Didn't you receive any OTP?",
          style:Styles().styles_regular(12, ColorFile.hint_color),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 18,
        ),
        new InkWell(child:Text("Resend OTP",style:Styles().styles_bold(14, ColorFile.app_color),textAlign: TextAlign.center,),onTap: (){
          resend();
        },)
      ],
    );
  }

}