

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Buy_Sell_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

class Buy_Sell_Details extends StatefulWidget{
  late Buy_Sell_Model my_list;
  String type="";
  Buy_Sell_Details(Buy_Sell_Model my_list, String type){
    this.my_list=my_list;
    this.type=type;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Buy_Sell_Details>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar:  AppUtils.appBar(context, ""),
      body: new SingleChildScrollView(
        child:new Card(
          margin: EdgeInsets.all(10),
            child:Padding(child:   new Column(
            children: [

              new Container(
                margin: EdgeInsets.only(top: 10),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Property",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.proj_name.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),

              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Property Type",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.residential=="1"?"Residential":"Commercial",style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),

              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Property Sub-Type",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.PropertType.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),

              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("City",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.city_name.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Address",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.loc_name.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),

              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Furnishing",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.furnishing_types_name.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),


              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text(widget.type=="1"?"Budget":"Sell Price",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.budget.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),

             if(widget.my_list.lease.toString()!="2") new Container(
                child: new Column(
                  children: [
                    new Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Text("Purpose",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                          Expanded(child: new Container(child: new Text(widget.my_list.perpose.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Text("Funding Source",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                          Expanded(child: new Container(child: new Text(widget.my_list.source.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                        ],
                      ),
                    ),

                  ],
                ),
              ),
              if(widget.my_list.lease.toString()=="1") new Container(
                child: new Column(
                  children: [
                    new Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Text("Purpose",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                          Expanded(child: new Container(child: new Text(widget.my_list.perpose.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new Row(
                        children: [
                          Expanded(child: new Container(child: new Text("Possession by",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                          Expanded(child: new Container(child: new Text(widget.my_list.possession_by.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                        ],
                      ),
                    ),

                  ],
                ),
              ),

              new Container(
                margin: EdgeInsets.only(top: 20),
                child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Text("Area",style:Styles().styles_medium(16, ColorFile.hint_color),),)),
                    Expanded(child: new Container(child: new Text(widget.my_list.area.toString()+" "+widget.my_list.area_type_name.toString(),style:Styles().styles_regular(16, ColorFile.black),),))


                  ],
                ),
              ),
             if(widget.my_list.photo.length>0) new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new SizedBox(height: 30,),
                  new Container(child: new Text("Property Gallery",style: Styles().styles_bold(18, ColorFile.black),),),
                  new SizedBox(height: 10,),
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.my_list.photo.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing: 5,mainAxisSpacing: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return new Container(decoration: new BoxDecoration(border: new Border.all(width: 1,color: ColorFile.hint_color)),child: Image.network(API.sellListing+widget.my_list.photo[index].toString()),);
                      }

                  ),
                ],
              )




            ],
          ),padding: EdgeInsets.all(10),)
          
        
        )


      ),
    );
  }

}