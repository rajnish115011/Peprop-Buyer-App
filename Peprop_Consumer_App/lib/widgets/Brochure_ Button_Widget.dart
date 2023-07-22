


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

class Brochure_Button_Widget extends StatelessWidget{
  Function on_click;
  Brochure_Button_Widget({required this.on_click});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new SizedBox(height: 40,),
        new Container(
          child:new Text("Download Official Brochure",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),
        ),
        InkWell(child:Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(top: 10),child: InkWell(child: new Image.asset("assets/brochure.png",height: 60,),),),
          onTap: () async {
            on_click();



          },
        )
      ],
    );
  }

}