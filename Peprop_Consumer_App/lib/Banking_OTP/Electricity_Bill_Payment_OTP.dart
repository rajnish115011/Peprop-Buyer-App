import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/bill_payment/model/Circle_Model.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/widgets/OTP_View.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Thanks/Thank_You.dart';
import 'Resend_Widget.dart';


class Electricity_Bill_Payment_OTP extends StatefulWidget {
  Bill_Fetch_Model? bill_fetch_model;
  String accNo="";
  String name="";
  String reference_id="";


  Opertaor_list? op_model;
  Home_List_Model? list;
  Electricity_Bill_Payment_OTP(Bill_Fetch_Model? bill_fetch_model, String accNo, String name, Opertaor_list? op_model, Home_List_Model? list, String reference_id){
    this.bill_fetch_model=bill_fetch_model;
    this.accNo=accNo;
    this.name=name;
    this.op_model=op_model;
    this.list=list;
    this.reference_id=reference_id;



  }




  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Electricity_Bill_Payment_OTP> {
  var contoller=TextEditingController();
  String otpId="";
  bool loading=false;
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
      body:new Stack(
        children: [
          SingleChildScrollView(
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
                    'OTP Verification',
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
                    if(value.length==6){
                      transfer_Fund(value);

                    }



                  }),
                  Resend_Widget(resend: (){
                    send_otp();
                  }),
                ],
              ),
            ),
          ),
          if(loading)Center(child: new CircularProgressIndicator(),)
        ],
      )

    );
  }

  Future<void> send_otp() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });
    var map = <String, String>{};
    map['mobile'] =sharedPreferences.getString("mobile").toString();
    map['type'] = "1";
    map['amount'] = widget.bill_fetch_model!.amount.toString();
    map['d_acc'] =widget.accNo;
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    map['name'] =widget.name.toString();
    print(json.encode(map));
    FormData _accountNo = FormData.fromMap(map);

    Response response =await ServiceConfig().postApiBodyAuthJson(API.bbpsicicitranaction, _accountNo, context);
    print(response.data.toString());
    if (response.statusCode == 200) {
      var status = response.data["success"] as bool;
      var _message = response.data["message"].toString();
      contoller.text="";
      AppUtils.toAst(_message.toString(),context);
      if (status&&response.data["data"]!=null&&response.data["data"]!="") {
        otpId = response.data["data"]['otp_id'].toString();
      }else{
        Navigator.pop(context,"");

      }
    }
    setState(() {
      loading = false;
    });



  }

  Future<void> transfer_Fund(String value) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    AppUtils().showProgressDialog(context);
    var map = <String, String>{};
    map['mobile'] =sharedPreferences.getString("mobile").toString();
    map['type'] = "2";
    map['amount'] = widget.bill_fetch_model!.amount.toString();
    map['d_acc'] =widget.accNo;
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    map['name'] =widget.name.toString();
    map['otp_id'] =otpId.toString();
    map['otp'] =value.toString();
    map['purpose'] ="recharge";
    map['currency'] ="INR";
    map['operator'] =widget.op_model!.operator_id;
    map['canumber'] =widget.op_model!.ca_number;
    map['referenceid'] =new DateTime.now().millisecondsSinceEpoch.toString();
    map['latitude'] ="0.000000";
    map['longitude'] ="0.000000";
    map['mode'] ="Peprop";
    map['billAmount'] =widget.bill_fetch_model!.amount.toString();
    map['billnetamount'] =widget.bill_fetch_model!.amount.toString();
    map['billdate'] =DateFormat('yyyy-MM-dd').format(new DateTime.now());
    map['dueDate'] =widget.bill_fetch_model!.duedate.toString();
    map['acceptPayment'] ="1";
    map['acceptPartPay'] ="0";
    map['cellNumber'] =sharedPreferences.getString("mobile").toString();
    map['userName'] =widget.bill_fetch_model!.name.toString();
    map['user_id'] =sharedPreferences.getString("user_id").toString();
    map['message'] ="bill payment";
    map['paymentTypeAmount'] =widget.bill_fetch_model!.amount.toString();
    map['paymentType'] ="Peprop Banking";
    map['response_code'] =widget.bill_fetch_model!.response_code.toString();




    FormData _accountNo = FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.bbpsicicitranaction, _accountNo, context).then((value) {
      Response response = value;
      Navigator.of(context, rootNavigator: true).pop("Discard");
      if (response.statusCode == 200) {
        if(response.data["data"].toString().trim()=="[]"||response.data["data"].toString().trim()==""){
          AppUtils.toAst(response.data["message"].toString(),context);
          contoller.text="";

        }else{

        }
      }
    }).catchError((onError){
      Navigator.of(context, rootNavigator: true).pop("Discard");


    });

  }

  Future<void> save_history() async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();

    var _map = <String, dynamic>{
      "operator":widget.op_model!.operator_id,
      "canumber":widget.op_model!.ca_number,
      "referenceid":widget.reference_id,
      "latitude":"0.000000",
      "amount":widget.bill_fetch_model!.amount.toString(),
      "longitude":"0.000000",
      "mode":"Online",
      "billAmount":widget.bill_fetch_model!.amount.toString(),
      "billnetamount":widget.bill_fetch_model!.amount.toString(),
      "billdate":DateFormat('yyyy-MM-dd').format(new DateTime.now()),
      "dueDate":widget.bill_fetch_model!.duedate.toString(),
      "acceptPayment":1,
      "acceptPartPay":0,
      "cellNumber":prefNew.getString("mobile").toString(),
      "userName":widget.bill_fetch_model!.name.toString(),
      "user_id":prefNew.getString("user_id").toString(),
      "message":"bill payment",
      "paymentTypeAmount":widget.bill_fetch_model!.amount.toString(),
      "paymentType":"Peprop Banking",
      "response_code":widget.bill_fetch_model!.response_code.toString(),

      "category":widget.list!.alt.toString(),

    };
    print(json.encode(_map));
    FormData customerData = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.payBill, customerData, context).then((value) async {
      Response response = value;
      Navigator.of(context, rootNavigator: true).pop("Discard");

      if (response != null && response.statusCode == 200) {
        print("pay bill response"+response.data.toString());
        bool status=response.data["status"] as bool;
        if(status!=false){
          var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You(orderAmount:widget.bill_fetch_model!.amount.toString(),referenceId:widget.reference_id)));
          if(response!=null){
            Navigator.pop(context,"response");
          }

        }else{
          AppUtils.toAst("Something Went Wrong: v100",context);
        }





      }
    }).catchError((error, stackTrace) {
      Navigator.of(context, rootNavigator: true).pop("Discard");

    });

  }


}
