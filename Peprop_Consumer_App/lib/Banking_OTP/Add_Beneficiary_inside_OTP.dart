import 'dart:async';
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

import '../Models/Add_Baneficiary_Model.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import 'Resend_Widget.dart';


class Add_Beneficiary_inside_OTP extends StatefulWidget {
  Inside_Model? inside_model;

  Add_Beneficiary_inside_OTP(Inside_Model? inside_model){
    this.inside_model=inside_model;

  }

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Add_Beneficiary_inside_OTP> {
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

  void send_otp() {
    setState(() {
      loaing = true;
    });
    var map = <String, String>{};
    map['mobile'] = widget.inside_model!.user_mobile.toString();
    map['type'] = "2";
    FormData _accountNo = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.benificeryAccountAdded, _accountNo, context).then((value) {
      Response response = value;
      setState(() {
        loaing = false;
      });

      if (response.statusCode == 200) {
        var status = response.data["success"] as bool;
        var _message = response.data["message"].toString();
        contoller.text="";
        AppUtils.toAst(_message.toString(),context);
        if (status) {
          otpId = response.data["data"]['otp_id'].toString();
        }
      }
    }).catchError((onError){
      AppUtils.toAst(onError.toString(),context);
      setState(() {
        loaing = false;
      });
    });


  }
  Future<void> _verifyOtp(String code) async {
    final prefs = await SharedPreferences.getInstance();
     String user_id = prefs.getString('user_id').toString();


    setState(() {
      loaing=true;
    });
    var map = <String, dynamic>{};
    map['mobile'] = widget.inside_model!.user_mobile.toString();
    map['acc_no'] =widget.inside_model!.user_account.toString();
    map['b_acc_no'] = widget.inside_model!.acc_no.toString();
    map['type'] = '3';
    map['otp'] = code;
    map['otp_id'] = otpId;
    map['acc_id'] = widget.inside_model!.id.toString();
    map['user_id'] = user_id;
    map['acc_type'] =widget.inside_model!.acc_type.toString();
    map['b_user_id'] = widget.inside_model!.created_by.toString();
    map['b_ifsc'] = widget.inside_model!.ifsc.toString();
    map['b_bank_name'] = 'ICICI';
    map['b_branch'] = 'IPROP';
    map['b_name'] = widget.inside_model!.name.toString();
    map['b_mobile'] =widget.inside_model!.mobile.toString();
    map['b_email'] = 'bydefault@gmail.com';


    FormData _bankDetails = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.benificeryAccountAdded, _bankDetails, context).then((value) async {
      Response response = value;

      if (response!=null&&response.statusCode == 200) {
        if(response.data["data"].toString().trim()=="[]"){
         AppUtils.toAst(response.data["message"].toString(),context);
         contoller.text="";
       }else{
         var data=await All_Bottom_Sheets().Success_dialog("You have successfully added the beneficiary.", context);
         if(data!=null&&data==true){
           Navigator.pop(context,"response");

         }

       }



      }
      setState(() {
        loaing=false;
      });
    });
  }
}
