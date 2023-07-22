

import 'dart:convert';

import 'package:peprop_consumer_app/Login/Login.dart';
import 'package:peprop_consumer_app/bill_payment/Wallet/Wallet_View.dart';
import 'package:peprop_consumer_app/bill_payment/model/Bill_Payment_Type_Model.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Filters/Bottom_sheet_For_Area.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/bill_payment/model/Circle_Model.dart';
import 'package:peprop_consumer_app/widgets/Form_Fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/FireBase_Logs.dart';
import '../../dashboard_model/Home_Model.dart';
import '../../widgets/App_Banners.dart';
import '../../widgets/Bill_Payment_Form_With_Change.dart';
import '../../widgets/Boottom_Button.dart';
import '../../widgets/Fetch_bill_Widget.dart';
import '../Error_Bottom_Sheet.dart';

class Electricity_Bill_Payment extends StatefulWidget{
  late Opertaor_list op_model;
   Home_List_Model? list;
  Electricity_Bill_Payment(Opertaor_list op_model, Home_List_Model? list){
    this.op_model=op_model;
    this.list=list;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}

class Build_state extends State<Electricity_Bill_Payment>{
 final provider=TextEditingController();
 final cosumer_number=TextEditingController();
 bool loading=false;

 Bill_Fetch_Model? bill_fetch_model;

 @override
 void initState() {
   super.initState();

   method();


 }

  @override
  Widget build(BuildContext context) {
     provider.text=widget.op_model.name;

    return Scaffold(
      backgroundColor: ColorFile.white,
      appBar: AppUtils.appBar(context, "Cost Sheet"),
      body: new Stack(
        children: [
          SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(widget.list!.alt.toLowerCase().contains("payment")?widget.list!.alt.toString():widget.list!.alt.toString(), style: new TextStyle(fontFamily: "bold", fontSize: 22)), new SizedBox(height: 20,),
                        new Devider_size(15),
                        Form_Fields().label_with_change("Select your Operator", provider, true,context,widget.op_model),
                        new Devider_size(20),
                        Bill_Payment_Form_With_Change("Consumer ID", cosumer_number,bill_fetch_model==null? false:true,on_slected: (){
                          setState(() {
                            bill_fetch_model=null;
                          });

                        },),
                        if(widget.list!=null&&widget.list!.sliders.length>0)App_Banners(widget.list!.sliders,context),
                        if(bill_fetch_model!=null&&double.parse(bill_fetch_model!.amount!)>0)Fetch_bill_Widget(bill_fetch_model)


                      ],
                    )),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child:Boottom_Button(loading,bill_fetch_model!=null&&double.parse(bill_fetch_model!.amount!)>0?"Pay ₹ "+bill_fetch_model!.amount.toString():"Fetch Bill",onclick: () async {
            if(bill_fetch_model!=null&&double.parse(bill_fetch_model!.amount!)>0){

              widget.op_model.ca_number=cosumer_number.text.toString();
              var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wallet_View(widget.op_model,widget.list,bill_fetch_model)));



            }else{
              SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
              if(sharedPreferences.getString("token").toString()!="null"){
                if(validate()){
                  get_bill();
                }
              }else{
                AppUtils.toAst("Please Login First...!!!",context);
                var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));

              }

            }


          },)


      ),

    );
  }




 Future<void> get_bill() async {
    setState(() {
     loading = true;
   });
   final SharedPreferences prefNew =await SharedPreferences.getInstance();
   String? user_id=prefNew.getString("user_id");
   Map map={
     "operator":widget.op_model.operator_id.toString(),
     "canumber":cosumer_number.text.toString(),
     "mode":"Online",
     "user_id":user_id};
   print(json.encode(map));
   ServiceConfig().postApiBodyAuthJson(API.fetchBillDetails,map, context).then((value) {
     Response response = value;
     setState(() {
       loading = false;
     });
     print(response.toString());
     if (response != null && response.statusCode == 200&&response.data["billDetail"]["amount"]!=null) {
       var builder_details = response.data["billDetail"];
       bill_fetch_model = Bill_Fetch_Model.fromJson(builder_details);
       if(double.parse(bill_fetch_model!.amount!)==0){
         AppUtils().show_error(context,"No Pending bill found..!!");
       }
     }else if(response.data["billDetail"]==null){
       AppUtils().show_error(context,response.data["message"].toString());
     }else if(response.data["billDetail"]["response_code"].toString()=="0"){
       AppUtils().show_error(context,response.data["billDetail"]["message"].toString());
     }else{
       AppUtils().show_error(context,response.data["msg"].toString()!=null?response.data["msg"].toString():"");
     }
   }).catchError((onError){
     setState(() {
       loading = false;
     });
   });

 }

  bool validate() {
    if(cosumer_number.text.length==0){
      AppUtils.toAst("Please Enter Valid Consumer Number",context);
      return false;
    }


    return true;
  }

 Future<void> method() async {
   await FireBase_Logs().log_screen_view("Bill Payment", "Bill Payment");

 }


}