
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Banking_OTP/Aadhar_OTP.dart';
import 'package:peprop_consumer_app/Kyc/Aadhar_Components.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Banking_OTP/Add_Beneficiary_inside_OTP.dart';
import '../Utils/AppUtils.dart';
import '../Utils/FireBase_Logs.dart';

class Aadhar_Verification extends StatefulWidget{
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
    await FireBase_Logs().log_screen_view("Aadhaar Verification Form", "Aadhaar Verification Form");

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppUtils.appBar(context, ""),
      body: Stack(
        children: [
          Aadhar_Components(contoller,context,onSelectionChanged: (value){
            send_otp(value.toString());
          },),
          if(is_loading)Center(child: new CircularProgressIndicator(),),



        ],
      ),
    );
  }
  Future<void> send_otp(String ad) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user_id=sharedPreferences.getString("user_id").toString();
    setState(() {
      is_loading = true;

    });
    var map = Map<String, dynamic>();
    map['aadhaar_no'] =ad.toString();
    map['user_id'] =user_id.toString();
    print(json.encode(map));

    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.aadhaarOTP, formData, context).then((value) async {
      setState(() {
        is_loading = false;
      });
      Response response = value;
      print(response.data.toString());
      if (response != null && response.statusCode == 200) {
        String valid_aadhaar=response.data["data"]["data"]["valid_aadhaar"].toString();
        if(valid_aadhaar.toString()=="true"){
          String valid_aadhaar=response.data["data"]["data"]["client_id"].toString();
          var res=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Aadhar_OTP(valid_aadhaar,ad.toString())));
          if(res!=null){
            Navigator.pop(context);
          }
        }else{
          AppUtils.toAst(response.data["message"].toString(),context);

        }

      }
    }).catchError((onError){
      setState(() {
        is_loading = false;

      });
    });




  }

}