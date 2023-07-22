

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Book_Now/Book_Now_Preview/Preview_Class.dart';
import 'package:peprop_consumer_app/Book_Now/Booking/Book_Now_Model.dart';
import 'package:peprop_consumer_app/Book_Now/Funding_Source_Sheet.dart';
import 'package:peprop_consumer_app/Book_Now/Unit_Type_Sheet.dart';
import 'package:peprop_consumer_app/Models/Customer_Detail_Model.dart';
import 'package:peprop_consumer_app/Piker/Payment_Plan_Picker.dart';
import 'package:peprop_consumer_app/widgets/Book_Noew_Button.dart';
import '../../Models/Master_Model.dart';
import '../../Models/Tower_Model.dart';
import '../../Models/User_Model.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Bottom_Button.dart';
import '../../widgets/Form_Drop_Down.dart';
import '../../widgets/Property_Title_Address.dart';

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


import '../Form_Property_Model.dart';
import '../Payment_Option.dart';


class Form_Booking extends StatefulWidget{
  Book_Now_Model? book_now_model;
  Form_Booking(Book_Now_Model book_now_model){
    this.book_now_model=book_now_model;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}class Build_State extends State<Form_Booking> {
  final full_name = TextEditingController();
  final co_name = TextEditingController();


  final father_Name = TextEditingController();
  final gender = TextEditingController();
  final martial_status = TextEditingController();
  final bank_detail_required = TextEditingController();
  final dob = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final pan = TextEditingController();
  final aadhar = TextEditingController();
  final tower = TextEditingController();
  final floor_no = TextEditingController();
  final unit_type = TextEditingController();
  final unit_no = TextEditingController();
  final payment_plan = TextEditingController();
  final amt = TextEditingController();


  List<Tower_Model>tower_list = [];
  List<dynamic>floor_list = [];




  List<Payments_Plans>payment_list = [];
  List<Unit_Type>unit_type_list = [];
  List<Unit_Type>unique_unit_type = [];




  bool loading = false;
  DateTime _selectedDate = DateTime.now();
  String tower_id="";
  String floor_id="";
  String unit_no_id="";
  String unit_type_id="";
  String payment_plan_id="";
  String city_id="";
  String state_id="";

  List<Master_Model>funding_source=[];

  bool update=false;
  String funding_id="";

  @override
  void initState() {
    super.initState();
    gender.text = "Male";
    get_user_details();
    create_log();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppUtils.appBar(context, "title"),
      body: new Stack(
        children: [
          loading == true
              ? Center(child: new CircularProgressIndicator(),)
              : SingleChildScrollView(
            child: new Column(
              children: [
                Property_Image_Widget(widget.book_now_model!.form_property_model!.image, widget.book_now_model!.form_property_model!.rera, widget.book_now_model!.form_property_model!.logo),
                Property_Title_Address(widget.book_now_model!.form_property_model!.property_title,widget.book_now_model!.form_property_model!.addess),
                Form_Fields().book_filed("Full Name", full_name, 50, false, false),
                Form_Fields().book_filed("Co- Applicant Name", co_name, 50, false, false),
                Form_Fields().book_filed("Father's Name", father_Name, 50, false, false),
                Form_Drop_Down("Gender", gender, 50, false, true, on_slected: () {show_gender();},),
                Form_Drop_Down("Funding Source", bank_detail_required, 50, false, true, on_slected: () {get_masters();},),
                Form_Drop_Down("DOB", dob, 50, false, true, on_slected: () {_selectDate();},),
                Form_Fields().book_filed("Address", address, 150, false, false),
                Form_Drop_Down(
                  "City", city, 50, false, true, on_slected: () async {
                  var pageResult = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Search_City()));
                  if (pageResult != null) {
                    setState(() {
                      City_Model model = pageResult;
                      city.text = model.city_name;
                      city_id = model.city_id;
                      state_id = model.state_id;


                    });
                  }
                },),
                Form_Fields().book_filed_capital("Pan Number", pan, 10, false, false),

              ],
            ),
          ),

          if(update)Center(child:new CircularProgressIndicator(),)

        ],
      ),
      bottomNavigationBar:
      Bottom_Button("Next",onclick: (value){
      navigation();
      },)






    );
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
                  var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Payment_Option(widget.book_now_model! )));

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
  void show_gender() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return new Container(decoration: new BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Gender_Sheet(
              gender.text.toString(), onSelectionChanged: (value) {
              if (value != null) {
                setState(() {
                  print(value);
                  gender.text = value;
                });
              }
            },),
          );
        });
  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Form Booking", "Form Booking");

  }

  Future<void> get_user_details() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences prefNew = await SharedPreferences.getInstance();
    String? user_id = prefNew.getString("user_id");
    var map = new Map<String, dynamic>();
    map['user_id'] = user_id.toString();

    FormData formData = new FormData.fromMap(map);
    try {
      ServiceConfig().postApiBodyAuthJson(API.usersList, formData, context).then((value) async {
        print("URL:" + user_id.toString());
        Response response = value;
        print(value.toString());
        setState(() {
          loading = false;
        });
        if (response != null && response.statusCode == 200) {
          var builder_details = response.data["list"];
          User_Model user_model = User_Model.fromJson(builder_details);
          if (user_model != null) {
            full_name.text = user_model.full_name.toString();
            full_name.text = user_model.full_name.toString();
            gender.text =
            user_model.full_name.toString() == "F" ? "Female" : "Male";
            dob.text = user_model.dob.toString().replaceAll("null", "");
            aadhar.text =user_model.aadhar.toString().toString().replaceAll("null", "");
            pan.text =user_model.pan.toString().toString().replaceAll("null", "");
          }


          print(response.data);
        }
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      AppUtils.showLog("Exception Error");
    }
  }

  _selectDate() async {
    String selected_date = "";
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1500, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate)
      setState(() {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectedDate = picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        selected_date = formatter.format(_selectedDate);
        dob.text = selected_date;

        // selectedDate = picked;
      });
  }












  bool validate() {
    if(full_name.text.length==0){
      AppUtils.toAst("Please Enter Full Name",context);
      return false;

    } if(city.text.length==0){
      AppUtils.toAst("Please Select City..!!!",context);
      return false;

    } if(father_Name.text.length==0){
      AppUtils.toAst("Please Enter Father's Name..!!!",context);
      return false;

    } if(pan.text.length<10){
      AppUtils.toAst("Please Enter Valid 10 digit pan number..!!!",context);
      return false;

    }
    return true;
  }



  get_masters() async {
    setState(() {
      update = true;
    });
    ServiceConfig().getApiAuth(API.all_master_datas, context).then((value) {
      Response response = value;
      setState(() {
        update = false;
      });
      if (response != null && response.statusCode == 200) {
        var pur = response.data["list"]["funding"] as List;
        funding_source = pur.map<Master_Model>((json) => Master_Model.fromJson(json)).toList();
        Show_funding_Sheet();


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
                  funding_id=value.id;

                });

              },)

          );
        });


  }

  void navigation() {
    if(validate()){
      Customer_Detail_Model model=new Customer_Detail_Model();
      model.full_name=full_name.text.toString();
      model.father_name=father_Name.text.toString();
      model.gender_name=gender.text.toString();
      model.is_bank=bank_detail_required.text.toString();
      model.funding_id=funding_id.toString();


      model.dob=dob.text.toString();
      model.address=address.text.toString();
      model.city=city.text.toString();
      model.pan=pan.text.toString();
      model.aadhar=aadhar.text.toString();

      model.city_id=city_id.toString();
      model.state_id=state_id.toString();
      model.co_name=co_name.text.toString();


      widget.book_now_model!.customer_detail_model=model;

       var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Preview_Class(widget.book_now_model! )));



      // if(widget.book_now_model!.form_property_model!.booking_option=="1"){
      //   var response = Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Preview_Class(widget.book_now_model! )));
      //
      // }else{
      //
      //   showAlertDialog(context, "Are you Sure. You want to book now ?", "Confirmation");
      //
      // }



    }
  }


}