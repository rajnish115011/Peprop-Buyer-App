

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Form_Booking.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Online_Booking.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Online_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Unit_Type_Sheet.dart';
import 'package:peprop_consumer_app/Models/Customer_Detail_Model.dart';
import 'package:peprop_consumer_app/Piker/Payment_Plan_Picker.dart';
import 'package:peprop_consumer_app/widgets/Book_Noew_Button.dart';
import 'package:peprop_consumer_app/widgets/Form_Title.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:readmore/readmore.dart';
import '../../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../../Requirements/Widget_Extra_Charges_Details.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Generate_Grid.dart';
import '../../widgets/Other_Charges_List_widget.dart';
import '../../widgets/Quantity_Sheet.dart';
import '../Booking/Extra_charges_details.dart';
import '../Form_Property_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Property_Image_Widget.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/City_Model.dart';
import 'package:peprop_consumer_app/Search/Search_City.dart';
import 'package:peprop_consumer_app/Sheets/Gender_Sheet.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';
import 'package:peprop_consumer_app/widgets/Widget_Detail_Page_Image_Logo.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Models/Tower_Model.dart';
import '../../Models/User_Model.dart';
import '../../Piker/ListThemeData.dart';
import '../../Piker/Tower_Piker.dart';
import '../../widgets/Form_Drop_Down.dart';
import '../../widgets/Property_Title_Address.dart';
import '../Floor_No_Sheet.dart';
import '../Payment_Option.dart';
import 'Saving_discount_widget.dart';


class Preview_Class extends StatefulWidget{
  Book_Now_Model? book_now_model;
  Preview_Class(Book_Now_Model book_now_model){
    this.book_now_model=book_now_model;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return States();
  }

}


class States extends State<Preview_Class> {




  final tower = TextEditingController();
  final floor_no = TextEditingController();
  final unit_type = TextEditingController();
  final unit_no = TextEditingController();
  final payment_plan = TextEditingController();
  final amt = TextEditingController();
  final super_area = TextEditingController();

  List<Extra_charges_details>extra_charges_details=[];
  List<Other_charges_details>other_charges_details=[];
  List<AmenitiesPrice_details>aminities_charges_details=[];



    bool is_checked=false;

    int selected=0;

  List<Book_Now_all_Tower_Model>unit_no_list=[];

  @override
  void initState() {
    super.initState();
    if(widget.book_now_model!.form_property_model!.booking_option=="1"){
      setvalue();
    }

    create_log();


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppUtils.appBar(context, "title"),
      body: new Stack(
        children: [
              SingleChildScrollView(
              child: new Column(
              children: [
                Property_Image_Widget(widget.book_now_model!.form_property_model!.image, widget.book_now_model!.form_property_model!.rera, widget.book_now_model!.form_property_model!.logo),
                Property_Title_Address(widget.book_now_model!.form_property_model!.property_title,widget.book_now_model!.form_property_model!.addess),

                new Container(
                  child: new Column(
                    children: [

                      new Container(

                       
                        margin: EdgeInsets.all(10),
                        child: new Column(
                          children: [
                            new Container(height: 50,child:   new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Container(child: new Text("Customer details",style: new TextStyle(fontFamily: "medium",fontSize: 17,color: ColorFile.white),),),

                              ],
                            ),decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.selectd_color),),

                            new Container(
                              padding: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  color: ColorFile.bgs

                              ),
                              
                              child: new Column(
                              children: [
                                new SizedBox(height: 10,),
                                Form_Title("Full Name","Father's Name"),
                                new SizedBox(height: 5,),
                                Form_Title_content(widget.book_now_model!.customer_detail_model!.full_name.toString(),widget.book_now_model!.customer_detail_model!.father_name.toString()),
                                new SizedBox(height: 10,),
                                Form_Title("Gender","Funding Source"),
                                new SizedBox(height: 5,),
                                Form_Title_content(widget.book_now_model!.customer_detail_model!.gender_name.toString(),widget.book_now_model!.customer_detail_model!.is_bank.toString()),
                                new SizedBox(height: 10,),

                                Form_Title("DOB","Address"),
                                new SizedBox(height: 5,),
                                Form_Title_content(AppUtils.change_date_format(widget.book_now_model!.customer_detail_model!.dob.toString()),widget.book_now_model!.customer_detail_model!.address.toString()),
                                new SizedBox(height: 10,),

                                Form_Title("City","Pan"),
                                new SizedBox(height: 5,),
                                Form_Title_content(widget.book_now_model!.customer_detail_model!.city.toString(),widget.book_now_model!.customer_detail_model!.pan.toString().toUpperCase()),
                                new SizedBox(height: 10,),

                                Form_Title("Co-Applicant Name",""),
                                new SizedBox(height: 5,),
                                Form_Title_content(widget.book_now_model!.customer_detail_model!.co_name.toString(),""),
                                new SizedBox(height: 10,),
                              ],
                            ),)

                           

                         




                          ],
                        ),
                      ),
                    ],
                  ),
                ),





                if(widget.book_now_model!.form_property_model!.booking_option=="1")
                  new Column(
                  children: [



                    if(unit_no_list.length>1)new Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child:  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: unit_no_list.length,
                      itemBuilder: (context, i){
                        return new Column(
                          children: [
                            InkWell(onTap: (){
                          setState(() {
                            selected=i;
                          });

                        },child:Container(padding: EdgeInsets.only(left: 20,right: 20),decoration: new BoxDecoration(color: i!=selected?ColorFile.white:ColorFile.selectd_color,borderRadius: new BorderRadius.circular(30),border: new Border.all(width: 1,color:i!=selected?ColorFile.hint_color:ColorFile.white)),margin: EdgeInsets.only(right: 10),alignment: Alignment.center,height: 40,child: new Text("Booking "+(i+1).toString(),style: Styles().styles_regular(12,i!=selected? Colors.black:ColorFile.white),)))

                        ],
                        );



                      },
                    ),height: 45,),




                    new Container(
                      child: new Column(
                        children: [
                          new Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            height: 50,child:   new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Container(child: new Text("Inventory details",style: new TextStyle(fontFamily: "medium",fontSize: 17,color: ColorFile.white),),),

                            ],
                          ),decoration: new BoxDecoration(borderRadius: new BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),color: ColorFile.selectd_color),),
                          new Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(left: 10,right: 10),
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(10),
                                color: ColorFile.bgs),
                            child: new Column(
                              children: [
                                new SizedBox(height: 10,),

                                Form_Title("Tower Name","Floor No."),
                                new SizedBox(height: 5,),
                                Form_Title_content(tower.text.toString(),floor_no.text.toString()),
                                new SizedBox(height: 10,),

                                Form_Title("Unit Type","Unit No."),
                                new SizedBox(height: 5,),
                                Form_Title_content(unit_type.text.toString(),unit_no_list[selected].unit_name_number.toString()),
                                new SizedBox(height: 10,),

                                Form_Title("BSP Amount(₹)","Super Area"),
                                new SizedBox(height: 5,),
                                Form_Title_content("₹ "+AppUtils().calculate_bsp(unit_no_list[selected].bsp_super_area.toString(),unit_no_list[selected].super_area.toString()),unit_no_list[selected].super_area.toString()+" Sq.ft."),
                                new SizedBox(height: 10,),

                                Form_Title("Carpet Area","Payment Plan"),
                                new SizedBox(height: 5,),
                                Form_Title_content(unit_no_list[selected].carpet_area.toString()+" Sq.ft.",payment_plan.text.toString()),
                                new SizedBox(height: 10,),
                              ],
                            ),
                          ),



                          if(unit_no_list.length>0)new Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [




                                Widget_Extra_Charges_Details(unit_no_list[selected].extra_charges_details,false,on_click: (int){

                                  add_quantity(int, selected);


                                },),



                                Other_Charges_List_widget(unit_no_list[selected].other_charges_details),
                                Aminities_Charges_List_widget(unit_no_list[selected].aminities_charges_details),



                              ],
                            ),),
                        ],
                      ),
                    ),
                    

                    if(widget.book_now_model!.form_property_model!.booking_option=="1")Saving_discount_widget(widget.book_now_model!.online_model,widget.book_now_model!.form_property_model!.view_property_model,unit_no_list[selected]),


                  ],
                ),

                


                new Container(margin: EdgeInsets.only(top: 20),child: new Text("Terms & Conditions",style: Styles().styles_bold(20, ColorFile.green),),),
                if(widget.book_now_model!.online_model!=null&&widget.book_now_model!.online_model!.term_condition.toString().length>0)new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10),
                            color: ColorFile.bgs
                        ),
                        margin: EdgeInsets.all(10),
                        child: new Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: ReadMoreText(
                                Styles.stripHtmlIfNeeded(widget.book_now_model!.online_model!.term_condition.toString()),
                                trimLines:5 ,
                                style: new TextStyle(color: ColorFile.black,fontSize: 13,fontFamily: "regular"),
                                colorClickableText: ColorFile.app_color,
                                trimMode: TrimMode.Length,

                                moreStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                                lessStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                                trimCollapsedText: '...Read More',
                                trimExpandedText: '..show less',
                              ),
                            ),
                            // Expanded(child: new Container(child: new Text(Styles.stripHtmlIfNeeded(widget.book_now_model!.online_model!.term_condition.toString()),style: Styles().styles_regular(14, ColorFile.hint_color),),))
                          ],
                        )


                    ),

                  ],
                ),
                if(widget.book_now_model!.form_property_model!.booking_option.toString()=="2"&&widget.book_now_model!.form_property_model!.view_property_model!.booking_term_cond.toString().length>0)new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10),
                            color: ColorFile.bgs
                        ),
                        margin: EdgeInsets.all(10),
                        child: new Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: ReadMoreText(
                                Styles.stripHtmlIfNeeded(widget.book_now_model!.form_property_model!.view_property_model!.booking_term_cond.toString()),
                                trimLines: 5,
                                style: new TextStyle(color: ColorFile.black,fontSize: 13,fontFamily: "regular"),
                                colorClickableText: ColorFile.app_color,
                                trimMode: TrimMode.Line,
                                moreStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                                lessStyle: new TextStyle(color: ColorFile.app_color,fontSize: 13,fontFamily: "bold"),
                                trimCollapsedText: '...Read More',
                                trimExpandedText: '..show less',
                              ),
                            ),
                          ],
                        )


                    ),

                  ],
                ),

                InkWell(child: new Container(
                  margin: EdgeInsets.all(10),
                  child: new Row(
                    children: [
                      Icon(is_checked?Icons.check_box:Icons.check_box_outline_blank,color: ColorFile.app_color,),
                      new SizedBox(width: 10,),
                      new Text("I accept above terms & conditions",style: Styles().styles_bold(14, ColorFile.app_color),)
                    ],
                  ),
                ),onTap: (){
                  setState(() {
                    is_checked=!is_checked;
                  });
                },)




              ],
            ),
          )
        ],
      ),
        bottomNavigationBar:Bottom_Button("Next",onclick: (value){
        if(is_checked){
          showAlertDialog(context, "Are you Sure. You want to book now ?", "Confirmation");
        }else{
          AppUtils.toAst("Please Accept Terms & Conditions",context);
        }
      },));



  }

  Future<void> sumfor_extra(int index) async {
    try{
      double sum=0;
      unit_no_list[index].extra_charges_details.forEach((element) {
        sum=sum+(double.parse(element.edit_qty)*double.parse(element.charge_amount));
        unit_no_list[index].sum=sum;
      });
    }catch(e){

    }

    setState(() {

    });



  }
  void showAlertDialog(BuildContext ctx, message, title) {
    showCupertinoDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: new TextStyle(fontFamily: "medium", fontSize: 15),
            ),
            content: Text(
              message,
              style: new TextStyle(fontFamily: "regular", fontSize: 12),
            ),
            actions: [
              // The "Yes" button
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  'No',
                  style: new TextStyle(fontFamily: "medium", fontSize: 15),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  Navigator.pop(ctx);
                  var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Payment_Option(widget.book_now_model!)));

                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: "medium",
                    fontSize: 15,
                  ),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }







  void setvalue() {
    tower.text=widget.book_now_model!.online_model!.tower_no.toString();
    floor_no.text=widget.book_now_model!.online_model!.floor_no.toString();
    unit_type.text=widget.book_now_model!.online_model!.unit_type.toString();
    unit_no.text=widget.book_now_model!.online_model!.unit_no.toString();
    amt.text=widget.book_now_model!.online_model!.bsp_amount.toString();
    amt.text=widget.book_now_model!.online_model!.bsp_amount.toString();
    super_area.text=widget.book_now_model!.online_model!.super_area.toString();
    payment_plan.text=widget.book_now_model!.online_model!.payment_plan.toString();
    extra_charges_details=widget.book_now_model!.online_model!.extra_charges_details;
    other_charges_details=widget.book_now_model!.online_model!.other_charges_details;
    aminities_charges_details=widget.book_now_model!.online_model!.aminities_charges_details;

    widget.book_now_model!.online_model!.unit_no_list.forEach((element) {
      if(element.is_checked){
        unit_no_list.add(element);
      }

    });






  }

  void add_quantity(int sub_index, int index) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
        context: context,
        builder: (context) {
          return new Container(
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child:Quantity_Sheet(unit_no_list[index].extra_charges_details[sub_index].addOnChargableType=="2"?Generate_Grid().generate_quanity():Generate_Grid().generate_quanity_int(),unit_no_list[index].extra_charges_details[sub_index].unit_name.toString(),onSelectionChanged: (String value){
                unit_no_list[index].extra_charges_details[sub_index].edit_qty=value.toString();
                sumfor_extra(index);

              },)

          );
        });



  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Book Now Preview", "Book Now Preview");

  }


}