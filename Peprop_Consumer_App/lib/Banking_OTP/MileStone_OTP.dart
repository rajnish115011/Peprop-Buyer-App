import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Cost_Sheet/Pay_Milestone_Model.dart';
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
import '../Models/Transfer_Model.dart';
import 'Resend_Widget.dart';


class MileStone_OTP extends StatefulWidget {
  Pay_Milestone_Model? model;
  MileStone_OTP(Pay_Milestone_Model? model){
    this.model=model;


  }




  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<MileStone_OTP> {
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

    map['b_user_id'] =widget.model!.builderid.toString();
    map['milestone_id'] ==widget.model!.invid.toString();
    map['amount'] =widget.model!.mileStone!.BasicInstallment.toString();
    map['user_id'] = sharedPreferences.getString("user_id").toString();
    map['type'] = "1";
    print(json.encode(map));
    FormData _accountNo = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.milestonetransaction, _accountNo, context).then((value) {
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
    setState(() {
      loaing=true;
    });
    var _map = <String, dynamic>{};
    _map['b_user_id'] =widget.model!.builderid.toString();
    _map['milestone_id'] ==widget.model!.invid.toString();
    _map['amount'] =widget.model!.mileStone!.BasicInstallment.toString();
    _map['user_id'] = sharedPreferences.getString("user_id").toString();
    _map['type'] = "2";
    _map['otp'] = contoller.text.toString();
    _map['otp_id'] = otpId;
    _map['purpose'] = "buy";
    print(json.encode(_map));
    FormData _bankDetails = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.milestonetransaction, _bankDetails, context).then((value) {
      Response response = value;
      print(response.data.toString());
      if (response!=null&&response.statusCode == 200) {
        if(response.data["data"].toString().trim()=="[]"||response.data["data"].toString().trim()==""){
         AppUtils.toAst(response.data["message"].toString(),context);
         contoller.text="";
       }else{
         Navigator.pop(context,"response");
         AppUtils.toAst(response.data["message"].toString(),context);
       }
      }
      setState(() {
        loaing=false;
      });
    });
  }
}
