
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking_OTP/Aadhar_OTP.dart';
import 'package:peprop_consumer_app/Kyc/Aadhar_Components.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Components.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Banking_OTP/Add_Beneficiary_inside_OTP.dart';
import '../Sheets/All_Bottom_Sheets.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';

class Pan_Verification extends StatefulWidget{
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
    await FireBase_Logs().log_screen_view("Pan Verification Form", "Pan Verification Form");

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppUtils.appBar(context, ""),
      body: Stack(
        children: [
          Pan_Components(contoller,context,onSelectionChanged: (value){
            send_otp(value.toString());


          },),
          if(is_loading)Center(child: new CircularProgressIndicator(),),



        ],
      ),
    );
  }
  Future<void> send_otp(String pan) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user_id=sharedPreferences.getString("user_id").toString();
    setState(() {
      is_loading = true;
    });
    var map = Map<String, dynamic>();
    map['pan'] =pan.toString();
    map['user_id'] =user_id.toString();
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.verifyPan, formData, context).then((value) async {
      setState(() {
        is_loading = false;
      });
      Response response = value;
      print(response.data.toString());
      if (response != null && response.statusCode == 200&& response.data["data"]!=null&&response.data["data"]["status_code"]!=422) {
        var data=await All_Bottom_Sheets().Success_dialog("You have successfully completed your KYC, please visit banking section for your virtual account details.", context);
        if(data!=null&&data==true){
          Navigator.pop(context,"response");
        }
      }else if(response != null&&response.data!=null &&response.data["message"]!=null){
        AppUtils.toAst(response.data["message"].toString(),context);
      }else{
        AppUtils.toAst("Something Went Wrong..!!",context);
      }
    }).catchError((onError){
      setState(() {
        is_loading = false;

      });
    });




  }

  Future<void> open_account() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['mobile'] = sharedPreferences.getString("mobile").toString();
    map['user_id'] = sharedPreferences.getString("user_id").toString();
    map['name'] = sharedPreferences.getString("full_name").toString();
    map['kyc'] = "1";
    FormData formData = new FormData.fromMap(map);
    setState(() {
      is_loading=true;
    });
    ServiceConfig().postApiBodyAuthJson(API.createAccount,formData, context).then((value) async {
      Response response = value;
      setState(() {
        is_loading=false;;
      });
      if (response != null && response.statusCode == 200) {
        var data=await All_Bottom_Sheets().Success_dialog("You have successfully completed your KYC, please visit banking section for your virtual account details.", context);
        if(data!=null&&data==true){
          Navigator.pop(context,"response");
        }

      }

    }).catchError((error, stackTrace) async {
      setState(() {
        AppUtils.toAst("Something Went Wrong..!!",context);
        is_loading=false;;

      });

    });

  }

}