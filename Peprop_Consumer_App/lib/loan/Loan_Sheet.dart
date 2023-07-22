


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import 'Loan_Model.dart';


class Loan_Sheet extends StatefulWidget{
  List<Loan_Model> priceList=[];
  final Function(String) onSelectionChanged;
  String index="";


  Loan_Sheet(List<Loan_Model> priceList,String index, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.index=index;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Loan_Sheet> {
  int selected_price=-1;
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
                widget.onSelectionChanged(widget.priceList[index].loan_type);
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
                            new Text(widget.priceList[index].loan_type,style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                            new SizedBox(width: 10,),
                            if(widget.index==widget.priceList[index].loan_type)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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