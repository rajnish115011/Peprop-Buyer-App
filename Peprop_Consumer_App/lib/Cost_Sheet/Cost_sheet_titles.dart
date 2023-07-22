

import 'package:flutter/cupertino.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class Cost_sheet_titles extends StatelessWidget{
  String title1="";
  String title2="";
  Cost_sheet_titles(String title1,String title2){
    this.title1=title1;
    this.title2=title2;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(bottom: 5,top: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: new Container(
            child: new Text(title1,style: new TextStyle(fontFamily: "regular",fontSize: 14,color: ColorFile.hint_color),),

          )),
          SizedBox(width: 10,),
          Expanded(child: new Container(
            child: new Text(title2,style: new TextStyle(fontFamily: "regular",fontSize: 14,color: ColorFile.hint_color),),

          ))
        ],
      ),
    );
  }

}
class Cost_sheet_titles1 extends StatelessWidget{
  String title1="";

  Cost_sheet_titles1(String title1){
    this.title1=title1;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(bottom: 5,top: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: new Container(
            child: new Text(title1,style: new TextStyle(fontFamily: "regular",fontSize: 14,color: ColorFile.hint_color),),

          )),

        ],
      ),
    );
  }

}