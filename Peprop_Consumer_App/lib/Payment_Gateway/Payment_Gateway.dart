



import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

class Payment_Gateway extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BuildState();
  }



}

class BuildState extends State{
 bool loading=false;
  @override
  void initState() {
   generate_token();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
        appBar: AppUtils.appBar(context, ""),
        body: new Stack(
          children: [
            if(loading)Center(child: new CircularProgressIndicator())


          ],
        ),


      );



        }

  generate_token(){
    setState(() {
      loading=true;
    });
    var map = new Map<String, dynamic>();
    map['order_id'] ="ORD11001010";
    map['order_amount'] = "10";
    FormData formData = new FormData.fromMap(map);
    ServiceConfig().postApiBodyAuthJson(API.createToken, formData, context).then((value) {
      Response response = value;
      setState(() {
        loading=false;
      });
      if (response != null && response.statusCode == 200) {
        print("token"+response.data.toString());
        String token=response.data["cftoken"];
        String stage=response.data["stage"];
        // do_payment(token,stage);

      } else {

      }
    }).catchError((error, stackTrace) {
      setState(() {

      });
    });
  }

  void do_payment(String token, String stage1) {
    String stage = stage1;
    String orderId = "ORD11001010";
    String orderAmount = "10";
    String customerName = "Rajnish";
    String orderNote = "Notes";
    String orderCurrency = "INR";
    String appId = "APP_ID";
    String customerPhone = "9999999999";
    String customerEmail = "sample@gmail.com";
    String notifyUrl = "https://test.gocashfree.com/notify";
    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData":token,
      "notifyUrl": notifyUrl,
       "color1":"#2148C0",
       "color2": "#ffffff",
    };
    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {


      //Do something with the result
    })).catchError((onError){
      AppUtils.toAst("message",context);

    }).onError((error, stackTrace) =>(){
      AppUtils.toAst("message",context);
    });
  }

  }

