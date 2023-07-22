
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking_OTP/Aadhar_OTP.dart';
import 'package:peprop_consumer_app/Banking_OTP/Forgot_Password_OTP.dart';
import 'package:peprop_consumer_app/Kyc/Aadhar_Components.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Banking_OTP/Add_Beneficiary_inside_OTP.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import 'Forgot_Components.dart';

class Forgot_Password extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State{
  final contoller=TextEditingController();
  bool is_loading=false;

  @override
  void initState() {

    create_log();


  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Forgot Password Form", "Forgot Password Form");

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppUtils.appBar(context, ""),
      body: Stack(
        children: [
          Forgot_Components(contoller,context,onSelectionChanged: (value){
            send_otp(value);
          },),
          if(is_loading)Center(child: new CircularProgressIndicator(),),



        ],
      ),
    );
  }
  Future<void> send_otp(String ad) async {
    setState(() {
      is_loading = true;
    });
    var map = Map<String, dynamic>();
    map['mobile'] =ad.toString();
    map['cc'] ="91";
    print(json.encode(map));
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.genrateotpforForgetPassword, formData, context).then((value) async {
      setState(() {
        is_loading = false;
      });
      Response response = value;
      print(response.data.toString());
      if (response != null && response.statusCode == 200&&response.data["status"]==true) {
        String otp_id=response.data["response"]["is_otp_send"].toString();
        AppUtils.toAst("OTP Sent..!!",context);
        var res=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Forgot_Password_OTP(otp_id,ad.toString())));
        if(res!=null){
          Navigator.pop(context,"response");
        }
      }else{
        AppUtils.toAst("Account does't exist with this Mobile Number",context);
      }
    }).catchError((onError){
      setState(() {
        is_loading = false;

      });
    });




  }

}