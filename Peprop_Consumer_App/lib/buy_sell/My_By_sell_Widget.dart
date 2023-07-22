

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../Models/Buy_Sell_Model.dart';
import '../widgets/MyVerticalText.dart';
import '../wish_list/Styles.dart';

class My_By_sell_Widget extends StatelessWidget {
  late Buy_Sell_Model lead_list;

  My_By_sell_Widget(Buy_Sell_Model lead_list) {
    this.lead_list = lead_list;

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 20,left: 10,right: 10),
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.white),
      child: Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            color: ColorFile.app_color
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(alignment: Alignment.center,padding: EdgeInsets.only(left: 5,right: 5,top: 20,bottom: 20),child: new MyVerticalText(lead_list.residential.toString()=="1"?"Residential":"Commercial"), decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),),
            Expanded(child: new Container(
              decoration: new BoxDecoration(borderRadius:new BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),color: ColorFile.white),
              padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
              child:
              new Column(
                children: [
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Image.asset("assets/calendar.png",width: 12,height: 12,fit: BoxFit.cover,),
                        new SizedBox(width: 10,),
                        new Text(AppUtils.convert_date(lead_list.created_on),style: new TextStyle(fontFamily: "regular", fontSize: 13, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        new SizedBox(width: 20,),
                      ],
                    ),)),

                    Image.asset("assets/clock.png",width: 12,height: 12,fit: BoxFit.cover,),
                    new SizedBox(width: 10,),
                    new Text(AppUtils.convert_date_time(lead_list.created_on),style: new TextStyle(fontFamily: "regular", fontSize: 13, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),


                  ],),),
                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("" + lead_list.proj_name.toUpperCase(),style: new TextStyle(fontFamily: "semi", fontSize: 16, color: ColorFile.black),maxLines: 1,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),
                  new SizedBox(height: 10,),
                  new Container(
                    child: new Row(
                      children: [
                        if(lead_list.residential.toString()=="1")new Container(child: new Text(lead_list.bedroom.toString()+" "+lead_list.PropertType.toString(),style: Styles().styles_medium(14,ColorFile.black),),),
                        if(lead_list.commercial.toString()=="1")new Container(child: new Text(lead_list.PropertType.toString(),style: Styles().styles_medium(14,ColorFile.black),),)

                      ],
                    ),
                  ),



                  new SizedBox(height: 10,),
                  new Container(child: new Row(children: [
                    Expanded(child: new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child:new Text("" + lead_list.loc_name.toString(),style: new TextStyle(fontFamily: "regular", fontSize: 12, color: ColorFile.black),maxLines: 2,overflow: TextOverflow.ellipsis,),)),

                      ],
                    ),)),



                  ],),),
                ],
              ),
            ))
          ],
        ),
      ),);
  }

}
