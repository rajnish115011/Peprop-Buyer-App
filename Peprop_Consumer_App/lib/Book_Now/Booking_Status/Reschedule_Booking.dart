

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Form_Booking.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Online_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Unit_Type_Sheet.dart';
import 'package:peprop_consumer_app/Models/Customer_Detail_Model.dart';
import 'package:peprop_consumer_app/Models/My_Booking_Models.dart';
import 'package:peprop_consumer_app/Piker/Payment_Plan_Picker.dart';
import 'package:peprop_consumer_app/widgets/Available_Area.dart';
import 'package:peprop_consumer_app/widgets/Book_Noew_Button.dart';
import 'package:peprop_consumer_app/widgets/Booking_Units.dart';
import 'package:peprop_consumer_app/widgets/Generate_Grid.dart';
import 'package:peprop_consumer_app/widgets/Quantity_Sheet.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import '../../Cost_Sheet/model/Builder_Detail_Model.dart';
import '../../Properties/Bottom_sheet_For_Unit_Type.dart';
import '../../Properties/Extra_json.dart';
import '../../Properties/Properties_Detail.dart';
import '../../Requirements/Widget_Extra_Charges_Details.dart';
import '../../Thanks/Thank_You_Booking.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Book_Now_Unit_Type_Sheet.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Custom_App_Button.dart';
import '../../widgets/My_Booking_Property.dart';
import '../../widgets/Other_Charges_List_widget.dart';
import '../../widgets/Sheet_For_Tower.dart';
import '../../widgets/Unitsss.dart';
import '../Booking/Book_Now_Model.dart';
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


class Reschedule_Booking extends StatefulWidget{

  My_Booking_Models? model;
  Reschedule_Booking( My_Booking_Models? model){

    this.model=model;


  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}class Build_State extends State<Reschedule_Booking> {


  List<dynamic>area_list=[];


  final tower = TextEditingController();
  final floor_no = TextEditingController();
  final unit_type = TextEditingController();
  final unit_no = TextEditingController();
  final payment_plan = TextEditingController();
  final amt = TextEditingController();
  final super_area = TextEditingController();
  final approx_area = TextEditingController();

  final location = TextEditingController();
  final facing = TextEditingController();





  List<dynamic>floor_list = [];




  List<Payments_Plans>payment_list = [];





  bool loading = false;

  String total_unit_price="";

  String term_condition="";


  List<Extra_charges_details>extra_charges_details=[];
  List<Other_charges_details>other_charges_details=[];
  List<AmenitiesPrice_details>aminities_charges_details=[];


  double sum=0;

  List<Book_Now_Unit_Type_Models>property_unit_type_list=[];
  List<Book_Now_all_Tower_Model>all_data_list=[];
  List<Book_Now_Tower_Model>Tower_list=[];
  List<Book_Now_all_Tower_Model>unit_no_list=[];




  Payments_Plans? payment_plan_model;
  Book_Now_all_Tower_Model? unit_detail_model;

  List<Payment_milestones>payment_milestones=[];


  @override
  void initState() {
    super.initState();
    create_log();

  }

  @override
  Widget build(BuildContext context) {
    if(unit_detail_model!=null){
      unit_no.text=unit_detail_model!.unit_name_number;


    }else{
      unit_no.text="";


    }
    return new Scaffold(
      appBar: AppUtils.appBar(context, "title"),
      body: new Stack(
        children: [
          loading == true
              ? Center(child: new CircularProgressIndicator(),)
              : SingleChildScrollView(
            child: new Column(
              children: [

                if(widget.model!=null) My_Booking_Property(widget.model,on_click: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Properties_Detail(widget.model!.property_id,"false")));

                },),

                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form_Drop_Down("Unit Type", unit_type, 100, false, true, on_slected: () {
                      server_get_unit_type();
                      },),
                    Form_Drop_Down("Select Size(Sq.ft.)", approx_area, 100, false, true, on_slected: () {
                      show_area();
                    },),
                    if(Tower_list.length==0) Custom_App_Button("Continue",onclick: (){
                      if(unit_type.text.length==0){
                        AppUtils.toAst("Please Select Unit Type..!!",context);
                      }else if(approx_area.text.length==0){
                        AppUtils.toAst("Please Select Size..!!",context);

                      }else{
                        get_space_details();

                      }
                    },)
                  ],
                ),


                if(Tower_list.length>0)new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form_Drop_Down("Tower", tower, 100, false, true, on_slected: () {
                         show_tower();
                        },),

                        Form_Drop_Down("Floor No.", floor_no, 100, false, true, on_slected: () {
                          if(tower.text.length==0){
                            AppUtils.toAst("Please Select Tower First..!!!",context);
                          }else{
                            show_floor_picker();
                          }

                        },),

                         if(unit_no_list.length>0) Booking_units(unit_no_list,unit_type.text.toString(),onclick: (model,index){

                            setState(() {
                              payment_plan.text="";
                              payment_plan_model=null;
                              term_condition="";
                              payment_milestones.clear();
                              extra_charges_details.clear();
                              other_charges_details.clear();
                              aminities_charges_details.clear();
                              unit_detail_model=model;
                            });
                          },),



                      

                        Form_Drop_Down("Payment Plan", payment_plan, 100, false, true, on_slected: () {
                          if(tower.text!=""&&unit_detail_model!=null){
                            get_payment_plan();
                          }else{
                            AppUtils.toAst("Please select Tower and Floor No.!!",context);


                          }


                        },),
                        Payment_Miles(payment_milestones),


                        Widget_Extra_Charges_Details(extra_charges_details,true,on_click: (int){
                          add_quantity(int);

                        },),



                        Other_Charges_List_widget(other_charges_details),


                        Aminities_Charges_List_widget(aminities_charges_details),





                      ],
                    ),),



                  ],
                ),
                if(Tower_list.length>0)BottomAppBar(child: Bottom_Button("Next",onclick: (value){
                  navigation();

                },),)


                
                


              ],
            ),
          )
        ],
      ),
     );


  }
























  void get_inventory() {
    extra_charges_details.clear();
    other_charges_details.clear();
    aminities_charges_details.clear();
    total_unit_price="";
    AppUtils().showProgressDialog(context);
    var map = new Map<String, dynamic>();
    map['tower_id'] = unit_detail_model!.tower_id;
    map['inventory_id'] = unit_detail_model!.inventory_id;
    map['unit_id'] = unit_detail_model!.unit_id;
    map['unit_space_id'] = unit_detail_model!.space_id;
    FormData formData = new FormData.fromMap(map);
    print(json.encode(map));
    ServiceConfig().postApiBodyAuthJson(API.getUnitPriceDetails, formData, context).then((value) {
      Response response = value;
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
      if (response != null && response.statusCode == 200) {
        if(response.data["list"]["extra_charges_details"]!=null){
        var ext = response.data["list"]["extra_charges_details"] as List;
         extra_charges_details =ext.map<Extra_charges_details>((json) => Extra_charges_details.fromJson(json)).toList();

        }
        if(response.data["list"]["otherChargePrice"]!=null){
          var ext = response.data["list"]["otherChargePrice"] as List;
          other_charges_details =ext.map<Other_charges_details>((json) => Other_charges_details.fromJson(json)).toList();

        }
        if(response.data["list"]["AmenitiesPrice"]!=null){
          var ext = response.data["list"]["AmenitiesPrice"] as List;
          aminities_charges_details =ext.map<AmenitiesPrice_details>((json) => AmenitiesPrice_details.fromJson(json)).toList();

        }

        total_unit_price=response.data["list"]["total_unit_price"].toString();



      }
    }).catchError((onError){
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
    });



  }


  Future<void> sumfor_extra() async {
    try{
        sum=0;
        extra_charges_details.forEach((element) {
        sum=sum+(double.parse(element.edit_qty)*double.parse(element.charge_amount));
      });
    }catch(e){

    }

   setState(() {

   });



  }

  bool validate() {
    if(unit_type.text.toString().length==0){
      AppUtils.toAst("Please Select Unit Type..!!",context);
      return false;
    }
    if(payment_plan_model==null){
      AppUtils.toAst("Please Select Payment Plan..!!",context);
      return false;
    }
    if(unit_detail_model==null){
      AppUtils.toAst("Please Select Unit..!!",context);
      return false;
    }
    return true;
  }







  // getSpaceDetailsByPropId
  void server_get_unit_type() {












    AppUtils().showProgressDialog(context);
    var map = new Map<String, dynamic>();
    map['property_id'] = widget.model!.property_id.toString();
    print(map.toString());
    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.getTypeDetailsByPropId, formData, context).then((value) {
      Response response = value;
      print(response.data.toString());
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
      if (response != null && response.statusCode == 200&&response.data["unit_type_size"]!=null) {
        var notify = response.data["unit_type_size"] as List;
        property_unit_type_list = notify.map<Book_Now_Unit_Type_Models>((json) => Book_Now_Unit_Type_Models.fromJson(json)).toList();
        show_unit();


      }
    }).catchError((onError){
      AppUtils.toAst(onError.toString(),context);
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
    });



  }


  void get_space_details() {
    extra_charges_details.clear();
    other_charges_details.clear();
    aminities_charges_details.clear();

    AppUtils().showProgressDialog(context);
    var map = new Map<String, dynamic>();
    map['property_id'] = widget.model!.property_id.toString();
    map['size'] = approx_area.text.toString();
    map['name'] =unit_type.text.toString();
    FormData formData = new FormData.fromMap(map);
    print(json.encode(map));
    ServiceConfig().postApiBodyAuthJson(API.getSpaceDetailsByPropId, formData, context).then((value) {
      Response response = value;
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
      if (response != null && response.statusCode == 200) {


        var data = response.data["tower"] as List;

        Tower_list = data.map<Book_Now_Tower_Model>((json) => Book_Now_Tower_Model.fromJson(json)).toList();
        if(Tower_list.length==0){
          AppUtils.toAst("Tower Not Found with Select Unit Type.!!",context);

        }


        var notify = response.data["list"] as List;
        all_data_list = notify.map<Book_Now_all_Tower_Model>((json) => Book_Now_all_Tower_Model.fromJson(json)).toList();




      }
    }).catchError((onError){
      AppUtils.toAst(onError.toString(),context);
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
    });



  }
  void get_payment_plan() {

    AppUtils().showProgressDialog(context);
    var map = new Map<String, dynamic>();
    map['tower_id'] = unit_detail_model!.tower_id;

    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.getFloorList, formData, context).then((value) {
      Response response = value;
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
      if (response != null && response.statusCode == 200) {
        var notify = response.data["list"]["payment_plan"] as List;
        payment_list = notify.map<Payments_Plans>((json) => Payments_Plans.fromJson(json)).toList();
        payment_plan_picker(payment_list);

      }
    }).catchError((onError){
      AppUtils.toAst(onError.toString(),context);
      setState(() {
        Navigator.of(context, rootNavigator: true).pop("Discard");
      });
    });



  }

  void show_unit() {
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
            child:
            Book_Now_Unit_type_Sheet(property_unit_type_list,
              unit_type.text.toString(),onSelectionChanged: (value){
                if(value!=null){

                  approx_area.clear();
                  Tower_list.clear();
                  tower.text="";

                  payment_plan_model=null;
                  unit_detail_model=null;
                  clear_field();
                  setState(() {
                    unit_type.text=property_unit_type_list[value].type;
                    area_list=property_unit_type_list[value].area_list;

                  });



                }


              },),
          );
        });

  }
  void show_tower() {
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
            child:
            Sheet_For_Tower(Tower_list,
              tower.text.toString(),onSelectionChanged: (value){
                if(value!=null){
                  setState(() {
                    tower.text=Tower_list[value].name;


                    floor_list=Tower_list[value].floor_list;

                  });
                }
              },),
          );
        });

  }

  void show_floor_picker() {
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
              child:Floor_No_Sheet(floor_list,floor_no.text,onSelectionChanged: (value){
                setState(() {
                  floor_no.text=value.toString();

                  filter_unit_no();
                });

              },)

          );
        });





  }

  void unit_no_picker() {
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
              child:Unit_Type_Sheet(unit_no_list,unit_type.text,onSelectionChanged: (Book_Now_all_Tower_Model value){
                setState(() {
                  unit_detail_model=value;
                });

              },)

          );
        });



  }

  void add_quantity(int index) {
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
              child:Quantity_Sheet(extra_charges_details[index].addOnChargableType=="2"?Generate_Grid().generate_quanity():Generate_Grid().generate_quanity_int(),extra_charges_details[index].unit_name.toString(),onSelectionChanged: (String value){
                extra_charges_details[index].edit_qty=value.toString();
                sumfor_extra();

              },)

          );
        });



  }
  
  void payment_plan_picker(List<Payments_Plans> tower_list) {
    Payment_Plan_Picker(
      payment_list,
      context: context,
      countryListTheme: ListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 16, fontFamily: "medium", color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          inputDecoration: InputDecoration(
              labelText: 'Search Payment Plan',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2))))),
      onSelect: (Payments_Plans model) {
        setState(() {
          payment_plan.text=model.plan_name;
          payment_plan_model=model;
          term_condition=model.term_condition;
          payment_milestones=model.payment_milestones;
          get_inventory();


        });
      },
    );
  }
  void filter_unit_no() {



    unit_detail_model=null;



    unit_no_list.clear();
    unit_no_list = (all_data_list.where((i) => i.tower_name.toString() == tower.text.toString().toString()&& i.floor.toString() == floor_no.text.toString().toString()).toList());



}

  void clear_field() {
    floor_no.text="";
    floor_list.clear();

    unit_no_list.clear();
    unit_no.clear();

    payment_list.clear();
    payment_plan.text="";







  }

  void navigation() {
    if(validate()){
      update_invetory();


    }
  }

  Future<void> update_invetory() async {

    List<Map>list=[];
    Map<String, String> myMap =new Map();
    extra_charges_details.forEach((element) {
      myMap.putIfAbsent(element.amenity_id.toString(), () =>  element.edit_qty.toString());
      list.add( new Extra_json(element.amenity_id.toString(), element.edit_qty.toString()).TojsonData());

    });

    AppUtils().showProgressDialog(context);
    var map = new Map<String, dynamic>();
    map['property_id'] =widget.model!.property_id.toString();
    map['invid'] = unit_detail_model!.unit_id;
    map['planid'] =payment_plan_model!.id;
    map['prev_booking_id'] =widget.model!.id.toString();
    map['extra_charges'] = json.encode(list);
    FormData formData = new FormData.fromMap(map);
    Response response=await ServiceConfig().postApiBodyAuthJson(API.rebookingOnlineOfflineFormData, formData, context);
    Navigator.of(context, rootNavigator: true).pop("Discard");
    if(response!=null&& response.statusCode==200){
      AppUtils.toAst("Your Booking Request Successfully Done..!!",context);
      var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You_Booking()));
    }



  }
  void show_area() {
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
            child:
            Area_Sheet(area_list,
              approx_area.text.toString(),onSelectionChanged: (value){
                if(value!=null){
                  approx_area.clear();
                  Tower_list.clear();
                  tower.text="";
                  payment_plan_model=null;
                  unit_detail_model=null;
                  clear_field();
                  setState(() {
                    approx_area.text=area_list[value].toString();

                    // approx_area.text=property_unit_type_list[value].super_area;

                  });



                }


              },),
          );
        });

  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Reschedule Booking", "Reschedule Booking");

  }


}