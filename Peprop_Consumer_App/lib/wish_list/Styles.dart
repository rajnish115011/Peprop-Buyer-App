

import 'package:flutter/cupertino.dart';

class Styles {

   TextStyle styles_bold(double size,Color color){
    return TextStyle(fontSize: size,fontFamily: "bold",color: color);

  }  TextStyle styles_medium(double size,Color color){
     return TextStyle(fontSize: size,fontFamily: "medium",color: color);

   }TextStyle price(double size,Color color, TextDecoration lineThrough){
     return TextStyle(fontSize: size,fontFamily: "medium",color: color,decoration: lineThrough);

   } TextStyle semi(double size,Color color){
     return TextStyle(fontSize: size,fontFamily: "semi",color: color);

   }  TextStyle styles_regular(double size,Color color){
    return TextStyle(fontSize: size,fontFamily: "regular",color: color);

  }
   TextStyle under_line_styles_bold(double size,Color color){
     return TextStyle(fontSize: size,fontFamily: "bold",color: color,decoration: TextDecoration.underline);

   } TextStyle under_line_styles_regular(double size,Color color){
     return TextStyle(fontSize: size,fontFamily: "regular",color: color,decoration: TextDecoration.underline);

   }

   static String stripHtmlIfNeeded(String text) {
     return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
   }
}