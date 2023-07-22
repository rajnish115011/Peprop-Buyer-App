

import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import '../Models/Apartments_Model.dart';

class Developer_Bank_sheet extends StatefulWidget{
  List<Payment_option_other?> priceList=[];
  final Function(int) onSelectionChanged;

  String propertyTypeName="";

  Developer_Bank_sheet(List<Payment_option_other?> priceList, String propertyTypeName, {required this.onSelectionChanged}){
    this.priceList=priceList;

    this.propertyTypeName=propertyTypeName;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Other_state ();
  }

}
class Other_state extends State<Developer_Bank_sheet> {
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
                widget.onSelectionChanged(index);
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
                              new Text(widget.priceList[index]!.bank_name.toString(),
                                style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.propertyTypeName==widget.priceList[index]?.bank_name.toString())new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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