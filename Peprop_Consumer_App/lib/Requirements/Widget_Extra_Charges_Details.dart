

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Book_Now/Booking/Extra_charges_details.dart';
import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';


class Widget_Extra_Charges_Details extends StatelessWidget{
  List<Extra_charges_details> extra_charges_details=[];
  Function(int)on_click;
  bool is_edit=false;
  Widget_Extra_Charges_Details(List<Extra_charges_details> extra_charges_details, bool is_edit,{required this.on_click}){
    this.extra_charges_details=extra_charges_details;
    this.is_edit=is_edit;


  }



  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(extra_charges_details.length>0)new Container(height: 40,margin: EdgeInsets.only(top: 10),color: ColorFile.app_color,child: new Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [new Text("Extra Charges",style: new TextStyle(fontFamily: "medium",fontSize: 17,color: ColorFile.white),),],)),
        if(extra_charges_details.length>0)new Container(
          child:ListView.builder(
            itemCount: extra_charges_details.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final qty=TextEditingController();
              qty.text=extra_charges_details[index].edit_qty;
              return new Container(
                margin: EdgeInsets.only(top: index==0?0:10),
                decoration: new BoxDecoration(border: new Border.all(width: 1,color: ColorFile.black)),
                child: new Column(
                children: [
                  new Container(child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: new Container(color: ColorFile.lightgray,padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),alignment: Alignment.center,child: new Text(extra_charges_details[index].name.toString()+" ₹ "+extra_charges_details[index].charge_amount.toString()+" Per "+extra_charges_details[index].unit_name.toString(),style: Styles().styles_medium(15, ColorFile.black),),))
                    ],
                  ),),
                    new Container(height: 40,color: ColorFile.bgs,child: new Row(children: [
                    Expanded(child: new Container(alignment: Alignment.center,child: new Text("Mandatory",style: Styles().styles_bold(13, ColorFile.black),),)),
                    new Container(height: 40,width: 1,color: ColorFile.black,),
                    Expanded(child: new Container(alignment: Alignment.center,child: new Text("Additional",style: Styles().styles_bold(13, ColorFile.black),),)),



                  ],),),
                   new Container(child: new Row(children: [],),height: 1,color: ColorFile.hint_color,),

                    new Container(child: new Row(children: [
                    Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text(extra_charges_details[index].mandatory_unit_num.toString()+ " "+extra_charges_details[index].unit_name.toString(),style: Styles().styles_medium(13, ColorFile.black),),)),


                    new Container(height: 40,width: 1,color: ColorFile.black,),
                    Expanded(child: InkWell(child:new Container(padding: EdgeInsets.only(left: 5,right: 10,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Container(child: new Row(children:
                    [Expanded(child:is_edit?new Text(extra_charges_details[index].edit_qty.toString().length>0?extra_charges_details[index].edit_qty.toString()+" "+extra_charges_details[index].unit_name.toString():"Select "+extra_charges_details[index].unit_name.toString(),style: Styles().styles_medium(13,extra_charges_details[index].edit_qty.toString().length>0? ColorFile.black:ColorFile.hint_color),) :new Text(extra_charges_details[index].edit_qty.toString().length>0?extra_charges_details[index].edit_qty.toString()+" "+extra_charges_details[index].unit_name.toString():"",style: Styles().styles_medium(13,extra_charges_details[index].edit_qty.toString().length>0? ColorFile.black:ColorFile.hint_color),)),
                      if(is_edit)Image.asset("assets/dropdown.png",height: 15,),
                      if(is_edit==false && extra_charges_details[index].edit_qty.toString().length==0 )new Container(child: new Text("Add",style: Styles().styles_regular(12, ColorFile.white),),margin: EdgeInsets.only(right: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.app_color,),padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),),
                      if(is_edit==false && extra_charges_details[index].edit_qty.toString().length>0 )new Container(child: new Text("Update",style: Styles().styles_regular(12, ColorFile.white),),margin: EdgeInsets.only(right: 10),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.app_color,),padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),),



                    ],),)),onTap: (){

                     on_click(index);

                    },)



                    ),



                  ],),),

                    new Container(child: new Row(children: [],),height: 1,color: ColorFile.hint_color,),
                    new Container(child: new Row(children: [
                    Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child:
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Text((" ₹ "+extra_charges_details[index].mandatory_price.toString()),style: Styles().styles_bold(13, ColorFile.black),),
                        if(extra_charges_details[index].bsp_flag.toString()=="1")new Text("(Included in BSP)",style: Styles().styles_bold(11, ColorFile.greens),),
                        if(extra_charges_details[index].bsp_flag.toString()=="2")new Text("(Not Included in BSP)",style: Styles().styles_bold(11, ColorFile.greens),),

                      ],
                    ),)),



                    new Container(height: 40,width: 1,color: ColorFile.black,),
                    Expanded(child: new Container(padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),alignment: Alignment.centerLeft,child: new Text(extra_charges_details[index].edit_qty.toString().length>0?" ₹ "+((double.parse(extra_charges_details[index].edit_qty.toString())*double.parse(extra_charges_details[index].charge_amount.toString())).toString()):"",style: Styles().styles_medium(13, ColorFile.black),),)),



                  ],),)




                ],
              ),);


              // return Card(
              //   margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
              //   child: Container(
              //       padding: EdgeInsets.all(10),
              //       width: MediaQuery.of(context).size.width,
              //       child:Row(
              //         children: [
              //           Expanded(flex: 3,child: new Container(child:   new Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               new Container(child: new Text(extra_charges_details[index].name.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 16,color: ColorFile.selectd_color),),),
              //               new SizedBox(height: 10,),
              //               new Container(child: new Text(extra_charges_details[index].quantity.toString()+" "+extra_charges_details[index].unit_name.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
              //               new SizedBox(height: 10,),
              //               new Container(child: new Text("Charges: ₹"+extra_charges_details[index].charge_amount.toString(),style: new TextStyle(fontFamily: "regular",fontSize: 12,color: ColorFile.selectd_color),),),
              //               new SizedBox(height: 10,),
              //
              //             ],),)),
              //           Expanded(flex: 2,child:new Container(child:
              //           new Column(
              //             children: [
              //               Container(
              //                 decoration:  BoxDecoration(
              //                   border: Border(
              //                     bottom: BorderSide(width: 2.0, color: ColorFile.lightgray),
              //                   ),
              //                 ),
              //                 height: 60,
              //                 child: TextField(
              //                   controller: qty,
              //                   readOnly: true,
              //                   onTap: (){
              //                     on_click(index);
              //                   },
              //                   keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),
              //                   enabled: true,
              //
              //                   maxLength: 200,
              //                   style: TextStyle(fontSize: 12, fontFamily: "regular", color: Colors.black),
              //                   decoration: InputDecoration(
              //                     counterText: "",
              //                     hintText:"Select "+extra_charges_details[index].unit_name.toString(),
              //                     suffixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child:Image.asset("assets/dropdown.png",height: 10,)),
              //
              //                     contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5),
              //                     hintStyle: TextStyle(
              //                         fontSize: 12, fontFamily: "regular", color: Colors.grey),
              //
              //                     border:  OutlineInputBorder(
              //                       borderSide:  BorderSide(color: ColorFile.yellowdark, width: 0.0),
              //                     ),
              //
              //                     disabledBorder:
              //                      OutlineInputBorder(
              //                       borderSide:  BorderSide(color: ColorFile.yellowdark, width: 0.0),
              //
              //                     ),
              //
              //                   ),
              //                 ),
              //               ),new SizedBox(height: 3,),
              //               if(extra_charges_details[index].edit_qty.toString().length>0)new Text("Amount ₹ "+((double.parse(extra_charges_details[index].edit_qty.toString())*double.parse(extra_charges_details[index].charge_amount.toString())).toString()),style: Styles().styles_regular(10, ColorFile.green),)
              //
              //             ],
              //           ),))
              //
              //         ],
              //       )
              //
              //
              //
              //   ),
              // );


            },

          ),
        ),
      ],
    );
  }

}