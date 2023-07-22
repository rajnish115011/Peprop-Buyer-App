import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';




class Other_Payment_Sheet extends StatefulWidget{
  List<String> priceList=[];
  final Function(int index) onSelectionChanged;

  String propertyTypeName="";

  Other_Payment_Sheet(List<String> priceList, String propertyTypeName, {required this.onSelectionChanged}){
    this.priceList=priceList;

    this.propertyTypeName=propertyTypeName;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Other_state ();
  }

}
class Other_Payment_Sheet1 extends StatefulWidget{
  List<dynamic> priceList=[];
  final Function(int index) onSelectionChanged;

  String propertyTypeName="";

  Other_Payment_Sheet1(List<dynamic> priceList, String propertyTypeName, {required this.onSelectionChanged}){
    this.priceList=priceList;

    this.propertyTypeName=propertyTypeName;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Other_state1 ();
  }

}
class Other_state extends State<Other_Payment_Sheet> {
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
                              new Text(widget.priceList[index].toString(),
                                style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.propertyTypeName==widget.priceList[index].toString())new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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
class Other_state1 extends State<Other_Payment_Sheet1> {
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
                              new Text(widget.priceList[index].toString(),
                                style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.propertyTypeName==widget.priceList[index].toString())new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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