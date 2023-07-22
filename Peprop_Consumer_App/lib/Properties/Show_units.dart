
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';

class Show_units extends StatelessWidget{
  var model;
  String is_click="";
  String booking_option="";
  String title="";
  String type="";
  String name="";
  Function () book_now;


  Show_units(model, String is_click, String booking_option, String title, String type,String name,{required this.book_now}){
    this.model=model;
    this.is_click=is_click;
    this.booking_option=booking_option;
    this.title=title;
    this.type=type;
    this.name=name;



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(5),

      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(

            height: 100,

            child: new Row(
              children: [
                Expanded(child: new Container(

                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/price.png",height: 30,width: 30,),
                      new SizedBox(height: 5,),
                      new Text("Builder Price",style: new TextStyle(fontFamily: "regular",fontSize: 10,color: ColorFile.hint_color),),
                      new SizedBox(height: 5,),
                      new Text(model.CurrencyName+" "+model.unit_price+" "+model.name+"*",style: new TextStyle(fontFamily: "semi",fontSize: 14,color: ColorFile.black),),


                    ],
                  ),

                ),),
                Expanded(child: new Container(

                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/area.png",height: 30,width: 30,),
                      new SizedBox(height: 5,),
                      new Text("Carpet Area",style: new TextStyle(fontFamily: "regular",fontSize: 10,color: ColorFile.hint_color),),
                      new SizedBox(height: 5,),
                      new Text(model.prop_unit_size+" "+model.unit_measurement,style: new TextStyle(fontFamily: "semi",fontSize: 14,color: ColorFile.black)),
                    ],
                  ),

                ),),

                if(is_click!="false"&&booking_option=="1"||booking_option=="2")Expanded(

                  child:
                  InkWell(
                    onTap: () async {
                      book_now();
                    },
                    child:
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.orangeAccent),
                      child: Shimmer.fromColors(
                        period: const Duration(milliseconds: 1500),
                        baseColor: Colors.white,
                        highlightColor: Colors.orangeAccent,
                        child: const Text(
                          "Book Now",style: TextStyle(fontFamily: "bold", fontSize: 14, color: ColorFile.white,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),


          new Container(
            margin: EdgeInsets.only(top: 40),
            child:
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child:new Text("Floor Plans of "+title.toString(),style: new TextStyle(fontSize: 18,fontFamily: "bold",color: ColorFile.black),),
                ),

                InkWell(child:  new Container(
                    child:new Row(
                      children: [
                        new Text("Showing for ",style: new TextStyle(fontSize: 12,fontFamily: "regular",color: ColorFile.hint_color),),
                        new Text(type.toString()=="1"?model.unit_name+" "+name.toString():model.unit_name+" ( "+model.prop_unit_size+" "+model.unit_measurement+" )",style: new TextStyle(fontSize: 12,fontFamily: "bold",color: ColorFile.black),),


                      ],
                    )
                ),onTap: () async {



                },),


                Card(child: new Container(
                    height: MediaQuery.of(context).size.width/2,
                    width: MediaQuery.of(context).size.width/2,
                    child: new Container(
                      padding: EdgeInsets.all(10),
                      child:new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child:new Container(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                  child:FadeInImage.assetNetwork(
                                      placeholder: 'assets/loading.png',
                                      image:API.map_image+model.PropertymapImage,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset("assets/placeholder.png",
                                          fit: BoxFit.cover,);})))),
                          new SizedBox(height: 10,),
                          Container(child: new Text("Carpet Area",style: new TextStyle(fontSize: 12,color: ColorFile.hint_color,fontFamily: "regular"),),),
                          new SizedBox(height: 5,),
                          Container(child: new Text(model.prop_unit_size+" "+model.unit_measurement,style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "medium"),),)

                        ],
                      ),
                    )

                ),)






              ],
            ),
          )
        ],
      ),);
  }

}