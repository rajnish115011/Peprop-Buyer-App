



import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Models/Tower_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../Color/ColorFile.dart';
import '../wish_list/Styles.dart';

class Booking_units extends StatelessWidget{
  List<Book_Now_all_Tower_Model> unit_no_list=[];
  Function (Book_Now_all_Tower_Model,int) onclick;

  String unit_type="";

  Booking_units(List<Book_Now_all_Tower_Model> unit_no_list, String unit_type,{required this.onclick}){
    this.unit_no_list=unit_no_list;

    this.unit_type=unit_type;




  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return    Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text(
            "Unit No.",
            style: new TextStyle(
                fontFamily: "medium", fontSize: 16),
          ),
          new SizedBox(height: 10,),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: unit_no_list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 2/1.6),
            itemBuilder: (BuildContext context, int index) {
              return
                InkWell(child: Container(
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(5),
                      color:unit_no_list[index].is_checked==true?ColorFile.greens:ColorFile.white,
                      border: new Border.all(width: 2,
                        color:unit_no_list[index].unit_status=="0"?ColorFile.greens:unit_no_list[index].unit_status=="1"?ColorFile.red_900:unit_no_list[index].unit_status=="2"?ColorFile.blue_400:ColorFile.yellowdark,

                      )
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child:new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(unit_no_list[index].unit_name_number.toString(),textAlign: TextAlign.center,style: Styles().styles_medium(12,unit_no_list[index].is_checked==true?ColorFile.white:ColorFile.black,),),
                        ],
                      )


                  ),
                  margin: EdgeInsets.all(1.0),
                ),onTap: (){
                  if(unit_no_list[index].unit_status=="0"){
                    if(unit_type.toString().toLowerCase()=="virtual space"){
                      unit_no_list[index].is_checked=!unit_no_list[index].is_checked;
                    }else{
                      unit_no_list.forEach((element) {
                        element.is_checked=false;
                        element.extra_charges_details.clear();
                        element.other_charges_details.clear();
                        element.aminities_charges_details.clear();


                      });
                      unit_no_list[index].is_checked=true;

                    }



                    onclick(unit_no_list[index],index);
                  }else{
                    if(unit_no_list[index].unit_status=="1"){
                      AppUtils.toAst("Unit Already Sold..!!",context);

                    } if(unit_no_list[index].unit_status=="2"){
                      AppUtils.toAst("Unit Already Hold..!!",context);

                    } if(unit_no_list[index].unit_status=="3"){
                      AppUtils.toAst("Unit Already Booked..!!",context);

                    }

                  }
                },);
            },
          ),
          new Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(5),
              border: new Border.all(width: 1,color: ColorFile.calls)
            ),
            child: new Column(
              children: [
                new SizedBox(height: 10,),
                new Container(child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Row(children: [ new Container(height: 20,width: 20,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color:ColorFile.greens ),),
                      new SizedBox(width: 10,),
                      new Text("Available",style: Styles().styles_medium(12, ColorFile.black),)],),)),
                    Expanded(child: new Container(child: new Row(children: [ new Container(height: 20,width: 20,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color:ColorFile.red_900 ),), new SizedBox(width: 10,), new Text("Sold",style: Styles().styles_medium(12, ColorFile.black),)],),)),


                  ],
                ),),
                new SizedBox(height: 10,),
                new Container(child: new Row(
                  children: [
                    Expanded(child: new Container(child: new Row(children: [ new Container(height: 20,width: 20,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color:ColorFile.blue_400 ),), new SizedBox(width: 10,), new Text("Hold",style: Styles().styles_medium(12, ColorFile.black),)],),)),

                    Expanded(child: new Container(child: new Row(children: [ new Container(height: 20,width: 20,decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color:ColorFile.yellowdark ),), new SizedBox(width: 10,), new Text("Booked",style: Styles().styles_medium(12, ColorFile.black),)],),)),


                  ],
                ),),
                new SizedBox(height: 10,),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: unit_no_list.length,
            itemBuilder: (BuildContext context, int index) {
              if(unit_no_list[index].is_checked==true)
                return    new Container(
                margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.bgs),
                padding: EdgeInsets.all(10),
                child: new Column(
                  children: [


                    new Container(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: new Container(alignment: Alignment.center,child: new Text("Unit No : "+unit_no_list[index].unit_name_number,style: Styles().styles_medium(16, ColorFile.black),),)),


                      ],
                    ),),
                    new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child: new Text("Super Area",style: Styles().styles_medium(16, ColorFile.black),),)),
                        new Container(child: new Text(unit_no_list[index].super_area.toString()+" Sq.ft.",style: Styles().styles_medium(16, ColorFile.hint_color),),)



                      ],
                    ),),


                    new SizedBox(height: 10,),
                    new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child: new Text("Carpet Area",style: Styles().styles_medium(16, ColorFile.black),),)),
                        new Container(child: new Text(unit_no_list[index].carpet_area.toString()+" Sq.ft.",style: Styles().styles_medium(16, ColorFile.hint_color),),)



                      ],
                    ),),

                    new SizedBox(height: 10,),
                    new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child: new Text("BSP per Sq.ft.",style: Styles().styles_medium(16, ColorFile.black),),)),
                        new Container(child: new Text("₹ "+unit_no_list[index].bsp_super_area.toString(),style: Styles().styles_medium(16, ColorFile.hint_color),),)



                      ],
                    ),),



                    if(unit_no_list[index].unit_location.toString().length>0)new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                      children: [
                        Expanded(child: new Container(child: new Text("Location",style: Styles().styles_medium(16, ColorFile.black),),)),
                        new Container(child: new Text(unit_no_list[index].unit_location.toString(),style: Styles().styles_medium(16, ColorFile.hint_color),),)



                      ],
                    ),),


                    if(unit_no_list[index].facing_name.toString().length>0)new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(

                      children: [
                        Expanded(child: new Container(child: new Text("Facing",style: Styles().styles_medium(16, ColorFile.black),),)),
                        new Container(child: new Text(unit_no_list[index].facing_name.toString(),style: Styles().styles_medium(16, ColorFile.hint_color),),)



                      ],
                    ),),

                    new SizedBox(height: 10,),
                    new Container(child: new Row(
                      children: [
                        Expanded(child: new Container(child: new Text("BSP Amount(₹)",style: Styles().styles_medium(16, ColorFile.black),),)),
                        new Container(child: new Text("₹ "+AppUtils().calculate_bsp(unit_no_list[index].bsp_super_area.toString(),unit_no_list[index].super_area.toString()),style: Styles().styles_medium(16, ColorFile.hint_color),),)
                      ],
                    ),),


                  ],
                ),
              ); else return new Container(height: 0,);


            },
          ),




        ],
      ),);
  }

}