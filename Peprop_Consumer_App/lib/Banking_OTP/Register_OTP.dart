import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Verification.dart';
import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:peprop_consumer_app/Models/Inside_Model.dart';
import 'package:peprop_consumer_app/Thanks/Registration_Success.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/OTP_View.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/Dashboard.dart';
import '../Global_connection/Global_connection.dart';
import '../Models/Add_Baneficiary_Model.dart';
import '../Models/Transfer_Model.dart';
import 'Resend_Widget.dart';


class Register_OTP extends StatefulWidget {
  var map;
  String otp_id="";
  Register_OTP(map, otp_id){
    this.map=map;
    this.otp_id=otp_id;

  }






  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Register_OTP> {
  TextEditingController contoller=TextEditingController();
  bool loaing=false;
  String otpId="";
  @override
  initState() {
    super.initState();
    otpId=widget.otp_id.toString();


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
                      verify_OTP(contoller.text.toString());
                    }

                  }),

                  Resend_Widget(resend: (){
                    retry();
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

  Future<void> verify_OTP(String string) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      loaing=true;
    });

    String device_id=await AppUtils().getDeviceDetails();
    widget.map["otp"]=string;
    widget.map["otp_id"]=otpId;
    widget.map["otpid"]=otpId;
     widget.map["device_unique_id"]=device_id.toString();
    if(sharedPreferences.getString("refer_code").toString()!="null"){
      widget.map["refer_by"]=sharedPreferences.getString("refer_code").toString();
    }
    FormData formData = FormData.fromMap(widget.map);
    var response=await Global_connection().post_method(formData, context, API.getCustomerRegistrationSave);
    setState(() {
      loaing=false;
    });
    print(response);

    if (response != null &&response.data!=null&& response.statusCode == 200) {
      var status = response.data["status"] as bool;
      if (status) {
        sharedPreferences.setString("refer_code","null");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            Registration_Success(response.data["message"].toString())));
      } else {

      }
    }

  }
  Future<void> retry() async {
    setState(() {
      loaing=true;
    });
    FormData formData = FormData.fromMap(widget.map);

    var response=await Global_connection().post_method(formData, context, API.postCustomerRegistration);
    setState(() {
      loaing=false;
    });
    print(response.data.toString());
    if (response != null && response.statusCode == 200){
      var status = response.data["status"] as bool;
      if (status) {
        AppUtils.toAst(response.data["message"],context);
        otpId=response.data["data"].toString();
        print(widget.otp_id.toLowerCase());
        contoller.clear();

      }
      }





  }

}
