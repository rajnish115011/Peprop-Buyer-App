

import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';



class Available_Area extends StatefulWidget{
  List<dynamic> priceList=[];


  String floor_name="";

  Available_Area(List<dynamic> priceList){
    this.priceList=priceList;



  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Available_Area> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: new SingleChildScrollView(
        child:new Column(
          children: [
            new SizedBox(height: 30,),
            new Text("Available Area",style: Styles().styles_bold(15, ColorFile.black),),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: widget.priceList.length,
                itemBuilder: (BuildContext context, int index) =>
                new InkWell(
                  onTap: (){


                  },
                  child:  new Container(

                      alignment: Alignment.centerLeft,
                      child:new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new Container(
                              height: 60,
                              padding: EdgeInsets.only(left: 15,right: 15),
                              alignment: Alignment.centerLeft,
                              child:Row(
                                children: [
                                  Expanded(child: new Container(
                                    child: Row(
                                      children: [
                                        new Text(widget.priceList[index].toString()+" Sq.Ft.",style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                                        new SizedBox(width: 10,),

                                      ],
                                    ),
                                  ),),





                                  //0-available
                                  //1-sold
                                  //2-hold
                                  //booked




                                ],
                              )
                          ),

                          new Container(
                            height: 1,
                            color: ColorFile.lightgray,
                            child: new Row(
                              children: [

                              ],
                            ),
                          )
                        ],
                      )

                  ),
                )





            ),
          ],
        )

      ),
    );
  }


}