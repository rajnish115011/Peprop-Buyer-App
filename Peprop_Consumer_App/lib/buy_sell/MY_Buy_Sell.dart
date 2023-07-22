

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/Account_Statement_Medels.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/buy_sell/Buy_Sell_Details.dart';
import 'package:peprop_consumer_app/dashboard_model/Home_Model.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Color/ColorFile.dart';
import '../Models/Buy_Sell_Model.dart';
import '../wish_list/Styles.dart';
import 'My_By_sell_Widget.dart';

class MY_Buy_Sell extends StatefulWidget{


   String type="";

  MY_Buy_Sell(String type){
    this.type=type;

  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Build_State();
  }

}
class Build_State extends State<MY_Buy_Sell> {

  bool _isLoading = true;
  String start_date = "";
  String end_date = "";
  List<Buy_Sell_Model>my_list = [];

  @override
  void initState() {
    get_Data(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
    Scaffold(
        appBar: AppUtils.appBarTitle(context, widget.type=="1"?"Listing For Requirement":"Listing To Sell"),
        backgroundColor: ColorFile.white,
        body:
        Stack(
          children: [
            _isLoading == true? Center(child: new CircularProgressIndicator(),):
            ListView.builder(
                shrinkWrap: false,
                physics:  BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
                itemCount: my_list.length,
                itemBuilder: (context, index) {
                  return new InkWell(child: My_By_sell_Widget(my_list[index]),onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Buy_Sell_Details(my_list[index],widget.type)));

                  },);



                }),
            if(my_list.length == 0 && _isLoading == false)Center(child: No_Data_Placeholder("No Record Found..!!"),)

          ],
        ));
  }

  get_Data(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    var map = new Map<String, dynamic>();
    map['lease'] = widget.type;
    FormData formData = new FormData.fromMap(map);
    print(json.encode(map));
    ServiceConfig().postApiBodyAuthJson(API.crm_customer_requirment_list, formData, context).then((value) {
      Response response = value;
      print('resoponse  message $response');
      setState(() {
        _isLoading = false;
      });
      if (response != null && response.statusCode == 200) {
        print(response.data.toString());
        var notify = response.data["list"] as List;
        my_list = notify.map<Buy_Sell_Model>((json) =>Buy_Sell_Model.fromJson(json)).toList();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }).catchError((error, stackTrace) async {
      AppUtils.toAst("Something Went Wrong..!!",context);
      setState(() {
        _isLoading = false;
      });
    });
  }

}