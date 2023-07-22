




import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/Bottom_Button.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../../API/API.dart';
import '../../Color/ColorFile.dart';
import '../../Global_connection/Global_connection.dart';
import '../../Models/Master_Model.dart';
import '../../Models/Tower_Model.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../Utils/AppUtils.dart';
import '../../widgets/Book_Now_Unit_Type_Sheet.dart';
import '../../widgets/Form_Drop_Down.dart';
import '../Funding_Source_Sheet.dart';

class Other_Bookings extends StatefulWidget{
  String property_id="";
  Other_Bookings(String property_id){
    this.property_id=property_id;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Buildstate();
  }

}
class Buildstate extends State<Other_Bookings>{
  final unit_type=TextEditingController();
  final area=TextEditingController();
  final budget=TextEditingController();
  final bank_detail_required=TextEditingController();
  final facing_text=TextEditingController();
  final viewText=TextEditingController();
  final notes=TextEditingController();






  List<Book_Now_Unit_Type_Models>property_unit_type_list=[];
  bool update=false;

  List<Master_Model>funding_source=[];

  List<Master_Model>facing=[];
  List<Master_Model>view=[];


  String unit_id="";
  String source_id="";
  String facing_id="";
  String view_id="";




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppUtils.appBar(context, "Booking"),
        body: new Stack(
        children: [
        new SingleChildScrollView(
          child: new Column(
            children: [
              
              new Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
                child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Expanded(child: new Container(alignment: Alignment.center,child: new Text("Please let us know your exact Requirement.",style:Styles().styles_bold(17, Colors.black),),))

                ],
              ),),
              Form_Drop_Down("Unit Type", unit_type, 100, false, true, on_slected: () {
                server_get_unit_type();
              },),
              Form_Fields().book_numric("Unit Size (Sq.Ft.)", area, 100, true, false,),
              Form_Fields().book_numric("Budget(₹)", budget, 10, true, false,),

              Form_Drop_Down("Funding Source", bank_detail_required, 100, false, true, on_slected: () {get_masters(1);},),
              Form_Drop_Down("Facing", facing_text, 100, false, true, on_slected: () {

                get_masters(2);

              },),

              Form_Drop_Down("View", viewText, 100, false, true, on_slected: () {

                get_masters(3);

              },),


             new Container(child:  FDottedLine(

               color: ColorFile.black,
               height: 250.0,
               width: MediaQuery.of(context).size.width,
               strokeWidth: 1.0,
               dottedLength: 10.0,
               space: 2.0,
               child: descr("Notes", notes),
             ),margin: EdgeInsets.all(10),)

            ],
          ),
        ),
        if(update)Center(child: new CircularProgressIndicator(),)


      ],
    ),
        bottomNavigationBar:Bottom_Button("Submit",onclick: (value){

          if(validate()){
            submit();
          }





        },));



  }
  void server_get_unit_type() {
    AppUtils().showProgressDialog(context);
    var map = new Map<String, dynamic>();
    map['property_id'] =widget. property_id.toString();
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
                  setState(() {
                    unit_type.text=property_unit_type_list[value].type;
                    unit_id=property_unit_type_list[value].id;

                    // approx_area.text=property_unit_type_list[value].super_area;

                  });



                }


              },),
          );
        });

  }

  get_masters(int pos) async {
    setState(() {
      update = true;
    });
    ServiceConfig().getApiAuth(API.all_master_datas, context).then((value) {
      Response response = value;
      setState(() {
        update = false;
      });
      if (response != null && response.statusCode == 200) {

        if(pos==1){
          var pur = response.data["list"]["funding"] as List;
          funding_source = pur.map<Master_Model>((json) => Master_Model.fromJson(json)).toList();
          Show_funding_Sheet();
        }
        if(pos==2){
          var face = response.data["list"]["facing_view"] as List;
          facing = face.map<Master_Model>((json) => Master_Model.fromJson(json)).toList();
          Show_facing_Sheet();

        }
        if(pos==3){
          var vie = response.data["list"]["lead_facing"] as List;
          view = vie.map<Master_Model>((json) => Master_Model.fromJson(json)).toList();
          Show_view_Sheet();

        }








      }
    }).catchError((error, stackTrace) {
      setState(() {
        AppUtils.toAst("Something Went Wrong..",context);
        update = false;

      });
    });
  }

  void Show_funding_Sheet() {
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
              child:Funding_Source_Sheet(funding_source,bank_detail_required.text,onSelectionChanged: (Master_Model value){
                setState(() {
                  bank_detail_required.text=value.name;
                  source_id=value.id;
                  // funding_id=value.id;

                });

              },)

          );
        });


  }

  void Show_facing_Sheet() {
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
              child:Funding_Source_Sheet(facing,facing_text.text,onSelectionChanged: (Master_Model value){
                setState(() {
                  facing_text.text=value.name;
                  facing_id=value.id;
                  // funding_id=value.id;

                });

              },)

          );
        });


  }
  void Show_view_Sheet() {
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
              child:Funding_Source_Sheet(view,viewText.text,onSelectionChanged: (Master_Model value){
                setState(() {
                  viewText.text=value.name;

                  view_id=value.id;

                  // funding_id=value.id;

                });

              },)

          );
        });


  }


  Future<void> submit() async {

    var  map=new Map<String, dynamic>();

    map['type'] =unit_id.toString();

    map['property_id'] =widget.property_id.toString();
    map['unit_area'] =area.text.toString();
    map['budget'] =budget.text.toString();
    map['funding_source_id'] =source_id.toString();
    map['facing'] =facing_id.toString();
    map['view'] =view_id.toString();
    map['notes'] =notes.text.toString();



    print(json.encode(map));

    setState(() {
      update=true;
    });


    FormData formData = new FormData.fromMap(map);

   var  response=await Global_connection().post_method(formData, context, API.SaveLeadRequirementDetail);
    if(response!=null&&response.data!=null&&response.statusCode==200){

      var data=await All_Bottom_Sheets().Success_dialog( "We have received your requirement and our Executive will get in touch with you shortly. ", context);
    if(data!=null && data==true){
      Navigator.pop(context,"success");
    }



    }
    setState(() {
      update=false;
    });


  }
  Widget descr(String hint, TextEditingController controller) {
    return Container(
      height: 100,
      child: TextField(
        controller: controller,
        enabled: true,
        maxLength: 100,

        style: TextStyle(fontSize: 14, fontFamily: "medium", color: Colors.black),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            hintStyle: TextStyle(
                fontSize: 14, fontFamily: "medium", color: Colors.grey),
            hintText: hint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }

  bool validate() {
    if(unit_type.text.toString().length==0){
      AppUtils.toAst("Please Select Unit Type..!!", context);

      return false;
    } if(budget.text.toString().length==0){
      AppUtils.toAst("Please Enter Budget..!!", context);

      return false;
    }if(area.text.toString().length==0){
      AppUtils.toAst("Please Enter Unit Area..!!", context);

      return false;
    }

    return true;

  }

}