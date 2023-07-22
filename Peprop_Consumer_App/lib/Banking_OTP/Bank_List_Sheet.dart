


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/Bank_List_Model.dart';

import '../Color/ColorFile.dart';


class Bank_List_Sheet extends StatefulWidget{
  List<Bank_List_Model> priceList=[];
  List<Bank_List_Model> all_list=[];


  final Function(String) onSelectionChanged;
  String bank_name="";


  Bank_List_Sheet(List<Bank_List_Model> priceList,String bank_name, {required this.onSelectionChanged}){
    this.priceList=priceList;
    this.bank_name=bank_name;
    this.all_list.addAll(priceList);



  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State_For_States ();
  }

}

class Build_State_For_States extends State<Bank_List_Sheet> {
  int selected_price=-1;
  final search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)), color: ColorFile.white,
      ),
      child: Column(
        children: [
              new Container(
            margin:
            EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(30)),
                color: ColorFile.light_background),
            height: 45,
            child: new Row(
              children: [
                new SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/search.png",
                  height: 25,
                  width: 25,
                ),
                new SizedBox(
                  width: 10,
                ),
                new Expanded(
                    child: new Container(
                      alignment: Alignment.centerLeft,
                      child: widget_("Search Bank...", search),
                    )),

              ],
            ),
          ),
             Expanded(child:  ListView.builder(

             scrollDirection: Axis.vertical,
             itemCount: widget.priceList.length,
             itemBuilder: (BuildContext context, int index) =>
             new InkWell(
               onTap: (){
                 widget.onSelectionChanged(widget.priceList[index].bank_name);
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
                               new SizedBox(width: 20,),
                               Expanded(child: new Container(child:new Text(widget.priceList[index].bank_name,style: new TextStyle(fontSize: 14,color: ColorFile.black,fontFamily: "regular"),), )),
                               new SizedBox(width: 10,),
                               if(widget.bank_name==widget.priceList[index].bank_name)new Icon(Icons.check,size: 15,color: ColorFile.greens,)
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





         ))
        ],
      )
      
 
    );
  }
  Widget widget_(String hint, TextEditingController controller) {
    return Container(
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 200,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          onchanged(value.toString());
        },
        style:
        TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          hintStyle:
          TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        widget.priceList.clear();
        widget.priceList.addAll(widget.all_list);
      });
    }else{
      widget.priceList.clear();
      widget.all_list.forEach((element) {
        if(element.bank_name.toString().toLowerCase().contains(value.toString().toLowerCase())){
          widget.priceList.add(element);
        }
      });
      setState(() {

      });
    }
  }
}