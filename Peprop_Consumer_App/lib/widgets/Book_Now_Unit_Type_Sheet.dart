import 'package:flutter/material.dart';
import '../Color/ColorFile.dart';
import '../Models/Tower_Model.dart';

class Book_Now_Unit_type_Sheet extends StatefulWidget{
  List<Book_Now_Unit_Type_Models> list=[];
  final Function(int index) onSelectionChanged;
  String unit_type="";
  Book_Now_Unit_type_Sheet(List<Book_Now_Unit_Type_Models> list,String unit_type, {required this.onSelectionChanged}){
    this.list=list;
    this.unit_type=unit_type;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Book_Now_Unit_type_Sheet> {
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
            itemCount: widget.list.length,
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
                              new Text(widget.list[index].type,style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.list[index].type==widget.unit_type)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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




class Area_Sheet extends StatefulWidget{
  List<dynamic> list=[];
  final Function(int index) onSelectionChanged;
  String unit_type="";
  Area_Sheet(List<dynamic> list,String unit_type, {required this.onSelectionChanged}){
    this.list=list;
    this.unit_type=unit_type;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return States ();
  }

}

class States extends State<Area_Sheet> {
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
            itemCount: widget.list.length,
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
                              new Text(widget.list[index].toString()+" Sq.ft.",style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),),
                              new SizedBox(width: 10,),
                              if(widget.list[index].toString()==widget.unit_type)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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