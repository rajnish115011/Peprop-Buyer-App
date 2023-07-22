

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';

import 'package:peprop_consumer_app/bill_payment/model/Bill_Payment_Type_Model.dart';
import 'package:peprop_consumer_app/bill_payment/model/Circle_Model.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/widgets/Custom_Scorll_Bar.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/FireBase_Logs.dart';
import '../../widgets/Form_Fields.dart';
import '../Forms/Electricity_Bill_Payment.dart';


class Operator_List extends StatefulWidget{

  Home_List_Model? list;
  Operator_List(Home_List_Model list){
    this.list=list;
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_state();
  }

}class Build_state extends State<Operator_List>{
  bool loading=false;
  List<Opertaor_list>all_op_list=[];
  List<Opertaor_list>filter_op_list=[];

  final search_contoller=TextEditingController();

  @override
  void initState() {
    super.initState();
    get_board();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppUtils.appBar(context, ""),
      backgroundColor: Colors.white,
      body:new Stack(
        children: [
            if(loading==true)Center(child: new CircularProgressIndicator(),)
            else Custom_Scorll_Bar(widget.list!.alt,filter_op_list,search_contoller,on_tap: (op_model){
              var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Electricity_Bill_Payment(op_model,widget.list)));

              // if(widget.model.index==1){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Water_Bill_Payment(op_model,widget.model)));
            // }
            // if(widget.model.index==2){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gas_Fill_Form(op_model,widget.model)));
            // }
            // if(widget.model.index==3){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loand_Repayment(op_model,widget.model)));
            // }if(widget.model.index==4){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => BroadBand_Bill_Payment(op_model,widget.model)));
            // }
            // if(widget.model.index==5){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Postpaid_Bill_Payment(op_model,widget.model)));
            // }
            // if(widget.model.index==6){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Insurance(op_model,widget.model)));
            // }
            // if(widget.model.index==7){
            //   var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => MCD_Payment(op_model,widget.model)));
            // }


          },onchanged: (value){
             setState(() {
               onchanged(value);
             });


          },),

        ],
      )
    );
  }


  Future<void> get_board() async {
    await FireBase_Logs().log_screen_view("View Operator List", "View Operator List");


    setState(() {loading = true;});
    Map map={"category_id":widget.list!.id.toString(),};
    json.encode("body"+map.toString());
    ServiceConfig().postApiBodyAuthJson(API.operatorList,map, context).then((value) {
      Response response = value;
      setState(() {
        loading = false;
      });
      if (response != null && response.statusCode == 200) {
        print(response.toString());
        var offer = response.data["data"] as List;
        all_op_list =offer.map<Opertaor_list>((json) => Opertaor_list.fromJson(json)).toList();
        filter_op_list =offer.map<Opertaor_list>((json) => Opertaor_list.fromJson(json)).toList();



      }
    }).catchError((onError){

      setState(() {
        loading = false;
      });
    });




  }

  void onchanged(String value) {
    if(value.isEmpty){
      setState(() {
        filter_op_list.clear();
        filter_op_list.addAll(all_op_list);
      });
    }else{
        filter_op_list.clear();
         all_op_list.forEach((element) {
        if(element.name.toString().toLowerCase().contains(value.toString().toLowerCase())){
        filter_op_list.add(element);
        }
      });
      setState(() {

      });
    }
  }
  }



