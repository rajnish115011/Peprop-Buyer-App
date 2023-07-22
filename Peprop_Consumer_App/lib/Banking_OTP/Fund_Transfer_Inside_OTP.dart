import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BeneficiriesModel.dart';
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
import 'Resend_Widget.dart';


class Fund_Transfer_Inside_OTP extends StatefulWidget {
  late Transfer_Model transfer_model;

  late BeneficiriesModel beneficiary_list;
  Fund_Transfer_Inside_OTP(Transfer_Model transfer_model, BeneficiriesModel beneficiary_list){
    this.transfer_model=transfer_model;
    this.beneficiary_list=beneficiary_list;


  }



  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Fund_Transfer_Inside_OTP> {
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
    map['type'] = "2";
    map['amount'] =  widget.transfer_model.amount.toString();
    map['acc_no'] = widget.transfer_model.acc_no.toString();



    FormData _accountNo = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.bankTransfer, _accountNo, context).then((value) {
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
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user_id = sharedPreferences.getString('user_id').toString();
     setState(() {
      loaing=true;
    });
    var _map = <String, dynamic>{};


    _map['amount'] =widget.transfer_model.amount.toString();
    _map['type'] = "3";
    _map['mobile'] = sharedPreferences.getString("mobile").toString();
    _map['acc_no'] =widget.transfer_model.acc_no.toString();
    _map['otp'] = contoller.text.toString();
    _map['otp_id'] = otpId;
    _map['b_account_no'] = widget.transfer_model.beneficiary_list.b_account_no;
    _map['user_id'] = sharedPreferences.getString("user_id").toString();
    _map['name'] = widget.transfer_model.holder_name.toString();
    _map['purpose'] = widget.transfer_model.remark.toString();
    _map['b_user_id'] = widget.beneficiary_list.b_user_id.toString();

    print(json.encode(_map));
    FormData _bankDetails = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.bankTransfer, _bankDetails, context).then((value) async {
      Response response = value;
      print(response.data.toString());
      if (response!=null&&response.statusCode == 200) {
        if(response.data["data"].toString().trim()=="[]"||response.data["data"].toString().trim()==""){
         AppUtils.toAst(response.data["message"].toString(),context);
         contoller.text="";
       }else{
          var data=await All_Bottom_Sheets().Success_dialog("₹ "+widget.transfer_model.amount+" Payment successfully transfer to account number "+widget.transfer_model.beneficiary_list.b_account_no, context);

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
