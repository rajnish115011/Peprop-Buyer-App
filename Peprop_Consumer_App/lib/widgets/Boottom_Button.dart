

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class Boottom_Button extends StatelessWidget{
  bool is_loading=false;
  String title="";
  Function onclick;
  Boottom_Button(bool is_loading,String title,{required this.onclick}){
    this.title=title;
    this.is_loading=is_loading;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomAppBar(
      child:new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: InkWell(
            onTap: (){
              onclick();
            },

            child: new Container(
              alignment: Alignment.center,
              decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10), color: ColorFile.app_color,),
              margin: EdgeInsets.all(10),
              height: 60,
              child:is_loading==false? new Text(title,style: Styles().styles_medium(15, ColorFile.white),):Center(child: CircularProgressIndicator(),)

          ),)),
        ],
      ),
    );
  }


}