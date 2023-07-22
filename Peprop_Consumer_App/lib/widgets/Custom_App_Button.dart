


import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';

class Custom_App_Button extends StatelessWidget{

  Function onclick;
  String title="";
  Custom_App_Button(String title,{required this.onclick}){
    this.title=title;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  InkWell(child: Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5,spreadRadius: 2)], gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,colors: [ColorFile.app_color,ColorFile.app_color])),child: Text(title,style: Styles().styles_regular(16, ColorFile.white),
    ),
    ),onTap: (){
      onclick();

    },);;
  }



}