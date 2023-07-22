import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Forgot_password/Change_Password.dart';
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
import 'Resend_Widget.dart';


class Forgot_Password_OTP extends StatefulWidget {
  String otp_id="";
  String mobile="";

  Forgot_Password_OTP(String otp_id ,String mobile ){
    this.otp_id=otp_id;
    this.mobile=mobile;
  }



  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Forgot_Password_OTP> {
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
                  Resend_Widget(resend: (){
                    send_otp(widget.mobile.toString());
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

  Future<void> send_otp(String ad) async {
    setState(() {
      contoller.text="";
      loaing = true;
    });
    var map = Map<String, dynamic>();
    map['mobile'] =ad.toString();
    map['cc'] ="91";
    print(json.encode(map));
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.genrateotpforForgetPassword, formData, context).then((value) async {
      setState(() {
        loaing = false;
      });
      Response response = value;
      print(response.data.toString());
      if (response != null && response.statusCode == 200&&response.data["status"]==true) {
        widget.otp_id=response.data["response"]["is_otp_send"].toString();
        AppUtils.toAst("OTP Sent..!!",context);

      }else{
        AppUtils.toAst("Account does't exist with this Mobile Number",context);
      }
    }).catchError((onError){
      setState(() {
        loaing = false;

      });
    });




  }


  Future<void> verifyOtp(String otp) async {
    setState(() {
      loaing = true;
    });
    var map = Map<String, dynamic>();
    map['otpid'] =widget.otp_id;
    map['otp'] =otp.toString();
    map['country_code'] ="91";
    map['mobile'] =widget.mobile;
    print(json.encode(map));
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.validate_Forget_otp_verify, formData, context).then((value) async {
      setState(() {
        loaing = false;

      });
      Response response = value;
      if (response != null && response.statusCode == 200&&response.data["status"]==true) {
        var res=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Change_Password(widget.mobile)));
        if(res!=null){
          Navigator.pop(context,"response");
        }

      }else{
        AppUtils.toAst(response.data["message"].toString(),context);

      }



    }).catchError((onError){
      setState(() {
        loaing = false;

      });
    });
  }
}
