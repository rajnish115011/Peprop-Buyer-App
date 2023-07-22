
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking_OTP/Aadhar_OTP.dart';
import 'package:peprop_consumer_app/Banking_OTP/Forgot_Password_OTP.dart';
import 'package:peprop_consumer_app/Forgot_password/Change_Password_Components.dart';
import 'package:peprop_consumer_app/Kyc/Aadhar_Components.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Banking_OTP/Add_Beneficiary_inside_OTP.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';
import 'Forgot_Components.dart';

class Change_Password extends StatefulWidget{
  String mobile="";
  Change_Password(String mobile){
    this.mobile=mobile;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Change_Password>{
  final password=TextEditingController();
  final confirm_password=TextEditingController();


  bool is_loading=false;
  @override
  void initState() {

    create_log();


  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Change Password Form", "Change Password Form");

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Change_Password_Components(password,confirm_password,context,onSelectionChanged: (value){
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
    map['mobile'] =widget.mobile.toString();
    map['password'] =ad.toString();
    print(json.encode(map));
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.forget_password, formData, context).then((value) async {
      setState(() {
        is_loading = false;
      });
      Response response = value;
      print(response.data.toString());
      if (response != null && response.statusCode == 200&&response.data["status"]==true) {
        String mesage=response.data["message"].toString();
        AppUtils.toAst(mesage,context);
        Navigator.pop(context,"response");

      }else{
        AppUtils.toAst(response.data["message"].toString(),context);
      }
    }).catchError((onError){
      setState(() {
        is_loading = false;

      });
    });




  }

}