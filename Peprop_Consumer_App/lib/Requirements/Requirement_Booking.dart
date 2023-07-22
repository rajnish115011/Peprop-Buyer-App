


import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Sheets/All_Bottom_Sheets.dart';
import 'package:peprop_consumer_app/Requirements/Widget_Extra_Charges_Details.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';

import '../API/API.dart';
import '../Book_Now/Booking/Form_Booking.dart';
import '../Book_Now/Booking/Online_Model.dart';
import '../Color/ColorFile.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/Tower_Model.dart';
import '../Utils/FireBase_Logs.dart';
import '../widgets/Bottom_Button.dart';
import '../widgets/Form_Title.dart';
import '../widgets/Other_Charges_List_widget.dart';
import '../wish_list/Styles.dart';

class Requirement_Booking extends StatefulWidget{
  Book_Now_Model? book_now_model;
  Requirement_Booking(Book_Now_Model? book_now_model){
    this.book_now_model=book_now_model;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Requirement_Booking>{
  double sum=0;
  bool update=false;
  double mandatory_charge=0;

  List<Book_Now_all_Tower_Model>unit_no_list=[];

  @override
  void initState() {
    super.initState();
    create_log();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar:  AppUtils.appBarTitle(context, ""),
      body: new Stack(
      children: [
        SingleChildScrollView(
          child: new Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: new Column(children: [
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(
                              height: 40,
                              decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text("Unit Details",style: Styles().styles_bold(16, ColorFile.white),)
                                ],),),


                            new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("Unit Type","Unit Size"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(widget.book_now_model!.inventory_data!.unit_type.toString()==""?"N/A":widget.book_now_model!.inventory_data!.unit_type.toString(),widget.book_now_model!.inventory_data!.unit_area.toString()==""?"N/A":widget.book_now_model!.inventory_data!.unit_area.toString()+" Sq.ft."),
                                  new SizedBox(height: 10,),

                                  Form_Title("Tower","Floor"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(widget.book_now_model!.inventory_data!.tower_name.toString()==""?"N/A":widget.book_now_model!.inventory_data!.tower_name.toString(),widget.book_now_model!.inventory_data!.floor_no.toString()==""?"N/A":widget.book_now_model!.inventory_data!.floor_no.toString()),
                                  new SizedBox(height: 10,),

                                  Form_Title("Unit No.",""),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(widget.book_now_model!.inventory_data!.unit_no.toString()==""?"N/A":widget.book_now_model!.inventory_data!.unit_no.toString(),""),
                                  new SizedBox(height: 10,),



                                ],
                              ),),



                          ],
                        ),),
                        new SizedBox(height: 20,),

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color), child:new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [new Text("Location & Preference",style: Styles().styles_bold(16, ColorFile.white),)],),),
                              new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("View","Facing"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(widget.book_now_model!.inventory_data!.view.toString()==""?"N/A":widget.book_now_model!.inventory_data!.view.toString(),widget.book_now_model!.inventory_data!.facing.toString()==""?"N/A":widget.book_now_model!.inventory_data!.facing.toString()),
                                  new SizedBox(height: 10,),



                                  // Form_Title2("Furnishing Status"),
                                  // new SizedBox(height: 5,),
                                  // Form_Title2_content(rm_list[index].furnishing_type.toString()==""?"N/A":rm_list[index].furnishing_type.toString()),
                                  // new SizedBox(height: 10,),



                                ],
                              ),),



                          ],
                        ),),
                        new SizedBox(height: 20,),

                        new Container(decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),border: new Border.all(width: 1,color: ColorFile.hint_color),),child: new Column(
                          children: [
                            new Container(height: 40,decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.app_color), child:new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [new Text("Payment",style: Styles().styles_bold(16, ColorFile.white),)],),),
                            new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  Form_Title("Payment Plan","Payment Type"),
                                  new SizedBox(height: 5,),
                                  Form_Title_content(widget.book_now_model!.inventory_data!.plan_name.toString()==""?"N/A":widget.book_now_model!.inventory_data!.plan_name.toString(),widget.book_now_model!.inventory_data!.payment_type.toString()==""?"N/A":widget.book_now_model!.inventory_data!.payment_type.toString()),
                                  new SizedBox(height: 10,),




                                  //
                                  // Form_Title("Booking Amount Type","Booking Amount"),
                                  // new SizedBox(height: 5,),
                                  // Form_Title_content(rm_list[index].booking_amount_type.toString()==""?"N/A":rm_list[index].booking_amount_type.toString()=="1"?"Fixed":"Percentage",rm_list[index].booking_amount.toString()==""?"N/A":rm_list[index].booking_amount.toString()),
                                  // new SizedBox(height: 10,),
                                  //
                                  //
                                  // Form_Title("Power Back Up","Plc & Other Charges"),
                                  // new SizedBox(height: 5,),
                                  // Form_Title_content(rm_list[index].pow_backup.toString()==""?"N/A":rm_list[index].pow_backup.toString(),rm_list[index].plc.toString()==""?"N/A":rm_list[index].plc.toString()),
                                  // new SizedBox(height: 10,),
                                  //
                                  //
                                  // Form_Title("Discount Type","Discount(₹/%)"),
                                  // new SizedBox(height: 5,),
                                  // Form_Title_content(rm_list[index].discount_type.toString()==""?"N/A":rm_list[index].discount_type.toString()=="1"?"Fixed":"Percentage",rm_list[index].discount_amount.toString()==""?"N/A":rm_list[index].discount_amount.toString()),
                                  // new SizedBox(height: 10,),
                                  //
                                  //
                                  // Form_Title2("Approximate Cost after Builder & Broker Discount(₹)"),
                                  // new SizedBox(height: 5,),
                                  // Form_Title2_content(rm_list[index].cost.toString()==""?"N/A":rm_list[index].cost.toString()),
                                  // new SizedBox(height: 10,),
                                  // if(rm_list[index].cost.toString().length>0)new Container(
                                  //       margin: EdgeInsets.only(top: 10),
                                  //       child:new Row(
                                  //         crossAxisAlignment: CrossAxisAlignment.end,
                                  //         mainAxisAlignment: MainAxisAlignment.end,
                                  //         children: [
                                  //           new Text(AppUtils.convertCurrency(rm_list[index].cost.toString()),style: new TextStyle(fontSize: 17,fontFamily: "regular"),)
                                  //
                                  //         ],
                                  //       )
                                  //   ),
                                  new SizedBox(height: 10,),

                                ],
                              ),),



                          ],
                        ),),
                        new SizedBox(height: 20,),

                        new Container(
                          margin: EdgeInsets.all(10),
                          decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.bgs),
                          padding: EdgeInsets.all(10),
                          child: new Column(
                            children: [

                              new Container(child: new Row(
                                children: [
                                  Expanded(child: new Container(child: new Text("Super Area",style: Styles().styles_medium(16, ColorFile.black),),)),
                                  new Container(child: new Text(widget.book_now_model!.inventory_data!.super_area.toString()+" Sq.ft.",style: Styles().styles_medium(16, ColorFile.hint_color),),)



                                ],
                              ),),

                              //
                              new SizedBox(height: 10,),
                              new Container(child: new Row(
                                children: [
                                  Expanded(child: new Container(child: new Text("Carpet Area",style: Styles().styles_medium(16, ColorFile.black),),)),
                                  new Container(child: new Text(widget.book_now_model!.inventory_data!.carpet_area.toString()+" Sq.ft.",style: Styles().styles_medium(16, ColorFile.hint_color),),)



                                ],
                              ),),
                              //
                              new SizedBox(height: 10,),
                              new Container(child: new Row(
                                children: [
                                  Expanded(child: new Container(child: new Text("BSP per Sq.ft.",style: Styles().styles_medium(16, ColorFile.black),),)),
                                  new Container(child: new Text("₹ "+widget.book_now_model!.inventory_data!.bsp.toString(),style: Styles().styles_medium(16, ColorFile.hint_color),),)



                                ],
                              ),),


                              new SizedBox(height: 10,),
                              new Container(child: new Row(
                                children: [
                                  Expanded(child: new Container(child: new Text("View",style: Styles().styles_medium(16, ColorFile.black),),)),
                                  new Container(child: new Text(widget.book_now_model!.inventory_data!.view.toString(),style: Styles().styles_medium(16, ColorFile.hint_color),),)



                                ],
                              ),),

                              new SizedBox(height: 10,),
                              new Container(child: new Row(
                                children: [
                                  Expanded(child: new Container(child: new Text("Facing",style: Styles().styles_medium(16, ColorFile.black),),)),
                                  new Container(child: new Text(widget.book_now_model!.inventory_data!.facing.toString(),style: Styles().styles_medium(16, ColorFile.hint_color),),)



                                ],
                              ),),
                              new SizedBox(height: 10,),
                              new Container(child: new Row(
                                children: [
                                  Expanded(child: new Container(child: new Text("BSP Amount(₹)",style: Styles().styles_medium(16, ColorFile.black),),)),
                                  new Container(child: new Text("₹ "+AppUtils().calculate_bsp(widget.book_now_model!.inventory_data!.bsp.toString(),widget.book_now_model!.inventory_data!.super_area.toString()),style: Styles().styles_medium(16, ColorFile.hint_color),),)
                                ],
                              ),),



                            ],
                          ),
                        ),



                        Widget_Extra_Charges_Details(widget.book_now_model!.inventory_data!.extra_charges_details,true,on_click: (int){
                          show_calcualtion_value(int);
                        },),
                        Other_Charges_List_widget(widget.book_now_model!.inventory_data!.other_charges_details),
                        Aminities_Charges_List_widget(widget.book_now_model!.inventory_data!.aminities_charges_details),



















                      ],
                    )





                  ],),

                ),
              ),




            ],
          ),
        ),
        if(update)Center(child: new CircularProgressIndicator(),)

      ],
    ),
        bottomNavigationBar:
        Bottom_Button("Hold Now",onclick: (value){
          push();
        },)

    );
  }

  Future<void> show_calcualtion_value(int inx) async {
    var value=await All_Bottom_Sheets().show_area(widget.book_now_model!.inventory_data!.extra_charges_details[inx].addOnChargableType.toString()=="1"?Generate_Grid().generate_quanity_int():Generate_Grid().generate_quanity(), "", context);
    if(value!=null){
      widget.book_now_model!.inventory_data!.extra_charges_details[inx].edit_qty=value.toString();
      setState(() {

      });

      sumfor_extra();
    }


  }







  Future<void> sumfor_extra() async {
    try{
      sum=0;
      widget.book_now_model!.inventory_data!.extra_charges_details.forEach((element) {
        sum=sum+(double.parse(element.edit_qty)*double.parse(element.charge_amount));
      });
    }catch(e){

    }

    setState(() {

    });



  }

  void navigation() {
    unit_no_list.clear();


        Book_Now_all_Tower_Model model=Book_Now_all_Tower_Model(tower_id: widget.book_now_model!.inventory_data!.tower_no.toString(),
        tower_name: widget.book_now_model!.inventory_data!.tower_name.toString(), name: "", super_area: widget.book_now_model!.inventory_data!.super_area.toString(),
        carpet_area: widget.book_now_model!.inventory_data!.carpet_area.toString(), unit_id: widget.book_now_model!.inventory_data!.unit_id.toString(),
        floor: widget.book_now_model!.inventory_data!.floor_no.toString(), unit_name_number: widget.book_now_model!.inventory_data!.unit_no.toString(),
        price: "", unit_status: "0", inventory_id: widget.book_now_model!.inventory_data!.inventory_id.toString(),
        space_id: "", unit_location: widget.book_now_model!.inventory_data!.facing.toString(),
        facing_name: widget.book_now_model!.inventory_data!.facing.toString(),
        total_unit_price: widget.book_now_model!.inventory_data!.total_unit_price.toString(),
        mandatoryPriceTotalWithBsp: widget.book_now_model!.inventory_data!.mandatoryPriceTotalWithBsp.toString(),
        mandatoryPriceTotalWithOutBsp: widget.book_now_model!.inventory_data!.mandatoryPriceTotalWithOutBsp.toString(),
        extra_charges_details: widget.book_now_model!.inventory_data!.extra_charges_details,
        other_charges_details: widget.book_now_model!.inventory_data!.other_charges_details,
        aminities_charges_details: widget.book_now_model!.inventory_data!.aminities_charges_details);

        model.bsp_super_area=AppUtils().calculate_bsp(widget.book_now_model!.inventory_data!.bsp.toString(),widget.book_now_model!.inventory_data!.super_area.toString());
        model.is_checked=true;





    // model!.tower_id=widget.book_now_model!.inventory_data!.tower_no.toString();
    // model!.tower_name=widget.book_now_model!.inventory_data!.tower_name.toString();
    // model!.super_area=widget.book_now_model!.inventory_data!.super_area.toString();
    // model!.carpet_area=widget.book_now_model!.inventory_data!.carpet_area.toString();
    //
    // model!.unit_id=widget.book_now_model!.inventory_data!.unit_id.toString();
    // model!.floor=widget.book_now_model!.inventory_data!.floor_no.toString();
    // model!.unit_name_number=widget.book_now_model!.inventory_data!.unit_no.toString();
    // model!.inventory_id=widget.book_now_model!.inventory_data!.inventory_id.toString();
    //
    // model!.unit_location=widget.book_now_model!.inventory_data!.view.toString();
    // model!.facing_name=widget.book_now_model!.inventory_data!.facing.toString();
    //
    // model!.is_checked=true;
    // model!.sum=sum;
    // model!.total_unit_price=widget.book_now_model!.inventory_data!.total_unit_price.toString();
    // model!.mandatoryPriceTotalWithBsp=widget.book_now_model!.inventory_data!.mandatoryPriceTotalWithBsp.toString();
    // model!.mandatoryPriceTotalWithOutBsp=widget.book_now_model!.inventory_data!.mandatoryPriceTotalWithOutBsp.toString();
    // model.extra_charges_details=widget.book_now_model!.inventory_data!.extra_charges_details;
    // model.other_charges_details=widget.book_now_model!.inventory_data!.other_charges_details;
    // model.aminities_charges_details=widget.book_now_model!.inventory_data!.aminities_charges_details;

    unit_no_list.add(model);



      Online_Model online_model=new Online_Model();
      online_model.unit_no_list=unit_no_list;

    online_model.tower_no=widget.book_now_model!.inventory_data!.tower_name.toString();
      online_model.floor_no=widget.book_now_model!.inventory_data!.floor_no.toString();
      online_model.unit_type=widget.book_now_model!.inventory_data!.unit_type.toString();
      online_model.unit_no=widget.book_now_model!.inventory_data!.unit_no.toString();
      online_model.bsp_amount=widget.book_now_model!.inventory_data!.bsp_unit.toString();
      online_model.super_area=widget.book_now_model!.inventory_data!.unit_area.toString();
      online_model.payment_plan=widget.book_now_model!.inventory_data!.plan_name.toString();
      online_model.extra_charges_details=widget.book_now_model!.inventory_data!.extra_charges_details;
      online_model.other_charges_details=widget.book_now_model!.inventory_data!.other_charges_details;
      online_model.aminities_charges_details=widget.book_now_model!.inventory_data!.aminities_charges_details;
      online_model.mandatoryPriceTotalWithBsp=widget.book_now_model!.inventory_data!.mandatoryPriceTotalWithBsp;
      online_model.mandatoryPriceTotalWithOutBsp=widget.book_now_model!.inventory_data!.mandatoryPriceTotalWithOutBsp;
      online_model.calculated_bsp=AppUtils().calculate_bsp(widget.book_now_model!.inventory_data!.bsp.toString(),widget.book_now_model!.inventory_data!.super_area.toString());
      online_model.carpet_area=widget.book_now_model!.inventory_data!.carpet_area.toString();
      try{
        online_model.total_unit_price=widget.book_now_model!.inventory_data!.total_unit_price;
      }catch(e){

      }
      print(online_model.total_unit_price);
      online_model.term_condition=widget.book_now_model!.inventory_data!.term_condition.toString();
      online_model.inventory_id=widget.book_now_model!.inventory_data!.inventory_id.toString();
      online_model.plan_id=widget.book_now_model!.inventory_data!.payment_plan_id.toString();
      widget.book_now_model!.online_model=online_model;
      var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Form_Booking(widget.book_now_model!)));



  }

  push() async {
    setState(() {
      update=true;
    });
    Map data = {"inventory_details_id": widget.book_now_model!.inventory_data!.inventory_id.toString()};
    var response=await Global_connection().post_method(data, context, API.get_show_inventory_details);
    print(response.toString());
    if(response!=null&&response.data!=null&& response.statusCode == 200){
      if(response.data["data"]!=null&&response.data["data"]["unit_status"]!=null){
        if(response.data["data"]["unit_status"].toString()=="0"){
          navigation();
        }else if(response.data["data"]["unit_status"].toString()=="1"){
          AppUtils.toAst("Unit Already Sold..!!", context);
        }else if(response.data["data"]["unit_status"].toString()=="2"){
          AppUtils.toAst("Unit Already Hold..!!", context);
        }else if(response.data["data"]["unit_status"].toString()=="3"){
          AppUtils.toAst("Unit Already Booked..!!", context);
        }

      }else{
        AppUtils.toAst("Unable to Hold this inventory", context);
      }


  }
    setState(() {
      update=false;
    });

  }

  Future<void> create_log() async {
    await  FireBase_Logs().log_screen_view("Inventory Booking Form", "Inventory Booking Form");

  }


}