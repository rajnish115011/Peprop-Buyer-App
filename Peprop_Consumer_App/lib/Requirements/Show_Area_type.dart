


import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';

class Show_Area_type extends StatefulWidget{
  List<dynamic> priceList=[];
  final Function(dynamic) onSelectionChanged;

  String selectedtext="";

  Show_Area_type(List<dynamic> priceList, String selectedtext, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.selectedtext=selectedtext;



  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return State_of_Area();
  }

}

class State_of_Area  extends State<Show_Area_type>{
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: new SingleChildScrollView(
          child:new Column(
            children: [
              new SizedBox(height: 20,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Container(height: 5,width: 50,color: ColorFile.light_background,)

                ],
              ),
              new SizedBox(height: 20,),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: widget.priceList.length,
                itemBuilder: (context, index) {
                  return new InkWell(
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
                                    new Text(widget.priceList[index].toString(),style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                                    new SizedBox(width: 10,),
                                    if(widget.priceList[index].toString()==widget.selectedtext)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
                                  ],
                                )
                            ),


                          ],
                        )

                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ],
          )


      ),
    );
  }
}
