import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/Inside_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/OTP_View.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Book_Now/Booking/Book_Now_Model.dart';
import '../Book_Now/Form_Property_Model.dart';
import '../Models/Add_Baneficiary_Model.dart';
import '../Models/Customer_Detail_Model.dart';
import '../Models/Tower_Model.dart';
import '../Models/Transfer_Model.dart';
import '../Properties/Extra_json.dart';
import '../Thanks/Thank_You_Booking.dart';
import 'Resend_Widget.dart';


class Book_Now_OTP extends StatefulWidget {
  Book_Now_Model? book_now_model;
  Book_Now_OTP(Book_Now_Model? book_now_model){
    this.book_now_model=book_now_model;
  }


  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Book_Now_OTP> {
  TextEditingController contoller=TextEditingController();
  bool loaing=false;
  String otpId="";
  @override
  initState() {
    super.initState();
    send_otp();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/otp.png',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter the One Time Password (OTP) sent to your mobile.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  OTP_View(contoller,onSelectionChanged: (value){
                    contoller.text=value;
                    if(value.length==6){
                      _verifyOtp(contoller.text.toString());
                    }

                  }),
                  Resend_Widget(resend: (){
                    send_otp();
                  }),
                ],
              ),
            ),
          ),
          if(loaing)Center(child: new CircularProgressIndicator(),)
        ],
      )

    );
  }

  Future<void> send_otp() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      loaing = true;
    });
    var map = <String, String>{};
    map['mobile'] = sharedPreferences.getString("mobile").toString();
    map['b_user_id'] =widget.book_now_model!.form_property_model!.BuilderId.toString();
    map['prop_id'] =widget.book_now_model!.form_property_model!.property_id.toString();
    map['amount'] =widget.book_now_model!.form_property_model!.booking_max_amount.toString();
    map['user_id'] = sharedPreferences.getString("user_id").toString();
    map['type'] = "1";
    print(json.encode(map));
    FormData _accountNo = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.booknowTransaction, _accountNo, context).then((value) {
      Response response = value;
      setState(() {
        loaing = false;
      });
      contoller.text="";
      if (response.statusCode == 200) {
        var status = response.data["success"] as bool;
        String data = response.data["data"].toString();
        if(status==true&&data!="null"&&data!=""){
          AppUtils.toAst(response.data["message"].toString(),context);
          otpId = response.data["data"]['otp_id'].toString();
        }else{
            var _message = response.data["message"].toString();
            AppUtils.toAst(_message.toString(),context);
            Navigator.pop(context);

        }

      }
    }).catchError((onError){

      Navigator.pop(context);
      setState(() {
        loaing = false;
      });
    });


  }
  Future<void> _verifyOtp(String code) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      loaing=true;
    });
    var _map = <String, dynamic>{};
    _map['full_name'] = widget.book_now_model!.customer_detail_model!.full_name.toString();
    _map['father_name'] = widget.book_now_model!.customer_detail_model!.father_name.toString();
    _map['gender'] = widget.book_now_model!.customer_detail_model!.gender_name.toString()=="Male"?"M":"F";
    _map['address'] = widget.book_now_model!.customer_detail_model!.address.toString();
    _map['d_o_b'] = widget.book_now_model!.customer_detail_model!.dob.toString();
    _map['city'] = widget.book_now_model!.customer_detail_model!.city_id.toString();
    _map['state'] = widget.book_now_model!.customer_detail_model!.state_id.toString();
    _map['bank_loan_required'] = widget.book_now_model!.customer_detail_model!.funding_id.toString();
    _map['co_applicant_details'] = widget.book_now_model!.customer_detail_model!.co_name.toString();



    _map['pancard_details'] = widget.book_now_model!.customer_detail_model!.pan.toString();
    _map['aadharcard_details'] = widget.book_now_model!.customer_detail_model!.aadhar.toString();
    if (widget.book_now_model!.form_property_model!.booking_option.toString() == "1") {

      List<String> selected_invetory = [];

      List<Book_Now_all_Tower_Model>unit_no_list=[];

      widget.book_now_model!.online_model!.unit_no_list.forEach((element) {
        if(element.is_checked){
          unit_no_list.add(element);
          selected_invetory.add(element.unit_id);

        }

      });
      _map['invid'] = selected_invetory.join(",");

      _map['planid'] = widget.book_now_model!.online_model!.plan_id.toString();
      _map['form_type'] = "online";
    }else{
      _map['form_type'] = "offline";
    }
    _map['milid'] = "0";
    _map['mobile'] = sharedPreferences.getString("mobile").toString();
    _map['b_user_id'] =widget.book_now_model!.form_property_model!.BuilderId;
    _map['prop_id'] =widget.book_now_model!.form_property_model!.property_id;
    _map['amount'] = widget.book_now_model!.form_property_model!.booking_max_amount;
    _map['user_id'] = sharedPreferences.getString("user_id").toString();
    _map['type'] = "2";
    _map['otp'] = contoller.text.toString();
    _map['otp_id'] = otpId;

    List<Map>list=[];
    Map<String, String> myMap =new Map();
    widget.book_now_model!.online_model!.extra_charges_details.forEach((element) {
      myMap.putIfAbsent(element.amenity_id.toString(), () =>  element.edit_qty.toString());
      list.add( new Extra_json(element.amenity_id.toString(), element.edit_qty.toString()).TojsonData());

    });
    _map['extra_charges'] =  json.encode(list);

    print(json.encode(_map));
    FormData _bankDetails = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.booknowTransaction, _bankDetails, context).then((value) async {
      Response response = value;
      print(response.data.toString());
      if (response!=null&&response.statusCode == 200) {
        if(response.data["data"].toString().trim()=="[]"||response.data["data"].toString().trim()==""){
         AppUtils.toAst(response.data["message"].toString(),context);
         contoller.text="";
       }else{
          AppUtils.toAst("Your Booking Successfully Done..!!",context);
          var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You_Booking()));

        }
      }
      setState(() {
        loaing=false;
      });
    });
  }
}
