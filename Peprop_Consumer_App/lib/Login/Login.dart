

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peprop_consumer_app/Dashboard/Dashboard.dart';
import 'package:peprop_consumer_app/Forgot_password/Forgot_Password.dart';
import 'package:peprop_consumer_app/Global_connection/Global_connection.dart';
import 'package:peprop_consumer_app/Login/Login_Components.dart';
import 'package:peprop_consumer_app/Login/Login_Model.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';
import 'package:peprop_consumer_app/widgets/Login_Phone_Widget.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/API.dart';
import '../Color/ColorFile.dart';
import '../Registration/Customer_Registration.dart';
import '../Utils/ServiceConfig.dart';

import 'package:flutter/material.dart';

import 'BezierContainer.dart';


class Login extends StatefulWidget {
  Login({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final mobile=TextEditingController();
  final password=TextEditingController();
  bool is_enabled=true;
  bool is_exist=false;
  bool loading=false;
  String  otpId="";

  String  Country_code="91";



  Widget _submitButton() {
    return
      InkWell(child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5,spreadRadius: 2)], gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,colors: [ColorFile.app_color,ColorFile.app_color])),child: Text('Proceed',style: Styles().styles_regular(16, ColorFile.white),
      ),
      ),onTap: (){
        if(is_exist){
          if(mobile.text.toString().length<10){
            AppUtils.toAst('Please Enter Mobile Number',context);

          }else if(password.text.toString().length==0){
            AppUtils.toAst('Please Enter Valid Password',context);

          }else{
            validate_sign_in();
          }


        }
        else{
          if(mobile.text.toString().length<10){
            AppUtils.toAst('Please Enter Mobile Number',context);

          }else{
            validate_user();
          }


        }

      },);
  }






  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        Login_Phone_Widget("Mobile", mobile, is_exist,Country_code,
          onclick: () {
            setState(() {
            is_exist=false;
            mobile.clear();
            password.clear();
          });

        },pick_country_code: (){
          show_country_picker();

          },),
        if(is_exist)Form_Fields().password("Password", password, is_enabled)

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[


              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      Image.asset("assets/logo.png",height: 60),
                      SizedBox(height: 20),
                      new Container(child: new Row(
                        children: [
                          Expanded(child: new Container(child:  Text("Login or create an account",
                            style:Styles().styles_medium(16, ColorFile.black),
                            textAlign: TextAlign.center,
                          ),))
                        ],
                      ),),
                      SizedBox(height: 20),

                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      _submitButton(),
                      InkWell(child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password ?', style: Styles().styles_medium(14, ColorFile.app_color)),
                      ),onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Forgot_Password()));

                      },)

                    ],
                  ),
                ),
              ),
           if(Platform.isIOS)InkWell(child: new Container(child: new Icon(Icons.arrow_back),margin: EdgeInsets.only(top: 70,left: 20),),onTap: (){
                Navigator.pop(context);
              },),
              if(loading)Center(child: new CircularProgressIndicator(),)

            ],
          ),
        ));

  }

  Future<void> validate_sign_in() async {
    setState(() {
      loading = true;

    });

    String? token = await FirebaseMessaging.instance.getToken();
    Map data = {
      'mobile': mobile.text.toString(),
      'password': password.text.toString(),
      'cc':Country_code.toString(),
      'firebase_token': token,


    };
    print(json.encode(data));
    var response=await Global_connection().post_method(data, context, API.loginWithPassword);
    print(response.toString());
    if(response!=null&&response.data!=null&&response.statusCode==200){
      final SharedPreferences prefNew =await SharedPreferences.getInstance();
      bool statusNew = response.data['status'] as bool;
      if (statusNew) {
        prefNew.setString('city', "null");
        prefNew.setString('unread', "0");


        var token = response.data["token"]['token'];
        String user_id = response.data["data"][0]["user_id"] as String;
        String full_name = response.data["data"][0]["full_name"] as String;
        String email = response.data["data"][0]["email"] as String;
        String mobileNumber = response.data["data"][0]["mobile"] as String;
        String referral_code = response.data["data"][0]["referral_code"].toString();

        prefNew.setBool('isRegistered', true);
        prefNew.setString('token', token);
        prefNew.setString('user_id', user_id);
        prefNew.setString('full_name', full_name);
        prefNew.setString('email', email);
        prefNew.setString('mobile', mobileNumber);
        prefNew.setString('my_refer', referral_code);


        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Dashboard()),(Route<dynamic> route) => false);

      } else {
        AppUtils.toAst('Mobile and Password Mismatch',context);

      }

    }
    setState(() {
      loading=false;
    });




  }

  Future<void> validate_user() async {
    setState(() {
      loading = true;

    });
      Map data = {"country_code": Country_code.toString(),"mobile": mobile.text.toString()};
      var response=await Global_connection().post_method(data, context, API.login);
      print(response.toString());
      if(response!=null&&response.data!=null){
      if(response.data["user_level"]!=null&&response.data["user_level"].toString()=="13"){
        is_exist=true;
      }else if(response.data["user_level"]!=null&&response.data["user_level"].toString()!="13"){
        AppUtils().show_error(context,"Login as "+response.data["role"].toString()+" not allowed in Buyer Application.!!");
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Customer_Registration(mobile.text.toString())));
      }

    }



    setState(() {
      loading = false;

    });



  }
  show_country_picker() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 16, fontFamily: "medium", color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2))))),
      onSelect: (Country country) {
        setState(() {
          Country_code = "" + country.phoneCode;
        });
      },
    );
  }

  }







