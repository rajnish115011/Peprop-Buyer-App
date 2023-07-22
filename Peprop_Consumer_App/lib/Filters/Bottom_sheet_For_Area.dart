
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Listing_Filter_Model.dart';

import '../Color/ColorFile.dart';

class Bottom_sheet_For_Area extends StatefulWidget{
  List<Measurement_Unit> area_list=[];
  final Function(Measurement_Unit index) onSelectionChanged;
  String selectedid="0";
  String propertyTypeName="";

  Bottom_sheet_For_Area(List<Measurement_Unit> area_list,String selectedid, {required this.onSelectionChanged}){
    this.area_list=area_list;
    this.selectedid=selectedid;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_Area();
  }

}

class Build_State_For_Area extends State<Bottom_sheet_For_Area> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: new SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.area_list.length,
            itemBuilder: (BuildContext context, int index) =>
            new InkWell(
              onTap: (){
                widget.onSelectionChanged(widget.area_list[index]);
                Navigator.pop(context);
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
                              new Text(widget.area_list[index].name,style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.selectedid==widget.area_list[index].id)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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
      ),
    );
  }


}class Devider_size extends StatelessWidget{
  double size=0;
  Devider_size(double size){
    this.size=size;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: size,

      child: new Row(
        children: [],
      ),
    );
  }

}