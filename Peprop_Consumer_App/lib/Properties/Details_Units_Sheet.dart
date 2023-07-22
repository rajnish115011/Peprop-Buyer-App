


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';
import '../Models/Listing_Filter_Model.dart';

class Details_Units_Sheet extends StatefulWidget{
  List<PriceList> priceList=[];
  final Function(PriceList) onSelectionChanged;
  var model;



  Details_Units_Sheet(List<PriceList> priceList, model, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.model=model;




  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Details_Units_Sheet> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(

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
                            new Text(widget.priceList[index].unit_name+" ( "+widget.priceList[index].prop_unit_size+widget.priceList[index].unit_measurement+")",style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                            new SizedBox(width: 10,),
                            if(widget.model==widget.priceList[index])new Icon(Icons.check,size: 15,color: ColorFile.greens,)

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



