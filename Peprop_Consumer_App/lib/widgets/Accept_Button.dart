


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class Accept_Button extends StatelessWidget{

  Function(int) onclick;
  String title="";
  bool is_checked=false;
  Accept_Button(String title, bool is_checked,{required this.onclick}){
    this.title=title;
    this.is_checked=is_checked;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      child:

      new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: InkWell(
            onTap: (){


             onclick(0);
            },

            child: new Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10), color: is_checked?ColorFile.app_color:ColorFile.hex_cyan),
                margin: EdgeInsets.all(10),
                height: 60,
                child:new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  new Text(title,style: Styles().styles_medium(13, ColorFile.white),),
                  new SizedBox(width: 5,),
                  new Icon(Icons.arrow_forward,color: ColorFile.white,)
                ],)

            ),)),
        ],
      ),
    );

  }

}