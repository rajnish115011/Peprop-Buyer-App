


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';
import '../Models/Listing_Filter_Model.dart';

class Floor_No_Sheet extends StatefulWidget{
  List<dynamic> priceList=[];
  final Function(String index) onSelectionChanged;

  String floor_name="";

  Floor_No_Sheet(List<dynamic> priceList, String floor_name, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.floor_name=floor_name;



  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Floor_No_Sheet> {
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
                widget.onSelectionChanged(widget.priceList[index].toString());
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
                            new Text(widget.priceList[index].toString(),style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                            new SizedBox(width: 10,),
                            if(widget.priceList[index].toString()==widget.floor_name)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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



