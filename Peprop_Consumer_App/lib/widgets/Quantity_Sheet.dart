

import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class Quantity_Sheet extends StatefulWidget{
  List<String> priceList=[];
  final Function(String) onSelectionChanged;
  String type="";
  Quantity_Sheet(List<String> priceList, String type, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.type=type;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Quantity_Sheet> {
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
                widget.onSelectionChanged(widget.priceList[index]);
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
                              Expanded(child: new Container(
                                child: Row(
                                  children: [
                                    new Text(widget.priceList[index]+" "+widget.type.toString(),style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                                    new SizedBox(width: 10,),

                                  ],
                                ),
                              ),),








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