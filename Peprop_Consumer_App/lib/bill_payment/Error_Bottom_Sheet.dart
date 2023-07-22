


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/bill_payment/model/Circle_Model.dart';

import '../wish_list/Styles.dart';


class Error_Bottom_Sheet extends StatefulWidget{

  final Function() onSelectionChanged;
  String message="";

  Error_Bottom_Sheet(String message, {required this.onSelectionChanged}){
    this.message=message;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Error_Bottom_Sheet> {
  @override
  Widget build(BuildContext context) {

    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: new SingleChildScrollView(
        child:new Container(
          child:Padding(child: new Column(
            children: [
              new Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        widget.onSelectionChanged();
                        Navigator.pop(context);
                      },
                      child:  Container(
                        margin: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child:  Container(
                          width: 30,
                          height: 30,
                          decoration:  BoxDecoration(
                            borderRadius: new BorderRadius.all(Radius.circular(100)),
                            color: ColorFile.hexblack,

                          ),
                          child:  Icon(Icons.close,color: ColorFile.white,) ,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              new Container(child:new Text(widget.message.toString().length==0?"It seems the details that you entered are wrong.Please enter correct details and try again.":widget.message.toString(),style: Styles().styles_medium(15, ColorFile.red_900),),padding: EdgeInsets.all(10),),
              new SizedBox(height: 50,)

            ],
          ),padding: EdgeInsets.all(10),),
        )




      ),
    );
  }


}



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
                              new Text(widget.priceList[index],
                                style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.propertyTypeName==widget.priceList[index])new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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





class Operator_Bottom_Sheet extends StatefulWidget{
  List<Opertaor_list> priceList=[];
  final Function(int index) onSelectionChanged;

  String propertyTypeName="";

  Operator_Bottom_Sheet(List<Opertaor_list> priceList, String propertyTypeName, {required this.onSelectionChanged}){
    this.priceList=priceList;

    this.propertyTypeName=propertyTypeName;


  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_op ();
  }

}

class Build_State_For_op extends State<Operator_Bottom_Sheet> {
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
                              Expanded(child: new Container(child:  new Text(widget.priceList[index].name,
                               style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),)),
                              new SizedBox(width: 10,),
                              if(widget.propertyTypeName==widget.priceList[index].name)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
                            ],
                          )
                      ), new Container(
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
