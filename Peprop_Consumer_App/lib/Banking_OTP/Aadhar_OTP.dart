import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Verification.dart';
import 'package:peprop_consumer_app/Models/Inside_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/OTP_View.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Add_Baneficiary_Model.dart';
import '../Models/Transfer_Model.dart';
import '../Sheets/All_Bottom_Sheets.dart';


class Aadhar_OTP extends StatefulWidget {
  String client_id="";
  String aadhar_number="";

  Aadhar_OTP(String client_id ,String aadhar_number ){
    this.client_id=client_id;
    this.aadhar_number=aadhar_number;
  }



  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Aadhar_OTP> {
  TextEditingController contoller=TextEditingController();
  bool loaing=false;
  String otpId="";
  @override
  initState() {
    super.initState();


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
                      verifyOtp(contoller.text.toString());
                    }

                  }),
                  SizedBox(
                    height: 18,
                  ),


                ],
              ),
            ),
          ),
          if(loaing)Center(child: new CircularProgressIndicator(),)
        ],
      )

    );
  }

  Future<void> verifyOtp(String otp) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user_id=sharedPreferences.getString("user_id").toString();
    setState(() {
      loaing = true;
    });
    var map = Map<String, dynamic>();
    map['otp'] =otp.toString();
    map['client_id'] =widget.client_id.toString();
    map['user_id'] =user_id.toString();
    print(map.toString());
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.aadhaarOTPVerify, formData, context).then((value) async {
      setState(() {
        loaing = false;

      });
      Response response = value;
      if (response != null && response.statusCode == 200) {
        print(response.toString());
        String success=response.data["data"]["success"].toString();
        if(success=="true")
        {

          var data=await All_Bottom_Sheets().Success_dialog("You have successfully verified aadhaar.", context);
          if(data!=null&&data==true){
            var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
            if(res!=null){
              Navigator.pop(context,"response");
            }
          }



        }else if(response.data["data"]["success"]==false){
          AppUtils.toAst(response.data["data"]["message"].toString(),context);
          Navigator.pop(context);



        }

        // String success=response.data["data"]["success"].toString();
        // if(success=="true")
        // {
        //   String data=response.data["data"]["data"]["client_id"].toString();
        //   if(data.toString()=="null"){
        //     AppUtils.toAst("Invalid Aadhaar OTP..");
        //   }else{
        //     AppUtils.toAst("Aadhaar Verified..");
        //     var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
        //     if(response!=null){
        //       Navigator.pop(context);
        //     }
        //   }
        // }else{
        //   AppUtils.toAst(response.data["data"]["message"].toString());
        // }

      }



    }).catchError((onError){
      setState(() {
        loaing = false;

      });
    });
  }
}
