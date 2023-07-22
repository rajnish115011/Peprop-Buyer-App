

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';

class Widget_Offers_List extends StatelessWidget{
  List<Offers> offer_list=[];
  Widget_Offers_List(List<Offers> offer_list){
    this.offer_list=offer_list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        margin: EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(child:new Text("Offers",style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),),
          new SizedBox(height: 10,),
          Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
                color: ColorFile.calls),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.only(right: 10,top: 5,bottom: 5),
                  child:
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: offer_list.length,
                    itemBuilder: (BuildContext context, int index) =>
                    new Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child:new Row(children: [
                          new Icon(Icons.local_offer,color: ColorFile.greens,size: 10,),
                          new SizedBox(width: 10,),
                          new Text(offer_list[index].offer_title,style: new TextStyle(fontFamily: "semi",color: ColorFile.black,fontSize: 12),textAlign: TextAlign.start,)

                        ],) ),

                  ),
                ),
              ],
            ),
          )
        ],
      )
    );

  }

}


