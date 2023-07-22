

import 'package:flutter/cupertino.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class Buy_Sale_Header extends StatelessWidget{
  String title="";

  Buy_Sale_Header(String title){
    this.title=title;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new SizedBox(height: 10,),
        new Container(child: new Text(title,style: new TextStyle(fontFamily: "medium",color:ColorFile.hexblack,fontSize: 16),),),
        new SizedBox(height: 20,),
      ],
    );
  }

}