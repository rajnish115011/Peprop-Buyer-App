

import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Kyc/Banking_Steps.dart';
import 'package:peprop_consumer_app/Thanks/Thank_You.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/bill_payment/model/Bill_Payment_Type_Model.dart';
import 'package:peprop_consumer_app/bill_payment/model/Circle_Model.dart';
import 'package:peprop_consumer_app/bill_payment/model/Wallet_option_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Banking_OTP/Electricity_Bill_Payment_OTP.dart';
import '../../Utils/FireBase_Logs.dart';
import '../../dashboard_model/Home_Model.dart';
import '../../widgets/Fetch_bill_Widget.dart';


class Wallet_View extends StatefulWidget{
  Opertaor_list? op_model;
   Home_List_Model? list;
  Bill_Fetch_Model? bill_fetch_model;



  Wallet_View(Opertaor_list op_model, Home_List_Model? list, Bill_Fetch_Model? bill_fetch_model){
    this.op_model=op_model;
    this.list=list;
    this.bill_fetch_model=bill_fetch_model;

  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}

class Build_State extends State<Wallet_View>{

  List<Wallet_option_Model>options=[];
  int selected=0;
  bool loading=false;

  @override
  void initState()   {
    super.initState();
    options.add(new Wallet_option_Model("Pay by Credit/Debit Card/UPI",""));
     create_log();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppUtils.appBar(context, "Cost Sheet"),
      body: new Stack(
        children: [
          Container(child: new SingleChildScrollView(
            child: new Column(
              children: [
                if(widget.bill_fetch_model!=null)Fetch_bill_Widget(widget.bill_fetch_model),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: options.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return
                      InkWell(child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 5,top: 10),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5),
                              border: new Border.all(width: 1,color:selected==index?ColorFile.yellowdark: ColorFile.lightgray),
                              color: ColorFile.white
                          ),

                          width: (MediaQuery.of(context).size.width/2)-15,
                          alignment: Alignment.center,
                          child:new Row(
                            children: [
                              selected!=index?Icon(Icons.radio_button_off):Icon(Icons.radio_button_checked,color: ColorFile.yellowdark,),
                              new SizedBox(width: 10,),
                              Expanded(child: new Container(child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Container(child: new Text(options[index].title,style: new TextStyle(fontFamily: "medium",fontSize: 12),),),
                                ],
                              ),)),
                            ],
                          )
                      ),onTap: (){
                        setState(() {
                          selected=index;
                        });
                      },);
                  },
                ),


              ],
            ),
          ),margin: EdgeInsets.all(10),),
          if(loading==true)Center(child: new CircularProgressIndicator(),)


        ],
      ),
      bottomNavigationBar: new Container(
        padding: EdgeInsets.all(10),
        color: ColorFile.white,
        height: 100,
        child: new Row(
          children: [
            Expanded(child: new Container(child:new Text("₹ "+widget.bill_fetch_model!.amount.toString(),style: new TextStyle(fontFamily: "bold",fontSize: 18,color: ColorFile.selectd_color),),)),
            InkWell(onTap: () async {
              save_transations(selected);
            },child: new Container(alignment: Alignment.center,height: 45,padding: EdgeInsets.only(left: 15,right: 15),decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(10),color: ColorFile.yellowdark),child: new Text("Continue",style: new TextStyle(fontFamily: "medium",color: ColorFile.black,fontSize: 15),),),)


          ],
        ),
      ),
    );
  }

    online_payment(String reference_id) async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    String order_id=reference_id.toString();
    setState(() {loading=true;});
    var map = new Map<String, dynamic>();
    map['order_id'] =order_id;
    map['order_amount'] =widget.bill_fetch_model!.amount.toString();
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
        String your_app_id=response.data["your_app_id"];
        do_payment(token,stage,your_app_id,order_id);

      }
    }).catchError((error, stackTrace) {
      AppUtils.toAst(error.toString(),context);
      setState(() {
        loading=false;
      });
    });
  }
    Future<void> do_payment(String token, String stage1, String your_app_id, String order_id) async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    String stage = stage1;
    String orderId = order_id;
    String orderAmount = widget.bill_fetch_model!.amount.toString();
    String customerName = widget.bill_fetch_model!.name.toString();
    String orderNote = "Notes";
    String orderCurrency = "INR";
    String appId = your_app_id.toString();
    String customerPhone = prefNew.getString("mobile").toString();
    String customerEmail = prefNew.getString("email").toString();
    String notifyUrl = "https://app.peprop.money/apis/cashfree/index";



    // String notifyUrl = "https://test.gocashfree.com/notify";
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
    print(inputParams.toString());
    CashfreePGSDK.doPayment(inputParams).then((value) {
               print("success_respo"+value.toString());
               String txStatus=value!["txStatus"];

              if(txStatus=="SUCCESS"){
                String orderAmount=value["orderAmount"];
                String paymentMode=value["paymentMode"];
                String orderId=value["orderId"];
                String txTime=value["txTime"];
                String signature=value["signature"];
                String referenceId=value["referenceId"];
                save_history(orderAmount,paymentMode,orderId,txTime,signature,referenceId,order_id);

              }else{
                AppUtils.toAst("Payment Declined..!!",context);
              }
    }).catchError((onError){
      AppUtils.toAst("Payment Declined..!!",context);

    });
  }

    Future<void> save_history(String orderAmount,String paymentMode,String orderId,String txTime,String signature,String referenceId, String order_id) async {
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
    setState(() {
      loading=true;
    });


    var _map = <String, dynamic>{
      "operator":widget.op_model!.operator_id.toString(),
      "canumber":widget.op_model!.ca_number.toString(),
      "referenceid":order_id,
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
      "message":"Bill payment",
      "paymentTypeAmount":widget.bill_fetch_model!.amount.toString(),
      "paymentType":paymentMode,
      "response_code":widget.bill_fetch_model!.response_code.toString(),
      "category":widget.list!.alt.toString(),


    };
    print(json.encode(_map));
    FormData customerData = FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.payBill, customerData, context).then((value) async {
      Response response = value;
      setState(() {
        loading=false;
      });
      if (response != null && response.statusCode == 200) {
        print("pay bill response"+response.data.toString());
        bool status=response.data["status"] as bool;
        if(status!=false){
          var response=await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Thank_You(orderAmount:orderAmount,referenceId:referenceId)));
          if(response!=null){
            Navigator.pop(context,"response");
          }

        }else{
          AppUtils.toAst("Something Went Wrong: v100",context);
        }





      }
    }).catchError((error, stackTrace) {
      setState(() {
        loading=false;
      });
    });

  }






  Future<void> save_transations(int selected) async {
    AppUtils().showProgressDialog(context);
    final SharedPreferences prefNew =await SharedPreferences.getInstance();
      var _map = <String, dynamic>{
      "response_code":widget.bill_fetch_model!.response_code.toString(),
      "operator":widget.op_model!.operator_id.toString(),
      "canumber":widget.op_model!.ca_number.toString(),
      "amount":widget.bill_fetch_model!.amount.toString(),
      "mode":"Peprop",
      "billdate":DateFormat('yyyy-MM-dd').format(new DateTime.now()),
      "dueDate":widget.bill_fetch_model!.duedate.toString(),
      "acceptPayment":1,
      "acceptPartPay":0,
      "cellNumber":prefNew.getString("mobile").toString(),
      "userName":widget.bill_fetch_model!.name.toString(),
      "user_id":prefNew.getString("user_id").toString(),
      "message":"Bill payment"

      };
      print(json.encode(_map));
      FormData form_Data = new FormData.fromMap(_map);
      Response response=await ServiceConfig().postApiBodyAuthJson(API.saveBillDetail, form_Data, context);
      Navigator.of(context, rootNavigator: true).pop("Discard");
      print("save bill"+response.data.toString());
      if(response!=null&&response.statusCode==200){
        String reference_id=response.data["data"]["reference_id"].toString();

          online_payment(reference_id);


     }




  }

  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("Bill Payment Options", "Bill Payment Options");

  }

}