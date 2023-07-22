


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';
import '../Models/Listing_Filter_Model.dart';
import '../Models/Tower_Model.dart';
import '../Utils/AppUtils.dart';

class Unit_Type_Sheet extends StatefulWidget{
  List<Book_Now_all_Tower_Model> priceList=[];
  final Function(Book_Now_all_Tower_Model) onSelectionChanged;
  String floor_name="";
  Unit_Type_Sheet(List<Book_Now_all_Tower_Model> priceList, String floor_name, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.floor_name=floor_name;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Unit_Type_Sheet> {
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
            itemCount: widget.priceList.length,
            itemBuilder: (BuildContext context, int index) =>
            new InkWell(
              onTap: (){
                if(widget.priceList[index].unit_status=="0"){
                  widget.onSelectionChanged(widget.priceList[index]);
                  Navigator.pop(context);
                }else{
                  AppUtils.toAst("Unit Not Available",context);
                }

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
                                  new Text(widget.priceList[index].unit_name_number.toString()+" - Unit No ( "+widget.priceList[index].unit_name_number.toString()+" )",style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                                  new SizedBox(width: 10,),
                                  if(widget.priceList[index].unit_name_number.toString()==widget.floor_name)new Icon(Icons.check,size: 15,color: ColorFile.greens,)

                                ],
                              ),
                            ),),

                            if(widget.priceList[index].unit_status=="0")new Text("Available",style: new TextStyle(fontSize: 14,color: ColorFile.greens,fontFamily: "regular"),),
                            if(widget.priceList[index].unit_status=="1")new Text("Sold",style: new TextStyle(fontSize: 14,color: ColorFile.red_900,fontFamily: "bold"),),
                            if(widget.priceList[index].unit_status=="2")new Text("Hold",style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                            if(widget.priceList[index].unit_status=="3")new Text("Booked",style: new TextStyle(fontSize: 14,color: ColorFile.red_900,fontFamily: "regular"),),




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
      ),
    );
  }


}



