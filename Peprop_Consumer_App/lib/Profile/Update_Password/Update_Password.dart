
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
import '../../Login/Login.dart';
import '../../Sheets/All_Bottom_Sheets.dart';
import '../../Utils/AppUtils.dart';
import '../../Utils/Success_Dialog.dart';
import 'Update_Password_Componenets.dart';

class Update_Password extends StatefulWidget{
  String mobile="";
  Update_Password(String mobile){
    this.mobile=mobile;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<Update_Password>{
  final newpassword=TextEditingController();
  final old_password=TextEditingController();
  final confirm_password=TextEditingController();


  bool is_loading=false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:AppUtils.appBarTitle(context, "Change Password"),
      body: Stack(
        children: [
          Update_Password_Componenets(newpassword,old_password,confirm_password,context,onSelectionChanged: (old_pass,newpass){
            send_otp(old_pass,newpass);


          },),
          if(is_loading)Center(child: new CircularProgressIndicator(),),



        ],
      ),
    );
  }
  Future<void> send_otp(String old, String newpass) async {
    setState(() {
      is_loading = true;
    });
    var map = Map<String, dynamic>();
    map['mobile'] =widget.mobile.toString();
    map['old_password'] =old.toString();
    map['new_password'] =newpass.toString();
    FormData formData = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.passwordChange, formData, context).then((value) async {
      setState(() {
        is_loading = false;
      });
      Response response = value;
      print("response"+response.data.toString());
      if (response != null && response.statusCode == 200&&response.data["status"]==true) {
        String mesage=response.data["list"].toString();
        final SharedPreferences prefNew =await SharedPreferences.getInstance();
        prefNew.setBool('isRegistered', true);
        prefNew.setString('token', mesage);

        var data=await All_Bottom_Sheets().Success_dialog("You have successfully changed your password.", context);
        if(data!=null&&data==true){
          Success_Dialog(context,onclick:() async {
            AppUtils.toAst("Please Login Again..!!!",context);
            SharedPreferences sp=await SharedPreferences.getInstance();
            sp.setString("token", "null");

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(Route<dynamic> route) => false);

          } ).show_dialog();
        }




      }else{
        AppUtils.toAst(response.data["list"].toString(),context);
      }
    }).catchError((onError){
      setState(() {
        is_loading = false;

      });
    });




  }

}